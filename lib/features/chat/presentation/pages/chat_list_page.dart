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
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avatar_1.png',
                      width: 52,
                      height: 52,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.redDot,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Image.asset(
          'assets/images/logo.png',
          width: 100,
          height: 40,
          fit: BoxFit.contain,
        ),
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFE0E0FF),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/icons/icon_bell.svg',
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.textPrimary,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: const Color(0xFFF1F1F1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          const Gap(16),
          SvgPicture.asset(
            'assets/icons/icon_search.svg',
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              AppColors.textSecondary,
              BlendMode.srcIn,
            ),
          ),
          const Gap(12),
          Text(
            'Search',
            style: AppTextStyles.fontInter(
              fontSize: 16,
              color: AppColors.textTertiary,
              letterSpacing: -0.2,
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
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
            color: AppColors.primary.withValues(alpha: 0.1),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/chat_bot_logo.svg',
                  width: 30,
                  height: 30,
                ),
              ),
            ),
            const Gap(16),
            Expanded(
              child: Text(
                'Chat with me',
                style: AppTextStyles.fontPoppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
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
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                avatarAsset,
                width: 48,
                height: 48,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.fontPoppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    recentMessage,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.fontInter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: AppColors.textTertiary,
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
