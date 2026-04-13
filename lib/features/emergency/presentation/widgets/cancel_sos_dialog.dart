import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:safezone/core/theme/app_colors.dart';
import 'package:gap/gap.dart';


class CancelSosDialog extends StatelessWidget {
  const CancelSosDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Fake SOS button graphic for the dialog
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.redBorder.withValues(alpha: 0.5),
              ),
              child: Center(
                child: Container(
                  width: 82,
                  height: 87,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [AppColors.alertRedStart, AppColors.alertRedEnd],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 8,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'SOS',
                      style: AppTextStyles.fontPoppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: AppColors.redBorder,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Gap(25),
            Text(
              'Bạn chắc chắn muốn huỷ?',
              textAlign: TextAlign.center,
              style: AppTextStyles.fontInter(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black.withValues(alpha: 0.7),
              ),
            ),
            const Gap(25),
            // Confirm Cancel Button
            GestureDetector(
              onTap: () {
                // Pop the dialog
                Navigator.pop(context);
                // Go back home by popping until the first route
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.dialogRedBtn,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Có, Huỷ tín hiệu',
                    style: AppTextStyles.fontInter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const Gap(10),
            // Go Back Button
            GestureDetector(
              onTap: () {
                // Just dismiss dialog
                Navigator.pop(context);
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: AppColors.dialogBlueBtn,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Center(
                  child: Text(
                    'Quay lại',
                    style: AppTextStyles.fontInter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> showCancelSosDialog(BuildContext context) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const CancelSosDialog(),
  );
}