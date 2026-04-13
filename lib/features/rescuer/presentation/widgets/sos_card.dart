import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'urgency_badge.dart';
import 'disaster_tag.dart';

class SosCard extends StatelessWidget {
  final String victimName;
  final String timeAgo;
  final String distance;
  final String address;
  final UrgencyLevel urgency;
  final List<DisasterType> tags;
  final String participants;
  final String? imageUrl;
  final VoidCallback onAccept;

  const SosCard({
    super.key,
    required this.victimName,
    required this.timeAgo,
    required this.distance,
    required this.address,
    required this.urgency,
    required this.tags,
    required this.participants,
    required this.onAccept,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(
            color: urgency == UrgencyLevel.emergency 
                ? AppColors.rescuerPrimary 
                : AppColors.slateGray, 
            width: 4,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        UrgencyBadge(level: urgency),
                        const Gap(12),
                        const Icon(Icons.access_time, size: 12, color: AppColors.onSurfaceVariant),
                        const Gap(4),
                        Text(
                          timeAgo,
                          style: AppTextStyles.fontInter(
                            fontSize: 12,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Text(
                      victimName,
                      style: AppTextStyles.fontManrope(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const Gap(4),
                    Row(
                      children: [
                        const Icon(Icons.location_on_outlined, size: 12, color: AppColors.onSurfaceVariant),
                        const Gap(6),
                        Expanded(
                          child: Text(
                            'Cách $distance • $address',
                            style: AppTextStyles.fontInter(
                              fontSize: 14,
                              color: AppColors.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(16),
              Column(
                children: [
                  Container(
                    width: 64,
                    height: 64,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: imageUrl != null && imageUrl!.startsWith('http')
                            ? NetworkImage(imageUrl!)
                            : const AssetImage('assets/images/victim_placeholder.png') as ImageProvider,
                        fit: BoxFit.cover,
                      ),
                      color: AppColors.surfaceContainerLow,
                    ),
                  ),
                  const Gap(16),
                  ElevatedButton(
                    onPressed: onAccept,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.rescuerBlue,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      minimumSize: const Size(0, 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      elevation: 4,
                      shadowColor: AppColors.rescuerBlue.withValues(alpha: 0.2),
                    ),
                    child: Text(
                      'Chấp nhận',
                      style: AppTextStyles.fontInter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Gap(16),
          Row(
            children: [
              ...tags.map((tag) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: DisasterTag(type: tag),
              )),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerLow,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.people_outline, size: 12, color: AppColors.onSurfaceVariant),
                    const Gap(8),
                    Text(
                      participants,
                      style: AppTextStyles.fontInter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
