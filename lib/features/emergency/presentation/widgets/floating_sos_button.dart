import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:safezone/core/theme/app_colors.dart';
import '../pages/sos_choice_page.dart';


class FloatingSosButton extends StatelessWidget {
  const FloatingSosButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const SosChoicePage()),
        );
      },
      child: Container(
        width: 85,
        height: 85,
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.redBorder.withValues(alpha: 0.5),
        ),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [AppColors.alertRedStart, AppColors.alertRedEnd],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Center(
            child: Text(
              'SOS',
              style: AppTextStyles.fontPoppins(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}