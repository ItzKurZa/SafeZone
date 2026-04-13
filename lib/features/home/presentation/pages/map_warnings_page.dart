import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/presentation/widgets/app_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../emergency/presentation/widgets/floating_sos_button.dart';

class MapWarningsPage extends StatelessWidget {
  const MapWarningsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildAppBar(context),
            Expanded(child: _buildMapSection(context)),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2, // Highlight center for map (as per original flow)
        onTabSelected: (index) {
          // If tapping anything else, just pop back
          Navigator.pop(context);
        },
      ),
      floatingActionButton: const FloatingSosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Back Button
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
          ),
          // Logo
          Image.asset('assets/images/logo.png', width: 70, height: 70),
          // Notification Bell
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.notificationBorder, width: 1.5),
            ),
            child: const Icon(
              Icons.notifications_none,
              color: Colors.black,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
    return Stack(
      children: [
        // Map Image Background
        Positioned.fill(
          child: Image.asset(
            'assets/images/imgDetailedMap.png',
            fit: BoxFit.cover,
          ),
        ),

        // Target Button (Bottom Left)
        Positioned(
          bottom: 270, // Above bottom sheet
          left: 20,
          child: Container(
            width: 45,
            height: 45,
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: SvgPicture.asset('assets/icons/imgMapTarget.svg'),
          ),
        ),

        // Zoom Controls (Middle Right)
        Positioned(
          bottom: 270,
          right: 20,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add, color: Colors.black54),
                    ),
                    Container(
                      height: 1,
                      width: 30,
                      color: Colors.grey.withValues(alpha: 0.3),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove, color: Colors.black54),
                    ),
                  ],
                ),
              ),
              const Gap(15),
            ],
          ),
        ),

        // Bottom Sheet Overlay container with warnings
        Positioned(
          bottom: -10, // Extend behind the bottom nav bar slightly
          left: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.only(
              top: 25,
              left: 15,
              right: 15,
              bottom: 40,
            ),
            decoration: const BoxDecoration(
              color: AppColors.redLight,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildWarningCard(
                  iconPath: 'assets/icons/imgDangerTriangle.svg', // Red danger
                  title: 'Báo cáo hoạt động đáng ngờ',
                  time: '15 phút trước',
                  distance: '600m',
                  iconBgColor: AppColors.redDot,
                ),
                const Gap(15),
                _buildWarningCard(
                  iconPath:
                      'assets/icons/imgDangerTriangle.svg', // Yellow/Orange danger
                  title: 'Tai nạn chặn đường',
                  time: '30 phút trước',
                  distance: '300m',
                  iconBgColor: AppColors.warningYellowIcon,
                ),
                const Gap(10),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Xem thêm >>',
                    style: AppTextStyles.fontPoppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: AppColors.activeBlue,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildWarningCard({
    required String iconPath,
    required String title,
    required String time,
    required String distance,
    required Color iconBgColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: SvgPicture.asset(iconPath),
            ),
          ),
          const Gap(15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.fontPoppins(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withValues(alpha: 0.8),
                  ),
                ),
                Text(
                  time,
                  style: AppTextStyles.fontPoppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withValues(alpha: 0.4),
                  ),
                ),
              ],
            ),
          ),
          Text(
            distance,
            style: AppTextStyles.fontPoppins(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.black.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}