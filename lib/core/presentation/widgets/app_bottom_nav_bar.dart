import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../theme/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

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
          // Underlying icons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Index 0: Report
              _NavBarItem(
                iconData: Icons.assignment_outlined,
                isActive: currentIndex == 0,
                onTap: () => onTabSelected(0),
              ),
              // Index 1: Emergency / Phone
              _NavBarItem(
                iconData: Icons.call,
                isActive: currentIndex == 1,
                onTap: () => onTabSelected(1),
              ),
              // Gap for the big middle button
              const SizedBox(width: 65),
              // Index 3: Chat
              _NavBarItem(
                iconData: Icons.chat_bubble_rounded,
                isActive: currentIndex == 3,
                onTap: () => onTabSelected(3),
              ),
              // Index 4: Profile
              _NavBarItem(
                iconData: Icons.person_rounded,
                isActive: currentIndex == 4,
                onTap: () => onTabSelected(4),
              ),
            ],
          ),

          // Center prominent button (Big blue home/center button)
          Positioned(
            top: -21,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: () => onTabSelected(2),
              child: Container(
                width: 65,
                height: 65,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary,
                ),
                child: const Center(
                  child: Icon(
                    Icons.home,
                    color: Colors.white,
                    size: 32,
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
  final IconData iconData;
  final bool isActive;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.iconData,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 60,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 24,
              color: isActive ? AppColors.primary : const Color(0xFF222222),
            ),
            if (isActive) ...[
              const Gap(4),
              Container(
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
            ] else
              const Gap(8),
          ],
        ),
      ),
    );
  }
}
