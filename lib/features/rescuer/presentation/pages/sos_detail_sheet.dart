import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/urgency_badge.dart';
import '../widgets/victim_info_card.dart';
import 'victim_detail_page.dart';
import 'mission_accepted_page.dart';

class SosDetailSheet extends StatelessWidget {
  final Map<String, dynamic> data;

  const SosDetailSheet({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 48,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const Gap(24),
          
          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        UrgencyBadge(level: data['urgency']),
                        const Gap(8),
                        Text(
                          '${data['distance']} • ${data['time']}',
                          style: AppTextStyles.fontInter(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const Gap(8),
                    Text(
                      'SỰ CỐ NGẬP LỤT', // Hardcoded as per Figma detail sheet
                      style: AppTextStyles.fontManrope(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: AppColors.rescuerPrimary,
                        letterSpacing: -1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.errorContainer,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.sensors, color: AppColors.rescuerPrimary, size: 30),
              ),
            ],
          ),
          const Gap(24),
          
          // Victim Info Card
          VictimInfoCard(
            name: data['name'],
            description: data['description'] ?? '',
            address: data['address'],
            imageUrl: data['image'],
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VictimDetailPage(data: data),
                ),
              );
            },
          ),
          const Gap(24),
          
          // Buttons
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Close sheet
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MissionAcceptedPage(data: data),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.rescuerBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                shadowColor: AppColors.rescuerBlue.withValues(alpha: 0.2),
              ),
              child: Text(
                'Nhận nhiệm vụ',
                style: AppTextStyles.fontInter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Gap(12),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                backgroundColor: AppColors.surfaceContainerHighest,
                foregroundColor: AppColors.onSurfaceVariant,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                'Bỏ qua',
                style: AppTextStyles.fontInter(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }
}
