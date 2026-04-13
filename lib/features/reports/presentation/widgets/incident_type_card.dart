import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

enum IncidentType {
  suspicious,
  accident,
  fire,
  flood,
  powerOutage,
  other,
}

class IncidentTypeCard extends StatelessWidget {
  final IncidentType type;
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const IncidentTypeCard({
    super.key,
    required this.type,
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {

    switch (type) {
      case IncidentType.powerOutage:
        break;
      default:
// In screenshot it's always gray-ish? Wait.
        // Adjust for specific designs in screenshot
        if (type == IncidentType.suspicious && isSelected) {
        }
    }

    // Re-evaluating based on Figma screenshot
    // Suspicious: Icon in circle, black if selected?
    // Looking at screenshot:
    // Selected "Mất điện" has blue icon, white bg, blue border.
    // Others are gray bg.

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: type == IncidentType.powerOutage && isSelected ? AppColors.white : AppColors.incidentIconBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: type == IncidentType.powerOutage && isSelected 
                ? AppColors.reportBlue 
                : (isSelected ? AppColors.textPrimary : Colors.transparent),
            width: 1.5,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: type == IncidentType.powerOutage && isSelected 
                  ? AppColors.reportBlue 
                  : (type == IncidentType.suspicious && isSelected ? AppColors.white : AppColors.textSecondary),
              size: 28,
            ),
            const Gap(8),
            Flexible(
              child: Text(
                label,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles.bodyMedium.copyWith(
                  fontSize: 12,
                  color: type == IncidentType.powerOutage && isSelected 
                      ? AppColors.reportBlue 
                      : (type == IncidentType.suspicious && isSelected ? AppColors.white : AppColors.textSecondary),
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
