import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'dart:async';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';
import 'active_mission_page.dart';

class MissionAcceptedPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const MissionAcceptedPage({
    super.key,
    required this.data,
  });

  @override
  State<MissionAcceptedPage> createState() => _MissionAcceptedPageState();
}

class _MissionAcceptedPageState extends State<MissionAcceptedPage> {
  @override
  void initState() {
    super.initState();
    final navigator = Navigator.of(context);
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        navigator.pushReplacement(
          MaterialPageRoute(
            builder: (context) => ActiveMissionPage(data: widget.data),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/images/logo.png',
          height: 24,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, color: AppColors.primary),
        ),
        centerTitle: true,
        actions: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=rescuer'),
          ),
          const Gap(16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const Gap(20),
            // Success Icon Box
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: const Color(0xFFE6F7F0),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Icon(
                Icons.check_circle,
                color: Color(0xFF00A651),
                size: 50,
              ),
            ),
            const Gap(32),
            
            // Title and Subtitle
            Text(
              'Nhận nhiệm vụ thành công',
              style: AppTextStyles.fontManrope(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
                letterSpacing: -0.5,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(12),
            Text(
              'Bạn đã được phân công hỗ trợ tại khu vực Quận Liên Chiểu.',
              style: AppTextStyles.fontInter(
                fontSize: 14,
                color: AppColors.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const Gap(40),
            
            // Route Details Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFF1F3F4).withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: const Color(0xFFD4E5FF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'CHI TIẾT LỘ TRÌNH',
                      style: AppTextStyles.fontInter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF001D40),
                      ),
                    ),
                  ),
                  const Gap(24),
                  
                  // Start Point
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PointMarker(color: Colors.blue, isDashed: true),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ĐIỂM BẮT ĐẦU',
                              style: AppTextStyles.fontInter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              'Trung tâm Điều phối SafeZone',
                              style: AppTextStyles.fontInter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              '02 Phan Đăng Lưu, Đà Nẵng',
                              style: AppTextStyles.fontInter(
                                fontSize: 13,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(24),
                  
                  // End Point
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _PointMarker(color: Colors.red, isDashed: false),
                      const Gap(16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'ĐIỂM ĐẾN (ƯU TIÊN CAO)',
                              style: AppTextStyles.fontInter(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              'Sự cố ngập lụt',
                              style: AppTextStyles.fontInter(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            const Gap(4),
                            Text(
                              widget.data['address'] ?? '24 Trần Phú, Đà Nẵng',
                              style: AppTextStyles.fontInter(
                                fontSize: 13,
                                color: AppColors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const Gap(32),
                  const Divider(height: 1, color: Color(0xFFE0E0E0)),
                  const Gap(24),
                  
                  // Distance & Time
                  Row(
                    children: [
                      Expanded(
                        child: _StatBox(
                          label: 'KHOẢNG CÁCH',
                          value: widget.data['distance'] ?? '1.2 km',
                        ),
                      ),
                      const Gap(12),
                      Expanded(
                        child: _StatBox(
                          label: 'THỜI GIAN DỰ KIẾN',
                          value: '10 phút', // Mock according to Image 1
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(120),
          ],
        ),
      ),
      bottomNavigationBar: RescuerBottomNavBar(
        currentIndex: 0,
        onTabSelected: (index) {
          if (index != 0) {
            RescuerBottomNavBar.navigateToTab(context, index);
          }
        },
      ),
    );
  }
}

class _PointMarker extends StatelessWidget {
  final Color color;
  final bool isDashed;
  const _PointMarker({required this.color, required this.isDashed});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 2),
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.3),
                blurRadius: 4,
                spreadRadius: 2,
              )
            ],
          ),
        ),
        if (isDashed) 
          Container(
            width: 2,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.3),
            ),
          ),
      ],
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;

  const _StatBox({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.fontInter(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const Gap(8),
          Text(
            value,
            style: AppTextStyles.fontManrope(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF0061A4),
            ),
          ),
        ],
      ),
    );
  }
}
