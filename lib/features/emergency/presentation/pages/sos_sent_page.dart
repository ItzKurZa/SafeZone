import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/cancel_sos_dialog.dart';

class SosSentPage extends StatefulWidget {
  const SosSentPage({super.key});

  @override
  State<SosSentPage> createState() => _SosSentPageState();
}

class _SosSentPageState extends State<SosSentPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinController;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
        vsync: this, duration: const Duration(seconds: 2))
      ..repeat();
  }

  @override
  void dispose() {
    _spinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopSection(),
            Expanded(child: _buildMapCardsSection()),
            _buildBottomSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTopSection() {
    return Container(
      color: AppColors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 91, height: 91),
            ],
          ),
          const Gap(12),
          Stack(
            alignment: Alignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/imgRectangle5002.svg',
                width: 121,
                height: 79,
              ),
              Text(
                'SOS',
                style: AppTextStyles.fontPoppins(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.redBorder,
                ),
              ),
            ],
          ),
          const Gap(16),
          Text(
            'SOS đã gửi',
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
        ],
      ),
    );
  }

  Widget _buildMapCardsSection() {
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
        // Fading gradient top
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
        // Fading gradient bottom
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
        Positioned.fill(
          child: Container(
            color: AppColors.mapBlueTint.withValues(alpha: 0.2), // Light blue tint
          ),
        ),

        // Middle Content (Cards and Spinner)
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildStatusCard(
                    title: 'Cứu hộ sắp đến',
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/imgMapMarkerSpotlight.svg',
                          width: 27,
                          height: 43,
                          colorFilter: const ColorFilter.mode(
                              AppColors.emergencyRed, BlendMode.srcIn),
                        ),
                        Positioned(
                          top: 8,
                          child: SvgPicture.asset(
                            'assets/icons/imgMapMarkerSpotlightDot.svg',
                            width: 9,
                            height: 9,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(24),
                  _buildStatusCard(
                    title: 'Đã gửi đến Bố, mẹ',
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: SvgPicture.asset(
                        'assets/icons/img3UserIcon.svg',
                        width: 43,
                        height: 43,
                        colorFilter: const ColorFilter.mode(
                            AppColors.accentBlueDark, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(50),
              // Sharing position spinner
              RotationTransition(
                turns: _spinController,
                child: SvgPicture.asset(
                  'assets/icons/imgSyncSpinner.svg',
                  width: 30,
                  height: 30,
                  colorFilter: const ColorFilter.mode(
                      AppColors.accentBlueDarker, BlendMode.srcIn),
                ),
              ),
              const Gap(16),
              Text(
                'Đang chia sẻ vị trí của bạn...',
                style: AppTextStyles.fontPoppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildStatusCard({required String title, required Widget child}) {
    return Container(
      width: 150,
      height: 137,
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
          SizedBox(height: 50, child: child),
          const Gap(16),
          Text(
            title,
            style: AppTextStyles.fontPoppins(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.black.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
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