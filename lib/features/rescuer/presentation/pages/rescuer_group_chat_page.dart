import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safezone/features/rescuer/presentation/pages/mission_tracking_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';

class RescuerGroupChatPage extends StatelessWidget {
  const RescuerGroupChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 24,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, color: AppColors.primary),
        ),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MissionTrackingPage()),
              );
            },
            child: const CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('assets/images/rescuer_nam.png'),
            ),
          ),
          const Gap(16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade100)),
            ),
            child: Row(
              children: [
                Text(
                  'ĐỘI CỨU HỘ QUẬN 1',
                  style: AppTextStyles.fontInter(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                  ),
                ),
                const Spacer(),
                const SizedBox(
                  width: 80,
                  height: 32,
                  child: Stack(
                    children: [
                      CircleAvatar(radius: 14, backgroundImage: AssetImage('assets/images/team_member_1.png')),
                      Positioned(left: 15, child: CircleAvatar(radius: 14, backgroundImage: AssetImage('assets/images/team_member_2.png'))),
                      Positioned(left: 30, child: CircleAvatar(radius: 14, backgroundColor: Color(0xFFD4E5FF), child: Text('+12', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Color(0xFF001D40))))),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: [
                Center(
                  child: Text(
                    'HÔM NAY, 14 THÁNG 10',
                    style: AppTextStyles.fontInter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.4),
                    ),
                  ),
                ),
                const Gap(32),
                
                // Incoming Message
                _ChatBubble(
                  name: 'Trần Nam (Điều phối)',
                  message: 'Cảnh báo: Có tin báo ngập nặng tại khu vực đường Nguyễn Huệ. Đội 2 đã xuất phát chưa?',
                  time: '09:15 AM',
                  isMe: false,
                  imageAsset: 'assets/images/rescuer_nam.png',
                ),
                const Gap(24),
                
                // Incoming Status Card
                _StatusMessage(
                  name: 'Hoàng Minh (Đội 2)',
                  status: 'Đã đến hiện trường (Arrived)',
                  description: 'Đang triển khai rào chắn.',
                  time: '09:22 AM',
                  imageAsset: 'assets/images/rescuer_minh.png',
                ),
                const Gap(24),
                
                // Outgoing Message
                _ChatBubble(
                  name: 'Bạn',
                  message: 'Tôi đang gửi vị trí của tôi. Khu vực này cần thêm hỗ trợ y tế khẩn cấp.',
                  isMe: true,
                  imageAsset: 'assets/images/rescuer_nam.png',
                ),
                const Gap(16),
                
                // Map Attachment
                _MapAttachment(),
                const Gap(100), // Bottom padding
              ],
            ),
          ),
          
          // Quick actions and input
          _ChatInputArea(),
        ],
      ),
      bottomNavigationBar: RescuerBottomNavBar(
        currentIndex: 3, // Chat tab
        onTabSelected: (index) {
          if (index != 3) {
            RescuerBottomNavBar.navigateToTab(context, index);
          }
        },
      ),
    );
  }
}

class _ChatBubble extends StatelessWidget {
  final String name;
  final String message;
  final String? time;
  final bool isMe;
  final String? imageAsset;

  const _ChatBubble({
    required this.name,
    required this.message,
    this.time,
    required this.isMe,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        if (!isMe) ...[
          CircleAvatar(
            radius: 20,
            backgroundImage: imageAsset != null
                ? AssetImage(imageAsset!)
                : null,
            child: imageAsset == null ? const Icon(Icons.person) : null,
          ),
          const Gap(12),
        ],
        Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Text(
              isMe ? 'Bạn' : name,
              style: AppTextStyles.fontInter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isMe ? const Color(0xFFBA1A1A) : const Color(0xFF8B6B00),
              ),
            ),
            const Gap(8),
            Container(
              constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.65),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isMe ? const Color(0xFFBA1A1A) : Colors.white,
                borderRadius: BorderRadius.circular(16).copyWith(
                  topLeft: isMe ? const Radius.circular(16) : Radius.zero,
                  bottomRight: isMe ? Radius.zero : const Radius.circular(16),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: !isMe ? Border.all(color: Colors.grey.shade100) : null,
              ),
              child: Text(
                message,
                style: AppTextStyles.fontInter(
                  fontSize: 15,
                  color: isMe ? Colors.white : AppColors.textPrimary,
                  height: 1.4,
                ),
              ),
            ),
            if (time != null) ...[
              const Gap(8),
              Text(
                time!,
                style: AppTextStyles.fontInter(
                  fontSize: 10,
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
            ],
          ],
        ),
        if (isMe) ...[
          const Gap(12),
          CircleAvatar(
            radius: 20, 
            backgroundColor: const Color(0xFFBA1A1A),
            child: const Text('B', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ],
    );
  }
}

class _StatusMessage extends StatelessWidget {
  final String name;
  final String status;
  final String description;
  final String time;
  final String? imageAsset;

  const _StatusMessage({
    required this.name,
    required this.status,
    required this.description,
    required this.time,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: imageAsset != null
              ? AssetImage(imageAsset!)
              : null,
          child: imageAsset == null ? const Icon(Icons.person) : null,
        ),
        const Gap(12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: AppTextStyles.fontInter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8B6B00),
              ),
            ),
            const Gap(8),
            Container(
              width: MediaQuery.of(context).size.width * 0.65,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16).copyWith(topLeft: Radius.zero),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: Colors.grey.shade100),
              ),
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F3F4),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.check_circle_outline, color: Color(0xFF8B6B00)),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status,
                          style: AppTextStyles.fontInter(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const Gap(4),
                        Text(
                          description,
                          style: AppTextStyles.fontInter(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(8),
            Text(
              time,
              style: AppTextStyles.fontInter(
                fontSize: 10,
                color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _MapAttachment extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      margin: const EdgeInsets.only(right: 52, left: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: const DecorationImage(
          image: AssetImage('assets/images/map_placeholder.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
    );
  }
}

class _ChatInputArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          // Quick actions
          Row(
            children: [
              _QuickAction(icon: Icons.check, label: 'Arrived', color: const Color(0xFF42A5F5)),
              const Gap(8),
              _QuickAction(icon: Icons.emergency_share, label: 'Need Backup', color: const Color(0xFFBA1A1A)),
              const Gap(8),
              _QuickAction(icon: Icons.location_on, label: 'Send Location', color: const Color(0xFFE0E0E0), textColor: Colors.black),
            ],
          ),
          const Gap(16),
          // Input
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline, color: AppColors.onSurfaceVariant)),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8F9FA),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey.shade200),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Nhập tin nhắn cho đội...',
                            hintStyle: AppTextStyles.fontInter(fontSize: 14, color: AppColors.onSurfaceVariant.withValues(alpha: 0.5)),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Icon(Icons.image_outlined, color: AppColors.onSurfaceVariant),
                    ],
                  ),
                ),
              ),
              const Gap(12),
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFF42A5F5),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.send, color: Colors.white, size: 20),
              ),
            ],
          ),
          const Gap(8),
        ],
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    this.textColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: textColor, size: 14),
            const Gap(6),
            Text(
              label,
              style: AppTextStyles.fontInter(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
