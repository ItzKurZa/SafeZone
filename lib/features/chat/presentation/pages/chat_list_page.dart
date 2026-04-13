import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import 'chat_room_page.dart';

class ChatListPage extends StatelessWidget {
  const ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(AppSpacing.md),
            // Header: Date, Logo, Notif, Profile
            _buildHeader(),
            const Gap(AppSpacing.xl),

            // Title "Nhắn tin"
            Text(
              'Nhắn tin',
              style: AppTextStyles.fontPoppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(AppSpacing.sm),

            // Search bar
            _buildSearchBar(),
            const Gap(AppSpacing.lg),

            // Chat List
            _ChatTile(
              name: 'Bố',
              recentMessage: 'Bạn: Dạ',
              avatarAsset: 'assets/images/avatar_1.png',
              onTap: () => _openChat(context, 'Bố'),
            ),
            _ChatTile(
              name: 'Mẹ',
              recentMessage: 'Bạn: Dạ',
              avatarAsset: 'assets/images/avatar_2.png',
              onTap: () => _openChat(context, 'Mẹ'),
            ),
            _ChatTile(
              name: 'Anh 2',
              recentMessage: 'Bạn: Dạ',
              avatarAsset: 'assets/images/avatar_1.png',
              onTap: () => _openChat(context, 'Anh 2'),
            ),
            _ChatTile(
              name: 'Anh 3',
              recentMessage: 'Bạn: Dạ',
              avatarAsset: 'assets/images/avatar_1.png',
              onTap: () => _openChat(context, 'Anh 3'),
            ),

            const Gap(AppSpacing.lg),

            // Chat with me Card
            _buildChatBotCard(context),

            // Bottom padding to avoid nav bar overlap
            const Gap(100),
          ],
        ),
      ),
    );
  }

  void _openChat(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatRoomPage(chatName: name)),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/avatar_1.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 4,
                  child: Container(
                    width: 7.3,
                    height: 7.3,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Image.asset(
          'assets/images/logo.png',
          width: 91,
          height: 91,
          fit: BoxFit.contain,
        ),
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.border),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/icon_bell.svg',
              width: 24,
              height: 24,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 43,
      decoration: BoxDecoration(
        color: AppColors.backgroundGray,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          const Gap(12),
          SvgPicture.asset(
            'assets/icons/icon_search.svg',
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.iconGray,
              BlendMode.srcIn,
            ),
          ),
          const Gap(8),
          Text(
            'Search',
            style: AppTextStyles.fontInter(
              fontSize: 16,
              color: AppColors.iconGray,
              letterSpacing: -0.4,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBotCard(BuildContext context) {
    return GestureDetector(
      onTap: () => _openChat(context, 'SafeZone AI'),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 28),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.2),
              blurRadius: 15,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/chat_bot_logo.svg',
                  width: 32,
                  height: 33,
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Chat with me',
                    style: AppTextStyles.fontPoppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatTile extends StatelessWidget {
  final String name;
  final String recentMessage;
  final String avatarAsset;
  final VoidCallback onTap;

  const _ChatTile({
    required this.name,
    required this.recentMessage,
    required this.avatarAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                avatarAsset,
                width: 37,
                height: 39,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        name,
                        style: AppTextStyles.fontPoppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Now',
                        style: AppTextStyles.fontRoboto(
                          fontSize: 10,
                          color: AppColors.iconGray,
                        ),
                      ),
                    ],
                  ),
                  const Gap(2),
                  Text(
                    recentMessage,
                    style: AppTextStyles.fontRoboto(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: AppColors.iconGray,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
