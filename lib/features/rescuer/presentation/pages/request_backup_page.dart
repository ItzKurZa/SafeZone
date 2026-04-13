import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'mission_tracking_page.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';
import 'package:safezone/features/reports/presentation/widgets/report_success_overlay.dart';

class RequestBackupPage extends StatefulWidget {
  const RequestBackupPage({super.key});

  @override
  State<RequestBackupPage> createState() => _RequestBackupPageState();
}

class _RequestBackupPageState extends State<RequestBackupPage> {
  String? _selectedType = 'Medical';

  void _handleSuccess() {
    showReportSuccess(
      context,
      () {
        Navigator.pop(context); // Close dialog
        Navigator.pop(context); // Return to previous page
      },
      showButton: false,
    );

    // Automatically return after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        // Only pop if we are still on this page (dialog might have been closed manually)
        Navigator.of(context).popUntil((route) => route.isFirst || route.settings.name == '/arrival_report' || true);
        // Better: just pop twice if possible, but let's be safe.
        // If the dialog is still open, pop it and then pop the page.
        if (Navigator.canPop(context)) {
          Navigator.pop(context); // This would pop the dialog
          if (Navigator.canPop(context)) {
            Navigator.pop(context); // This would pop the page
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CỨU TRỢ KHẨN CẤP',
              style: AppTextStyles.fontInter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.rescuerPrimary,
              ),
            ),
            const Gap(8),
            Text(
              'Yêu cầu hỗ trợ',
              style: AppTextStyles.fontManrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(16),
            Text(
              'Chọn loại hỗ trợ bạn cần ngay bây giờ. Đội ngũ ứng phó sẽ được điều động đến vị trí của bạn.',
              style: AppTextStyles.fontInter(
                fontSize: 15,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const Gap(32),
            
            _BackupOptionCard(
              id: 'Medical',
              title: 'Y tế',
              subtitle: 'Sơ cứu, cấp cứu',
              icon: Icons.medical_services_outlined,
              isSelected: _selectedType == 'Medical',
              onTap: () => setState(() => _selectedType = 'Medical'),
            ),
            const Gap(16),
            _BackupOptionCard(
              id: 'Fire',
              title: 'Cứu hỏa',
              subtitle: 'Hỏa hoạn, cứu nạn',
              icon: Icons.fire_truck_outlined,
              isSelected: _selectedType == 'Fire',
              onTap: () => setState(() => _selectedType = 'Fire'),
            ),
            const Gap(16),
            _BackupOptionCard(
              id: 'Technical',
              title: 'Kỹ thuật',
              subtitle: 'Hư hỏng, sự cố điện',
              icon: Icons.engineering_outlined,
              isSelected: _selectedType == 'Technical',
              onTap: () => setState(() => _selectedType = 'Technical'),
            ),
            const Gap(40),
            
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _handleSuccess,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.rescuerPrimary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Gửi yêu cầu hỗ trợ',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const Gap(24),
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

class _BackupOptionCard extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _BackupOptionCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : const Color(0xFFF8F9FA),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.rescuerPrimary : Colors.transparent,
            width: 2,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.rescuerPrimary.withValues(alpha: 0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.rescuerPrimary.withValues(alpha: 0.1) : Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: isSelected ? AppColors.rescuerPrimary : AppColors.onSurfaceVariant,
                size: 28,
              ),
            ),
            const Gap(20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.fontInter(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(4),
                  Text(
                    subtitle,
                    style: AppTextStyles.fontInter(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: AppColors.rescuerPrimary,
              ),
          ],
        ),
      ),
    );
  }
}
