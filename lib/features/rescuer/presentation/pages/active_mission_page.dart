import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safezone/features/rescuer/presentation/pages/victim_detail_page.dart';
import 'package:safezone/features/rescuer/presentation/pages/mission_tracking_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/distance_card.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';
import 'navigation_page.dart';

class ActiveMissionPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ActiveMissionPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mock Map Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_placeholder.png',
              fit: BoxFit.cover,
            ),
          ),

          // Red Header
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(16, 44, 16, 12),
              color: const Color(0xFFB7131A),
              child: Row(
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                  const Gap(8),
                  Expanded(
                    child: Text(
                      'KHẨN CẤP: SOS ĐANG HOẠT ĐỘNG',
                      style: AppTextStyles.fontInter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(16),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MissionTrackingPage(),
                        ),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/images/rescuer_nam.png'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Victim Card Overlay
          Positioned(
            top: 150,
            left: 20,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => VictimDetailPage(data: data),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.rescuerPrimary,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: data['image'] != null
                                  ? NetworkImage(data['image'])
                                  : const AssetImage('assets/images/victim_placeholder.png') as ImageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Gap(16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data['name'] ?? 'Người gặp nạn',
                                style: AppTextStyles.fontInter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const Gap(8),
                              Row(
                                children: [
                                  _StatusTag(
                                    label: 'BỊ KẸT TRONG LŨ',
                                    color: const Color(0xFFFFDAD6),
                                    textColor: const Color(0xFF93000A),
                                  ),
                                  const Gap(4),
                                  _StatusTag(
                                    label: 'CẦN Y TẾ',
                                    color: const Color(0xFFD4E5FF),
                                    textColor: const Color(0xFF001D40),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const Divider(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _InfoCol(
                          label: 'VỊ TRÍ HIỆN TẠI',
                          value: (data['address']?.toString() ?? 'Đà Nẵng').split(',')[0],
                        ),
                        _InfoCol(
                          label: 'THỜI GIAN GỬI',
                          value: data['time'] ?? 'Bây giờ',
                          isTime: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Distance Card and Start Button
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: Column(
              children: [
                DistanceCard(
                  distance: '1.2 KM',
                  etaText: 'Khoảng 5 phút di chuyển bằng xuồng cứu hộ',
                ),
                const Gap(16),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavigationPage(data: data),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'BẮT ĐẦU DI CHUYỂN',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Nav Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RescuerBottomNavBar(
              currentIndex: 0,
              onTabSelected: (index) {
                if (index != 0) {
                  RescuerBottomNavBar.navigateToTab(context, index);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTag extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  const _StatusTag({
    required this.label,
    required this.color,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: textColor,
          fontSize: 8,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _InfoCol extends StatelessWidget {
  final String label;
  final String value;
  final bool isTime;
  const _InfoCol({
    required this.label,
    required this.value,
    this.isTime = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.fontInter(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.onSurfaceVariant,
          ),
        ),
        const Gap(4),
        Row(
          children: [
            if (isTime) ...[
              const Icon(Icons.access_time, size: 14, color: Color(0xFFB7131A)),
              const Gap(4),
            ],
            Text(
              value,
              style: AppTextStyles.fontInter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: isTime ? const Color(0xFFB7131A) : AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
