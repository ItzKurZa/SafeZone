import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../emergency/presentation/pages/sos_choice_page.dart';
import 'map_warnings_page.dart';
import 'warnings_feed_page.dart';
import 'notification_page.dart';

class HomeDashboardPage extends StatelessWidget {
  const HomeDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(AppSpacing.md),
            // Header
            _buildHeader(context),
            const Gap(16),

            // Hi Loi
            Text(
              'Hi loi',
              style: AppTextStyles.titleLarge.copyWith(
                color: AppColors.primary,
                letterSpacing: -0.5,
              ),
            ),
            const Gap(16),

            // Green Banner
            _buildSafetyBanner(),
            const Gap(24),

            // 3 Buttons (SOS, MAP, Cảnh báo)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildActionCard(
                  context: context,
                  title: 'SOS',
                  titleColor: AppColors.warningTitleRed,
                  iconData: Icons.sos,
                  fallbackColor: AppColors.warningCardRedStart,
                  isSOS: true,
                ),
                _buildActionCard(
                  context: context,
                  title: 'MAP',
                  titleColor: AppColors.white,
                  iconData: Icons.map,
                  fallbackColor: AppColors.primary,
                  isMap: true,
                ),
                _buildActionCard(
                  context: context,
                  title: 'Cảnh báo',
                  titleColor: AppColors.white,
                  iconData: Icons.warning_amber_rounded,
                  fallbackColor: AppColors.warningCardYellowStart,
                ),
              ],
            ),
            const Gap(24),

            // Recent Warnings Header
            Text(
              'Cảnh báo gần đây',
              style: AppTextStyles.titleMedium,
            ),
            const Gap(16),

            // Warnings List Container
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                color: AppColors.redLight,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                children: [
                  _buildWarningItem(
                    context: context,
                    title: 'Báo cáo hoạt động đáng ngờ',
                    time: '15 phút trước',
                    iconData: Icons.warning_amber_rounded,
                  ),
                  const Gap(12),
                  _buildWarningItem(
                    context: context,
                    title: 'Tai nạn chặn đường',
                    time: '30 phút trước',
                    iconData: Icons.warning_amber_rounded,
                    isYellow: true,
                  ),
                  const Gap(12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const WarningsFeedPage()),
                          );
                        },
                        child: Text(
                          'Xem thêm >>',
                          style: AppTextStyles.bodySemiBold.copyWith(
                            fontSize: 10,
                            color: AppColors.accentBlue,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(100), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                ClipOval(
                  child: Image.asset(
                    'assets/images/avatar_1.png',
                    width: 56,
                    height: 56,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  right: 4,
                  child: Container(
                    width: 7.3,
                    height: 7.3,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Image.asset(
          'assets/images/logo.png',
          width: 91,
          height: 91,
          fit: BoxFit.contain,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const NotificationPage()));
          },
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.border),
            ),
            child: const Center(
              child: Icon(
                Icons.notifications_none,
                size: 24,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSafetyBanner() {
    return Container(
      width: double.infinity,
      height: 105,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.successGreenDark.withValues(alpha: 0.9), // rgb(91, 210, 121) with 0.9 alpha
            AppColors.successGreenDarker, // rgb(1, 119, 31)
          ],
          stops: [0.07, 0.72],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.textTertiary.withValues(alpha: 0.1),
            blurRadius: 25,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          // The background wave
          Positioned(
            left: 0,
            bottom: 0,
            right: 0,
            child: SvgPicture.asset(
              'assets/icons/imgLine43.svg',
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset('assets/images/logo.png'), // placeholder for the shield
                ),
                const Gap(12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bạn an toàn',
                        style: AppTextStyles.fontPoppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Không có mối đe dọa nào gần đây',
                        style: AppTextStyles.fontPoppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required Color titleColor,
    IconData? iconData,
    required Color fallbackColor,
    bool isSOS = false,
    bool isMap = false,
  }) {
    List<Color> gradientColors;
    if (isSOS) {
      gradientColors = [AppColors.warningCardRedStart, AppColors.warningCardRedEnd];
    } else if (isMap) {
      gradientColors = [AppColors.primary, AppColors.brandLightBlue];
    } else {
      gradientColors = [AppColors.warningCardYellowStart, AppColors.warningCardYellowEnd];
    }

    return _InteractiveCard(
      onTap: () {
        if (isSOS) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SosChoicePage()),
          );
        } else if (isMap) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MapWarningsPage()),
          );
        } else {
           // Cảnh báo button
           Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const MapWarningsPage()),
          );
        }
      },
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradientColors,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.textTertiary.withValues(alpha: 0.1),
              blurRadius: 25,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (iconData != null)
              Icon(iconData, size: 40, color: titleColor),
            const Gap(8),
            Text(
              title,
              style: AppTextStyles.bodySemiBold.copyWith(
                fontSize: 16,
                color: titleColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWarningItem({
    required BuildContext context,
    required String title,
    required String time,
    required IconData iconData,
    bool isYellow = false,
  }) {
    final gradientColors = isYellow
        ? [AppColors.alertYellowStart.withValues(alpha: 0.72), AppColors.alertYellowEnd.withValues(alpha: 0.78)]
        : const [AppColors.alertRedStart, AppColors.alertRedEnd];

    return _InteractiveCard(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: gradientColors,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  iconData,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodySemiBold.copyWith(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Text(
                    time,
                    style: AppTextStyles.bodyRegular.copyWith(
                      fontSize: 11,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InteractiveCard extends StatefulWidget {
  final Widget child;
  final VoidCallback onTap;

  const _InteractiveCard({
    required this.child,
    required this.onTap,
  });

  @override
  State<_InteractiveCard> createState() => _InteractiveCardState();
}

class _InteractiveCardState extends State<_InteractiveCard>
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
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    _controller.reverse();
    widget.onTap();
  }

  void _onTapCancel() {
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: widget.child,
      ),
    );
  }
}