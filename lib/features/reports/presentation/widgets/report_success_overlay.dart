import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class ReportSuccessOverlay extends StatelessWidget {
  final VoidCallback onHomeTap;
  final bool showButton;

  const ReportSuccessOverlay({
    super.key,
    required this.onHomeTap,
    this.showButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: onHomeTap,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32),
              child: Image.asset(
                'assets/images/report_success_bubble.png',
                fit: BoxFit.contain,
              ),
            ),
          ),
          if (showButton) ...[
            const Gap(24),
            ElevatedButton(
              onPressed: onHomeTap,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentBlue,
                minimumSize: const Size(200, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              child: Text(
                'Trở về trang chủ',
                style: AppTextStyles.buttonLarge.copyWith(color: AppColors.white),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

// Helper to show the overlay
void showReportSuccess(BuildContext context, VoidCallback onHomeTap, {bool showButton = true}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => ReportSuccessOverlay(
      onHomeTap: onHomeTap,
      showButton: showButton,
    ),
  );
}
