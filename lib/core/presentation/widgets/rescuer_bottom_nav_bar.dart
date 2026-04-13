import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../theme/app_colors.dart';
import '../../theme/app_text_styles.dart';

import 'package:safezone/features/rescuer/presentation/pages/rescuer_home_shell.dart';

class RescuerBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const RescuerBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  static void navigateToTab(BuildContext context, int index) {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => RescuerHomeShell(initialIndex: index),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
          bottomLeft: Radius.circular(31),
          bottomRight: Radius.circular(31),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x08000000),
            blurRadius: 40,
          )
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _NavBarItem(
                label: 'NHIỆM VỤ',
                iconData: Icons.assignment_outlined,
                isActive: currentIndex == 0,
                onTap: () => onTabSelected(0),
              ),
              _NavBarItem(
                label: 'BẢN ĐỒ',
                iconData: Icons.map_outlined,
                isActive: currentIndex == 1,
                onTap: () => onTabSelected(1),
              ),
              const SizedBox(width: 48), // Gap for center button
              _NavBarItem(
                label: 'TRAO ĐỔI',
                iconData: Icons.chat_bubble_outline_rounded,
                isActive: currentIndex == 3,
                onTap: () => onTabSelected(3),
              ),
              _NavBarItem(
                label: 'BÁO CÁO',
                iconData: Icons.insert_drive_file_outlined,
                isActive: currentIndex == 4,
                onTap: () => onTabSelected(4),
              ),
            ],
          ),
          Positioned(
            top: -24,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => onTabSelected(2),
              child: Center(
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 10),
                        spreadRadius: -3,
                      ),
                    ],
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.sensors,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final String label;
  final IconData iconData;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.label,
    required this.iconData,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.rescuerBlue : AppColors.slateGray;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 20,
              color: color,
            ),
            const Gap(4),
            Text(
              label,
              style: AppTextStyles.fontInter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: color,
                letterSpacing: 0.25,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const Gap(4),
            if (isActive)
              Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              )
            else
              const SizedBox(height: 4),
          ],
        ),
      ),
    );
  }
}
