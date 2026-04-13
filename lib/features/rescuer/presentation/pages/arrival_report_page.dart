import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'mission_tracking_page.dart';
import 'package:safezone/features/rescuer/presentation/pages/incident_capture_page.dart';
import 'package:safezone/features/rescuer/presentation/pages/mission_complete_page.dart';
import 'package:safezone/features/rescuer/presentation/pages/request_backup_page.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';

class ArrivalReportPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const ArrivalReportPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
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
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Current Location Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.location_on, color: Color(0xFF1976D2)),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'VỊ TRÍ HIỆN TẠI',
                          style: AppTextStyles.fontInter(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                          ),
                        ),
                        const Gap(4),
                        Text(
                          data['address'] ?? 'Quận Liên Chiểu, Đà Nẵng',
                          style: AppTextStyles.fontInter(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            
            // Status Cards
            _ReportCard(
              label: 'TRẠNG THÁI HIỆN TRƯỜNG',
              title: 'ĐÃ ĐẾN',
              description: 'Báo cáo bạn đã có mặt tại điểm nóng',
              color: const Color(0xFF42A5F5),
              icon: Icons.check_circle_outline,
              labelColor: const Color(0xFF1976D2),
              titleColor: const Color(0xFF0D47A1),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const IncidentCapturePage()),
              ),
            ),
            const Gap(16),
            _ReportCard(
              label: 'YÊU CẦU KHẨN CẤP',
              title: 'CẦN HỖ TRỢ',
              description: 'Yêu cầu tiếp viện hoặc vật tư y tế',
              color: const Color(0xFF8B6B00),
              icon: Icons.error_outline,
              labelColor: const Color(0xFFFBC02D),
              titleColor: Colors.white,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const RequestBackupPage()),
              ),
            ),
            const Gap(16),
            _ReportCard(
              label: 'HOÀN TẤT NHIỆM VỤ',
              title: 'ĐÃ AN TOÀN',
              description: 'Khu vực đã được kiểm soát hoàn toàn',
              color: const Color(0xFF2E7D32),
              icon: Icons.shield_outlined,
              labelColor: const Color(0xFFA5D6A7),
              titleColor: Colors.white,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MissionCompletePage(data: data)),
              ),
            ),
            const Gap(100),
          ],
        ),
      ),
      bottomNavigationBar: RescuerBottomNavBar(
        currentIndex: 4, // Báo cáo tab
        onTabSelected: (index) {
          if (index != 4) {
            RescuerBottomNavBar.navigateToTab(context, index);
          }
        },
      ),
    );
  }
}

class _ReportCard extends StatelessWidget {
  final String label;
  final String title;
  final String description;
  final Color color;
  final IconData icon;
  final Color labelColor;
  final Color titleColor;
  final VoidCallback onTap;

  const _ReportCard({
    required this.label,
    required this.title,
    required this.description,
    required this.color,
    required this.icon,
    required this.labelColor,
    required this.titleColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Background large icon decoration
            Positioned(
              right: -20,
              top: -20,
              child: Icon(
                icon,
                size: 200,
                color: Colors.white.withValues(alpha: 0.1),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      label,
                      style: AppTextStyles.fontInter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Gap(16),
                  Text(
                    title,
                    style: AppTextStyles.fontManrope(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: titleColor,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    description,
                    style: AppTextStyles.fontInter(
                      fontSize: 13,
                      color: Colors.white.withValues(alpha: 0.8),
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
