import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:safezone/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

import 'call_ended_page.dart';

class ActiveCallPage extends StatelessWidget {
  final String callerName;
  const ActiveCallPage({super.key, required this.callerName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          width: 80,
          height: 35,
          fit: BoxFit.contain,
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: const Icon(Icons.notifications_none, color: Colors.black, size: 24),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const Gap(60),
          Text(
            'GỌI ĐIỆN',
            style: AppTextStyles.fontPoppins(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          const Gap(40),
          ClipOval(
            child: Image.asset(
              'assets/images/avatar_1.png',
              width: 56,
              height: 56,
              fit: BoxFit.cover,
            ),
          ),
          const Gap(16),
          Text(
            callerName,
            style: AppTextStyles.fontPoppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          const Gap(8),
          Text(
            'Đang đổ chuông...',
            style: AppTextStyles.fontPoppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 100, left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(Icons.volume_up, AppColors.iconGrayLight),
                _buildHangUpButton(context),
                _buildActionButton(Icons.videocam, AppColors.iconGrayLight),
                _buildActionButton(Icons.mic_off, AppColors.iconGrayLight),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, Color color) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }

  Widget _buildHangUpButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const CallEndedPage()),
        );
      },
      child: Container(
        width: 48,
        height: 48,
        decoration: const BoxDecoration(
          color: AppColors.callEndRed,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.call_end, color: Colors.white, size: 28),
      ),
    );
  }
}
