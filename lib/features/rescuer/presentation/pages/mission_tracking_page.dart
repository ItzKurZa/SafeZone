import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';

class MissionTrackingPage extends StatelessWidget {
  final Map<String, dynamic>? data;

  const MissionTrackingPage({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          const CircleAvatar(
            radius: 16,
            backgroundImage: AssetImage('assets/images/rescuer_nam.png'),
          ),
          const Gap(16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'NHIỆM VỤ ĐANG DIỄN RA',
              style: AppTextStyles.fontInter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFBA1A1A),
              ),
            ),
            const Gap(8),
            Text(
              'Cứu hộ Sạt lở\nĐèo Hải Vân',
              style: AppTextStyles.fontManrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0061A5),
                height: 1.2,
              ),
            ),
            const Gap(40),

            // Timeline
            const _TimelineItem(
              title: 'Nhận lệnh',
              description: 'Điều phối viên đã xác nhận tọa độ khẩn cấp. Đội cứu hộ 04 được chỉ định.',
              time: '08:15 AM',
              icon: Icons.assignment_turned_in,
              isCompleted: true,
            ),
            const _TimelineItem(
              title: 'Đang đi',
              description: 'Phương tiện đang di chuyển qua Trạm thu phí Bắc Hải Vân. Tốc độ trung bình 65km/h.',
              time: '08:22 AM',
              icon: Icons.directions_boat, // Boat icon as it's a flood/landslide context often uses specialized vehicles
              isCompleted: true,
              hasLine: true,
              imageAsset: 'assets/images/rescue_van_running.png',
            ),
            const _TimelineItem(
              title: 'Đã đến',
              description: 'Tiếp cận hiện trường thành công.',
              time: '08:45 AM',
              icon: Icons.location_on,
              isCompleted: true,
              isLast: true,
            ),
            
            const Gap(100),
          ],
        ),
      ),
      bottomNavigationBar: RescuerBottomNavBar(
        currentIndex: 0, // Nhiệm vụ tab
        onTabSelected: (index) {
          if (index != 0) {
            RescuerBottomNavBar.navigateToTab(context, index);
          }
        },
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final bool isCompleted;
  final bool isLast;
  final bool hasLine;
  final String? imageAsset;

  const _TimelineItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    this.isCompleted = false,
    this.isLast = false,
    this.hasLine = true,
    this.imageAsset,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Timeline Side
          Column(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isCompleted ? const Color(0xFF0061A5) : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: isCompleted ? Colors.white : Colors.grey,
                  size: 20,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.grey.shade200,
                  ),
                ),
            ],
          ),
          const Gap(20),
          // Right Content Side
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: AppTextStyles.fontInter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Text(
                      time,
                      style: AppTextStyles.fontInter(
                        fontSize: 13,
                        color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
                const Gap(8),
                Text(
                  description,
                  style: AppTextStyles.fontInter(
                    fontSize: 14,
                    color: AppColors.onSurfaceVariant,
                    height: 1.5,
                  ),
                ),
                if (imageAsset != null) ...[
                  const Gap(16),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.asset(
                      imageAsset!,
                      width: double.infinity,
                      height: 160,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainerLow,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
                const Gap(32),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
