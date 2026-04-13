import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';
import 'mission_report_summary_page.dart';
import 'mission_tracking_page.dart';

class MissionReportFormPage extends StatefulWidget {
  final Map<String, dynamic> data;

  const MissionReportFormPage({
    super.key,
    required this.data,
  });

  @override
  State<MissionReportFormPage> createState() => _MissionReportFormPageState();
}

class _MissionReportFormPageState extends State<MissionReportFormPage> {
  bool? _isSuccess;
  final TextEditingController _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
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
              'CẬP NHẬT TRẠNG THÁI',
              style: AppTextStyles.fontInter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFBA1A1A),
              ),
            ),
            const Gap(8),
            Text(
              'Báo cáo sau cứu hộ',
              style: AppTextStyles.fontManrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(12),
            Text(
              'Vui lòng cung cấp thông tin chính xác về kết quả xử lý tại hiện trường.',
              style: AppTextStyles.fontInter(
                fontSize: 15,
                color: AppColors.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            const Gap(32),

            // Result Selection
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Kết quả cứu hộ',
                    style: AppTextStyles.fontInter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(20),
                  Row(
                    children: [
                      Expanded(
                        child: _ResultCard(
                          label: 'THÀNH CÔNG',
                          icon: Icons.check_circle_outline,
                          color: const Color(0xFF0061A5),
                          isSelected: _isSuccess == true,
                          onTap: () => setState(() => _isSuccess = true),
                        ),
                      ),
                      const Gap(16),
                      Expanded(
                        child: _ResultCard(
                          label: 'THẤT BẠI',
                          icon: Icons.cancel_outlined,
                          color: const Color(0xFFBA1A1A),
                          isSelected: _isSuccess == false,
                          onTap: () => setState(() => _isSuccess = false),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(24),

            // Field Notes
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Ghi chú hiện trường',
                    style: AppTextStyles.fontInter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(16),
                  TextField(
                    controller: _notesController,
                    maxLines: 5,
                    decoration: InputDecoration(
                      hintText: 'Mô tả chi tiết tình hình, các khó khăn gặp phải và kết quả cụ thể...',
                      hintStyle: AppTextStyles.fontInter(
                        fontSize: 14,
                        color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      fillColor: const Color(0xFFF8F9FA),
                      filled: true,
                    ),
                  ),
                ],
              ),
            ),
            const Gap(32),

            // Submit Button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _isSuccess == null
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MissionReportSummaryPage(
                              data: widget.data,
                              isSuccess: _isSuccess!,
                              notes: _notesController.text,
                            ),
                          ),
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.rescuerBlue,
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.grey.shade300,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 0,
                ),
                child: const Text(
                  'Xác nhận báo cáo',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
            ),
            const Gap(100), // Bottom padding for navbar
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

class _ResultCard extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;

  const _ResultCard({
    required this.label,
    required this.icon,
    required this.color,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 32),
        decoration: BoxDecoration(
          color: isSelected ? color.withValues(alpha: 0.05) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? color : Colors.grey.shade100,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const Gap(12),
            Text(
              label,
              style: AppTextStyles.fontInter(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
