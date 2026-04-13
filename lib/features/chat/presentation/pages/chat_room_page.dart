import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'ai_sathi_page.dart';

class ChatRoomPage extends StatefulWidget {
  final String chatName;
  const ChatRoomPage({super.key, required this.chatName});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final List<Map<String, dynamic>> _messages = [
    {
      'isAi': false,
      'text': 'Tôi cảm thấy không khỏe.',
      'time': '7:20',
    },
    {
      'isAi': true,
      'text': 'Tôi rất tiếc khi bạn cảm thấy không khỏe. Bạn có thể cho tôi biết thêm một chút về những gì bạn đang trải qua, chẳng hạn như các triệu chứng, khi nào chúng bắt đầu và mức độ nghiêm trọng như thế nào không?',
      'time': '7:20',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          const Gap(16),
          _buildTabs(),
          const Gap(24),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return _buildMessage(msg);
              },
            ),
          ),
          _buildInputBar(),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        onPressed: () => Navigator.pop(context),
      ),
      centerTitle: true,
      title: Image.asset(
        'assets/images/logo.png',
        width: 80,
        height: 35,
        fit: BoxFit.contain,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Icon(Icons.notifications_none, color: AppColors.textPrimary, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabs() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: _buildTabButton('New Chat', isSelected: true),
          ),
          const Gap(12),
          Expanded(
            child: _buildTabButton('Previous Chats', hasDropdown: true),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, {bool isSelected = false, bool hasDropdown = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : AppColors.primaryDeep,
        borderRadius: BorderRadius.circular(12),
        gradient: isSelected ? null : const LinearGradient(
          colors: [AppColors.primaryDeep, AppColors.primary],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: AppTextStyles.bodySemiBold.copyWith(
              color: Colors.white,
              fontSize: 14,
            ),
          ),
          if (hasDropdown) ...[
            const Gap(8),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 18),
          ],
        ],
      ),
    );
  }

  Widget _buildMessage(Map<String, dynamic> msg) {
    bool isAi = msg['isAi'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: isAi ? MainAxisAlignment.start : MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (isAi) _buildAiAvatar(),
          const Gap(8),
          Flexible(
            child: Column(
              crossAxisAlignment: isAi ? CrossAxisAlignment.start : CrossAxisAlignment.end,
              children: [
                _buildBubble(msg['text'], isAi),
                const Gap(4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                   if(!isAi) ...[
                      const Icon(Icons.check, size: 12, color: AppColors.textSecondary),
                      const Gap(4),
                   ],
                   Text(
                      msg['time'],
                      style: AppTextStyles.bodyRegular.copyWith(
                        fontSize: 10,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Gap(8),
          if (!isAi) _buildUserAvatar(),
        ],
      ),
    );
  }

  Widget _buildBubble(String text, bool isAi) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 280),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isAi ? AppColors.primary : AppColors.borderGrayLight,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(16),
          topRight: const Radius.circular(16),
          bottomLeft: Radius.circular(isAi ? 0 : 16),
          bottomRight: Radius.circular(isAi ? 16 : 0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppTextStyles.fontInter(
              color: isAi ? Colors.white : AppColors.textPrimary,
              fontSize: 14,
              height: 1.4,
            ),
          ),
          if (isAi) ...[
            const Gap(12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionIcon(Icons.copy_rounded),
                const Gap(8),
                _buildActionIcon(Icons.thumb_up_outlined),
                const Gap(8),
                _buildActionIcon(Icons.thumb_down_outlined),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActionIcon(IconData icon) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.brandLightBlue,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(icon, color: Colors.white, size: 14),
    );
  }

  Widget _buildAiAvatar() {
    return Container(
      width: 40,
      height: 40,
      decoration: const BoxDecoration(
        color: AppColors.primary,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/chat_bot_logo.svg',
          width: 24,
          height: 24,
        ),
      ),
    );
  }

  Widget _buildUserAvatar() {
    return ClipOval(
      child: Image.asset(
        'assets/images/avatar_1.png',
        width: 40,
        height: 40,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInputBar() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AiSathiPage()),
              );
            },
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: AppColors.brandLightBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.mic, color: Colors.white),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Send a message.',
                        hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(Icons.send, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
