import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

enum DisasterType { flood, fire, medical }

class DisasterTag extends StatelessWidget {
  final DisasterType type;

  const DisasterTag({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color borderColor;
    Color textColor;
    IconData icon;
    String label;

    switch (type) {
      case DisasterType.flood:
        bgColor = const Color(0xFFFEF2F2);
        borderColor = const Color(0xFFFEE2E2);
        textColor = const Color(0xFFB91C1C);
        icon = Icons.waves;
        label = 'LŨ LỤT';
        break;
      case DisasterType.fire:
        bgColor = AppColors.orangeLight;
        borderColor = AppColors.orangeBorder;
        textColor = AppColors.orangeText;
        icon = Icons.local_fire_department;
        label = 'CHÁY';
        break;
      case DisasterType.medical:
        bgColor = AppColors.surfaceContainerLow;
        borderColor = Colors.transparent;
        textColor = AppColors.onSurfaceVariant;
        icon = Icons.medical_services_outlined;
        label = 'Y TẾ';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        border: borderColor != Colors.transparent ? Border.all(color: borderColor) : null,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: textColor),
          const Gap(6),
          Text(
            label,
            style: AppTextStyles.fontInter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: textColor,
              letterSpacing: -0.7,
            ),
          ),
        ],
      ),
    );
  }
}
