import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:gap/gap.dart';

import '../../../../core/presentation/widgets/app_bottom_nav_bar.dart';
import '../../../../core/theme/app_colors.dart';
import 'sos_sending_page.dart';

class SosChoicePage extends StatelessWidget {
  const SosChoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false, // bottom nav bar handles safe area at bottom
        child: Column(
          children: [
            _buildTopSection(context),
            Expanded(child: _buildMapSection(context)),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2, // Highlight the center
        onTabSelected: (index) {
          // Simply pop back to HomeShell if any navigation is attempted
          if (index != 2) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 20),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          // Back Button
          Positioned(
            left: 0,
            top: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 28,
              ),
            ),
          ),
          // Notification Bell
          Positioned(
            right: 0,
            top: 10,
            child: Container(
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
          ),
          // Logo & Content
          Column(
            children: [
              Image.asset('assets/images/logo.png', width: 91, height: 91),
              const Gap(12),
              // Red Shield Banner
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.alertRedStart, AppColors.alertRedEnd],
                  ),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Text(
                  'SOS',
                  style: AppTextStyles.fontPoppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
              const Gap(16),
              // Titles
              Text(
                'khẩn cấp SOS',
                style: AppTextStyles.fontPoppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withValues(alpha: 0.7),
                ),
              ),
              const Gap(4),
              Text(
                'Cứu hộ và người thân đang đến giúp bạn',
                style: AppTextStyles.fontPoppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
              const Gap(16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMapSection(BuildContext context) {
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
        // Fading gradient on top of map to blend with top section
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
        // Blue bottom tint
        Positioned.fill(
          child: Container(
            color: AppColors.mapBlueTint.withValues(alpha: 0.2), // Light blue tint
          ),
        ),

        // Center Pulsing Red Dot (Static visual for this screen)
        Center(
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: AppColors.redDot,
              shape: BoxShape.circle,
            ),
          ),
        ),

        // Action Buttons Row (At Bottom of Map)
        Positioned(
          bottom: 30, // Above the bottom nav bar
          left: 0,
          right: 0,
          child: Column(
            children: [
              // Default TEST SOS Button
              _InteractiveActionPill(
                onTap: () {},
                child: Container(
                  width: 150,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.textTertiary.withValues(alpha: 0.5),
                        blurRadius: 25,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      'TEST SOS',
                      style: AppTextStyles.fontPoppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.black.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ),
              ),
              const Gap(24),
              // Bottom 2 Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Gửi ngay button
                  _InteractiveActionPill(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SosSendingPage(isSilent: false),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 81,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textTertiary.withValues(alpha: 0.5),
                            blurRadius: 25,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 32.8,
                            height: 34.8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: const LinearGradient(
                                colors: [AppColors.alertRedStart, AppColors.alertRedEnd],
                              ),
                              border: Border.all(
                                color: AppColors.redBorder,
                                width: 3,
                              ),
                            ),
                          ),
                          const Gap(8),
                          Text(
                            'Gửi ngay',
                            style: AppTextStyles.fontPoppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // SOS im lặng button
                  _InteractiveActionPill(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SosSendingPage(isSilent: true),
                        ),
                      );
                    },
                    child: Container(
                      width: 150,
                      height: 81,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textTertiary.withValues(alpha: 0.5),
                            blurRadius: 25,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 32.8,
                            height: 34.8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                colors: [AppColors.alertYellowStart.withValues(alpha: 0.72), AppColors.alertYellowEnd.withValues(alpha: 0.78)],
                              ),
                              border: Border.all(
                                color: AppColors.yellowBorder,
                                width: 3,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Icon(
                                Icons.notifications_off,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                          const Gap(8),
                          Text(
                            'SOS im lặng',
                            style: AppTextStyles.fontPoppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.black.withValues(alpha: 0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Micro-animation interactive wrapper
class _InteractiveActionPill extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _InteractiveActionPill({required this.child, required this.onTap});

  @override
  State<_InteractiveActionPill> createState() => _InteractiveActionPillState();
}

class _InteractiveActionPillState extends State<_InteractiveActionPill>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) => _controller.forward();

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() => _controller.reverse();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(scale: _scaleAnimation, child: widget.child),
    );
  }
}