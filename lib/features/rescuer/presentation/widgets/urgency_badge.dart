import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

enum UrgencyLevel { emergency, normal }

class UrgencyBadge extends StatelessWidget {
  final UrgencyLevel level;

  const UrgencyBadge({
    super.key,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    final isEmergency = level == UrgencyLevel.emergency;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: isEmergency ? AppColors.errorContainer : AppColors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        isEmergency ? 'KHẨN CẤP' : 'THÔNG THƯỜNG',
        style: AppTextStyles.fontInter(
          fontSize: 8,
          fontWeight: FontWeight.bold,
          color: isEmergency ? AppColors.onErrorContainer : AppColors.onSurfaceVariant,
          letterSpacing: 0.5,
        ),
      ),
    );
  }
}
