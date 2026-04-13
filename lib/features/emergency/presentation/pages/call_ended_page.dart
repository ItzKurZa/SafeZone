import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:safezone/core/theme/app_colors.dart';
import 'package:gap/gap.dart';


class CallEndedPage extends StatelessWidget {
  const CallEndedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const SizedBox(),
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
      body: Center(
        child: Column(
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
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: AppColors.callEndRed,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.call_end, color: Colors.white, size: 24),
            ),
            const Gap(40),
            Text(
              'Cuộc gọi đã kết thúc',
              style: AppTextStyles.fontPoppins(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            const Gap(8),
            Text(
              'Thời lượng 05:00',
              style: AppTextStyles.fontPoppins(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.callEndRed, width: 0.5),
                  ),
                  child: const Center(
                    child: Icon(Icons.close, color: AppColors.callEndRed, size: 32),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
