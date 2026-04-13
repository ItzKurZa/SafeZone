import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'login_page.dart';

class OnboardingItem {
  final String title;
  final String body;
  final String buttonText;

  const OnboardingItem({
    required this.title,
    required this.body,
    required this.buttonText,
  });
}

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> _items = const [
    OnboardingItem(
      title: 'An toàn mọi lúc, mọi nơi',
      body:
          'SafeZone giúp bạn nhận biết nguy hiểm xung quanh và bảo vệ bản thân một cách chủ động.',
      buttonText: 'Tiếp tục',
    ),
    OnboardingItem(
      title: 'SOS chỉ với một chạm',
      body:
          'Gửi vị trí và cảnh báo đến người thân ngay lập tức khi gặp tình huống khẩn cấp.',
      buttonText: 'Tiếp tục',
    ),
    OnboardingItem(
      title: 'Cảnh báo thông minh',
      body:
          'Nhận cảnh báo và gợi ý từ AI để tránh các khu vực nguy hiểm xung quanh bạn.',
      buttonText: 'Bắt đầu',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentIndex < _items.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    // Figma: logo+glow area y=0..443 out of 812 ≈ 54.6%, card y=443..812 ≈ 45.4%
    final topAreaHeight = screenHeight * 0.546;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          // ── TOP: logo + glow ellipse ──────────────────────────────────
          SizedBox(
            height: topAreaHeight,
            width: double.infinity,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Glow ellipse (Figma: Ellipse 14, x=-60, y=395, 484×340)
                // Relative to this container: y_in_block = 395 (absolute) 
                // which sits near the bottom of topAreaHeight.
                Positioned(
                  left: -60,
                  bottom: -40, // let it bleed into the card seam
                  child: SvgPicture.asset(
                    'assets/images/glow_ellipse.svg',
                    width: 484,
                    height: 340,
                    fit: BoxFit.fill,
                  ),
                ),

                // Logo fills the top area, contained
                Positioned.fill(
                  child: Image.asset(
                    'assets/images/logo.png',
                    fit: BoxFit.contain,
                  ),
                ),

                // Dot indicator sits right at the bottom edge of this area,
                // above the card — matching Figma placement at y~452
                Positioned(
                  bottom: 12,
                  left: 0,
                  right: 0,
                  child: _buildDotIndicator(),
                ),
              ],
            ),
          ),

          // ── BOTTOM: gradient card with PageView ───────────────────────
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [AppColors.white, AppColors.onboardingBackground],
                ),
              ),
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return _buildPageContent(_items[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Dot indicator — active dot is wide (25px), inactive dots are circular (5px)
  Widget _buildDotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        _items.length,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 5,
          width: _currentIndex == index ? 25 : 5,
          decoration: BoxDecoration(
            color: _currentIndex == index
                ? AppColors.primary
                : AppColors.primary.withAlpha(102), // ~40% opacity
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContent(OnboardingItem item) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Title
          Text(
            item.title,
            style: AppTextStyles.heading1,
            textAlign: TextAlign.center,
          ),
          const Gap(20),

          // Body description
          Text(
            item.body,
            style: AppTextStyles.onboardingBody,
            textAlign: TextAlign.center,
          ),
          const Spacer(),

          // Button with glow shadow (matches Figma blur-[18.5px] on Base element)
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withAlpha(178), // ~70% opacity
                  blurRadius: 18.5,
                  spreadRadius: 0,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: CustomButton(
              text: item.buttonText,
              onPressed: _onNext,
            ),
          ),
          const Gap(56),
        ],
      ),
    );
  }
}
