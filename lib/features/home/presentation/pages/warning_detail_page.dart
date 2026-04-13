import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/app_bottom_nav_bar.dart';
import '../../../donations/presentation/pages/donation_payment_page.dart';
import '../../../emergency/presentation/widgets/floating_sos_button.dart';

class WarningDetailPage extends StatelessWidget {
  final String title;
  final String timeAgo;

  const WarningDetailPage({
    super.key,
    required this.title,
    required this.timeAgo,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/logo.png', height: 24),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Hoàn cảnh',
                  style: AppTextStyles.titleLarge,
                ),
              ),
              const Gap(AppSpacing.md),
              Text(
                'Lớn lên không có bố, mẹ bị tâm thần nặng, em nhỏ sống nương tựa ông bà đã già yếu.',
                style: AppTextStyles.subtitleBold.copyWith(height: 1.5),
              ),
              const Gap(AppSpacing.lg),
              // Placeholder Image for the Charity Case
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/charity_case_linh.png',
                  width: double.infinity,
                  height: 280,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: double.infinity,
                    height: 280,
                    color: AppColors.surfaceContainerLow,
                    child: const Icon(Icons.image_not_supported_outlined, color: Colors.grey),
                  ),
                ),
              ),
              const Gap(AppSpacing.lg),
              Text(
                'Em Nguyễn Diệu Linh, 13 tuổi, hiện là học sinh Trường TH&THCS An Hiệp, xã A Sảo, tỉnh Hưng Yên.',
                style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textPrimary, height: 1.5),
              ),
              const Gap(AppSpacing.xxl),
              // Donate button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const DonationPaymentPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Quyên góp ngay',
                    style: AppTextStyles.actionButton,
                  ),
                ),
              ),
              const Gap(100), // padding for FAB
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 0,
        onTabSelected: (idx) {
          if(idx != 0) Navigator.pop(context);
        },
      ),
      floatingActionButton: const FloatingSosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
