
import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/cancel_sos_dialog.dart';
import 'sos_sent_page.dart';

class SosSendingPage extends StatefulWidget {
  final bool isSilent;

  const SosSendingPage({super.key, this.isSilent = false});

  @override
  State<SosSendingPage> createState() => _SosSendingPageState();
}

class _SosSendingPageState extends State<SosSendingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    // Mock network request delay before transitioning to Sent state
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const SosSentPage()),
        );
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Stack(
          children: [
            Column(
              children: [
                _buildTopSection(),
                Expanded(child: _buildMapWithPulse(context)),
                _buildBottomSection(context),
              ],
            ),
            Positioned(
              top: 10,
              left: 10,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      child: Column(
        children: [
          const Gap(20),
          // Logo
          Image.asset('assets/images/logo.png', width: 91, height: 91),
          const Gap(16),
          // Title
          Text(
            widget.isSilent ? 'Đang gửi SOS im lặng...' : 'Đang gửi SOS...',
            style: AppTextStyles.fontPoppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: Colors.black.withValues(alpha: 0.7),
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildMapWithPulse(BuildContext context) {
    return Stack(
      children: [
        // Map Background
        Positioned.fill(
          child: Opacity(
            opacity: 0.8,
            child: Image.asset(
              'assets/images/imgMapMakerDaNangVietnamStandard.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        // Fading gradient on top of map
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.8),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white.withValues(alpha: 0.8),
                  Colors.white.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ),
        // Blue bottom tint
        Positioned.fill(
          child: Container(
            color: AppColors.mapBlueTint.withValues(alpha: 0.2),
          ),
        ),

        // Pin Red Dot (top center of map area)
        const Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Center(
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: AppColors.redDot,
                shape: BoxShape.circle,
              ),
              child: SizedBox(width: 50, height: 50),
            ),
          ),
        ),

        // Custom Pulse Animation with Big Red SOS Outline
        Center(
          child: AnimatedBuilder(
            animation: _pulseController,
            builder: (context, child) {
              final progress = _pulseController.value;
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer ring pulsing
                  Transform.scale(
                    scale: 1.0 + (progress * 0.8),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(
                          0xFFF8EFA3,
                        ).withValues(alpha: (1 - progress) * 0.46),
                      ),
                    ),
                  ),
                  // Inner ring pulsing
                  Transform.scale(
                    scale: 1.0 + (progress * 0.4),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(
                          0xFFF6D8D7,
                        ).withValues(alpha: 1 - progress),
                      ),
                    ),
                  ),
                  // Big SOS Button
                  Container(
                    width: 123,
                    height: 130.5,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [AppColors.alertRedStart, AppColors.alertRedEnd],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: Offset(0, 1),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        'SOS',
                        style: AppTextStyles.fontPoppins(
                          fontSize: 40,
                          fontWeight: FontWeight.w600,
                          color: AppColors.redBorder,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      alignment: Alignment.center,
      child: GestureDetector(
        onTap: () {
          showCancelSosDialog(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: LinearGradient(
              colors: [AppColors.dialogRedBtn.withValues(alpha: 0.8), AppColors.dialogRedBtn.withValues(alpha: 0.8)],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: Offset(0, 1),
              ),
              BoxShadow(
                color: AppColors.callEndRed,
                blurRadius: 2,
                spreadRadius: 0,
              ),
            ],
          ),
          child: const Text(
            'HỦY SOS',
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.white,
              letterSpacing: -0.1,
            ),
          ),
        ),
      ),
    );
  }
}