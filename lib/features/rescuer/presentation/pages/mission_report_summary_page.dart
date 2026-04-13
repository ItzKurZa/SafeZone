import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';
import '../../../reports/presentation/widgets/report_success_overlay.dart';
import 'rescuer_home_shell.dart';
import 'mission_tracking_page.dart';

class MissionReportSummaryPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isSuccess;
  final String notes;

  const MissionReportSummaryPage({
    super.key,
    required this.data,
    required this.isSuccess,
    required this.notes,
  });

  void _submitReport(BuildContext context) {
    showReportSuccess(
      context,
      () {}, // Callback not needed due to automated delay below
      showButton: false, // Automated 2s redirect for rescuers
    );
    
    Future.delayed(const Duration(seconds: 2), () {
      if (context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const RescuerHomeShell()),
          (route) => false,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'XÁC NHẬN BÁO CÁO',
              style: AppTextStyles.fontInter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF8B6B00),
              ),
            ),
            const Gap(8),
            Text(
              'Tóm tắt báo cáo',
              style: AppTextStyles.fontManrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(32),

            // Critical Info Banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              decoration: const BoxDecoration(
                color: Color(0xFFFFDAD6),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(24),
                  topRight: Radius.circular(24),
                ),
                border: Border(
                  left: BorderSide(color: Color(0xFFBA1A1A), width: 6),
                ),
              ),
              child: Stack(
                children: [
                   Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'MỨC ĐỘ KHẨN CẤP',
                        style: AppTextStyles.fontInter(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFBA1A1A),
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'NGUY HIỂM',
                        style: AppTextStyles.fontManrope(
                          fontSize: 32,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFFBA1A1A),
                        ),
                      ),
                      const Gap(4),
                      Text(
                        'Mã sự cố:\n#SZ-2024-0892',
                        style: AppTextStyles.fontInter(
                          fontSize: 14,
                          color: const Color(0xFFBA1A1A),
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Icon(
                        Icons.warning_amber_rounded,
                        size: 80,
                        color: const Color(0xFFBA1A1A).withValues(alpha: 0.1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            
            // Location Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.location_on, color: Color(0xFF0061A5), size: 18),
                      const Gap(8),
                      Text(
                        'Vị trí sự cố',
                        style: AppTextStyles.fontInter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const Gap(8),
                  Text(
                    'Quận Liên Chiểu, TP. Đà Nẵng',
                    style: AppTextStyles.fontInter(
                      fontSize: 14,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const Gap(20),
                  Container(
                    width: double.infinity,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/map_placeholder.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: Color(0xFFBA1A1A),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.location_on, color: Colors.white, size: 24),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),

            // Incident Details
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.description_outlined, color: Color(0xFF8B6B00), size: 18),
                      const Gap(8),
                      Text(
                        'Chi tiết sự cố',
                        style: AppTextStyles.fontInter(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const Gap(20),
                  _SummaryRow(label: 'Loại:', value: 'Ngập lụt diện rộng'),
                  const Divider(height: 24),
                  _SummaryRow(label: 'Trạng thái:', value: isSuccess ? 'Thành công' : 'Thất bại'),
                  const Divider(height: 24),
                  _SummaryRow(label: 'Ghi chú:', value: notes.isEmpty ? 'Không có ghi chú' : notes),
                ],
              ),
            ),
            const Gap(32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => _submitReport(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.rescuerBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text(
                  'Gửi báo cáo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const Gap(100),
          ],
        ),
      ),
      bottomNavigationBar: RescuerBottomNavBar(
        currentIndex: 4,
        onTabSelected: (index) {
          if (index != 4) {
            RescuerBottomNavBar.navigateToTab(context, index);
          }
        },
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;

  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: AppTextStyles.fontInter(
              fontSize: 14,
              color: AppColors.onSurfaceVariant,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: AppTextStyles.fontInter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ],
    );
  }
}
