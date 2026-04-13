import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class TeamMemberTile extends StatelessWidget {
  final String name;
  final String role;
  final double rating;
  final String? imageUrl;
  final String? imageAsset;
  final bool? isAssigned;
  final VoidCallback? onTap;

  const TeamMemberTile({
    super.key,
    required this.name,
    required this.role,
    required this.rating,
    this.imageUrl,
    this.imageAsset,
    this.isAssigned,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.02),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: imageAsset != null
                    ? DecorationImage(
                        image: AssetImage(imageAsset!),
                        fit: BoxFit.cover,
                      )
                    : imageUrl != null
                        ? DecorationImage(
                            image: NetworkImage(imageUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                color: AppColors.surfaceContainerLow,
              ),
              child: (imageUrl == null && imageAsset == null)
                  ? const Icon(Icons.person, color: AppColors.onSurfaceVariant)
                  : null,
            ),
            const Gap(16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.fontInter(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(2),
                  Text(
                    role,
                    style: AppTextStyles.fontInter(
                      fontSize: 12,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.greenLight100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    rating.toStringAsFixed(1),
                    style: AppTextStyles.fontInter(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.greenText700,
                    ),
                  ),
                ),
                const Gap(4),
                if (isAssigned != null)
                  Text(
                    isAssigned! ? "NV $name" : "Sẵn sàng",
                    style: AppTextStyles.fontInter(
                      fontSize: 10,
                      color: isAssigned!
                          ? AppColors.rescuerBlue
                          : AppColors.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
