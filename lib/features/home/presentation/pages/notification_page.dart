import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundGray,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Notification',
          style: AppTextStyles.titleMedium.copyWith(color: AppColors.textSecondary),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
          child: Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    Stack(
                      children: [
                        const Icon(Icons.notifications_none, color: AppColors.accentBlue, size: 36),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: AppColors.chatBubbleBlueLight,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: AppColors.textPrimary),
                            ),
                            child: const Icon(Icons.close, size: 10, color: AppColors.textPrimary),
                          ),
                        ),
                      ],
                    ),
                    const Gap(AppSpacing.sm),
                    Text(
                      'Thông Báo',
                      style: AppTextStyles.titleMedium.copyWith(color: AppColors.accentBlue, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.chatBubbleBlueLighter,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          Text('Mới', style: AppTextStyles.bodyRegular.copyWith(fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
                          const Gap(4),
                          Container(
                            width: 6,
                            height: 6,
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(AppSpacing.lg),

                // Hôm nay section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppColors.chatBubbleBlueLightest,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'Hôm nay',
                        style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                      ),
                    ),
                    Text(
                      'Đọc tất cả',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                  ],
                ),
                const Gap(AppSpacing.md),

                _buildNotificationItem(
                  title: 'Báo cáo hoạt động đáng ngờ',
                  timeAgo: '15 phút trước',
                  distance: '600m',
                  isRed: true,
                  isHighlighted: false,
                ),
                
                // Highlighted background area
                Container(
                  color: AppColors.chatBubblePurpleLight,
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  margin: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                  child: _buildNotificationItem(
                    title: 'Tai nạn chặn đường',
                    timeAgo: '30 phút trước',
                    distance: '300m',
                    isRed: false,
                    isHighlighted: true,
                  ),
                ),

                _buildNotificationItem(
                  title: 'Tai nạn chặn đường',
                  timeAgo: '45 phút trước',
                  distance: '1km',
                  isRed: false,
                  isHighlighted: false,
                ),

                const Gap(AppSpacing.lg),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.chatBubbleBlueLightest,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Hôm qua',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                ),
                const Gap(AppSpacing.lg),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationItem({
    required String title,
    required String timeAgo,
    required String distance,
    required bool isRed,
    required bool isHighlighted,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: isHighlighted ? null : [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: isRed
                    ? const [AppColors.alertRedStart, AppColors.alertRedEnd]
                    : const [AppColors.alertYellowStart, AppColors.alertYellowEnd],
              ),
            ),
            child: const Icon(Icons.priority_high, color: AppColors.white, size: 24),
          ),
          const Gap(12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.bodySemiBold.copyWith(color: AppColors.textPrimary, fontSize: 13),
                ),
                const Gap(2),
                Text(
                  timeAgo,
                  style: AppTextStyles.bodyRegular.copyWith(fontSize: 10),
                ),
              ],
            ),
          ),
          Text(
            distance,
            style: AppTextStyles.bodyRegular.copyWith(fontSize: 10, color: AppColors.textPrimary, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}