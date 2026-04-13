import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';
import '../widgets/glass_panel.dart';
import 'calling_page.dart';
import 'navigation_guide_page.dart';

class NavigationPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const NavigationPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Mock Satellite Map Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/map_placeholder.png',
              fit: BoxFit.cover,
            ),
          ),

          // Top Navigation Bar
          Positioned(
            top: 50,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFB7131A),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'ĐANG DI CHUYỂN',
                    style: AppTextStyles.fontInter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFFB7131A),
                    ),
                  ),
                  const Spacer(),
                  const VerticalDivider(width: 20, thickness: 1),
                  const Icon(
                    Icons.navigation,
                    size: 16,
                    color: Color(0xFF2563EB),
                  ),
                  const Gap(8),
                  const Text(
                    'Hướng Bắc',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),

          // Destination Marker Info
          Positioned(
            top: 150,
            right: 20,
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavigationGuidePage(data: data),
                  ),
                );
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    const Icon(Icons.location_on, color: Color(0xFFBA1A1A)),
                    const Gap(8),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'ĐIỂM ĐẾN',
                          style: AppTextStyles.fontInter(
                            fontSize: 10,
                            color: AppColors.onSurfaceVariant,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          data['address'] ?? 'Vị trí hiện tại',
                          style: AppTextStyles.fontInter(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom ETA Glass Panel
          Positioned(
            bottom: 120,
            left: 20,
            right: 20,
            child: GlassPanel(
              borderRadius: BorderRadius.circular(24),
              opacity: 0.8,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _StatItem(
                          label: 'THỜI GIAN ĐẾN',
                          value: '10',
                          unit: 'phút',
                        ),
                        _StatItem(
                          label: 'KHOẢNG CÁCH',
                          value: '1.2',
                          unit: 'km',
                        ),
                      ],
                    ),
                    const Gap(24),
                    Row(
                      children: [
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.chat_bubble_outline,
                            label: 'Nhắn tin',
                            color: Colors.white,
                            textColor: Colors.black,
                          ),
                        ),
                        const Gap(12),
                        Expanded(
                          child: _ActionButton(
                            icon: Icons.call_outlined,
                            label: 'Gọi điện',
                            color: const Color(0xFF0061A5),
                            textColor: Colors.white,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CallingPage(data: data),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom Nav Bar
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: RescuerBottomNavBar(
              currentIndex: 1,
              onTabSelected: (index) {
                if (index != 1) {
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

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final String unit;
  const _StatItem({
    required this.label,
    required this.value,
    required this.unit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 8,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const Gap(4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              value,
              style: AppTextStyles.fontManrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0061A5),
              ),
            ),
            const Gap(4),
            Text(
              unit,
              style: AppTextStyles.fontInter(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0061A5),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
          border: color == Colors.white
              ? Border.all(color: Colors.grey.shade300)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: textColor),
            const Gap(8),
            Text(
              label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
