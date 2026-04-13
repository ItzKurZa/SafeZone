import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../bloc/sign_up_bloc.dart';
import '../bloc/sign_up_event.dart';
import '../../../home/presentation/pages/home_shell.dart';
import '../../../rescuer/presentation/pages/rescuer_home_shell.dart';
import '../bloc/sign_up_state.dart';

// OTP page is pushed onto the stack from SignUpPage, so it shares the
// same BlocProvider. It does NOT create a new BlocProvider.
class OtpPage extends StatefulWidget {
  const OtpPage({super.key});

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  final List<TextEditingController> _controllers =
      List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());

  String get _otp =>
      _controllers.map((c) => c.text).join();

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onVerify(BuildContext context) {
    if (_otp.length < 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter all 4 digits')),
      );
      return;
    }
    context.read<SignUpBloc>().add(OtpSubmitted(_otp));
  }

  void _onResend(BuildContext context) {
    context.read<SignUpBloc>().add(const OtpResendRequested());
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP sent again!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          // Navigate to home shell
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Registration Successful!')),
          );
          
          final targetPage = state.role == 'rescuer' 
              ? const RescuerHomeShell() 
              : const HomeShell();

          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => targetPage),
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // OTP Card — exact Figma: border-2 #1800AD, rounded-10, p-24
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border, width: 2),
                    ),
                    child: Column(
                      children: [
                        // "OTP" title — Inter Medium 20px #1800AD centered
                        Text(
                          'OTP',
                          style: AppTextStyles.fontInter(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primary,
                            letterSpacing: -0.2,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(AppSpacing.lg),

                        // Subtitle
                        Text(
                          'We Have Sent Code To Your Phone Number',
                          style: AppTextStyles.fontPoppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: AppColors.borderLightGray,
                            height: 1.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(AppSpacing.sm),

                        // Masked phone number
                        Text(
                          '036XXXXX582',
                          style: AppTextStyles.fontPoppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: AppColors.borderLightGray,
                            letterSpacing: -0.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const Gap(AppSpacing.lg),

                        // 4 OTP boxes — Figma: 57.75px wide, 46px tall each, equal gap
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(4, (i) => _OtpBox(
                            controller: _controllers[i],
                            focusNode: _focusNodes[i],
                            onChanged: (val) {
                              if (val.isNotEmpty && i < 3) {
                                _focusNodes[i + 1].requestFocus();
                              } else if (val.isEmpty && i > 0) {
                                _focusNodes[i - 1].requestFocus();
                              }
                            },
                          )),
                        ),
                        const Gap(AppSpacing.xl),

                        // VERIFY button — primary
                        BlocBuilder<SignUpBloc, SignUpState>(
                          builder: (context, state) {
                            return _OtpButton(
                              label: 'VERIFY',
                              backgroundColor: AppColors.primary,
                              textColor: AppColors.white,
                              isLoading: state is SignUpLoading,
                              onPressed: () => _onVerify(context),
                            );
                          },
                        ),
                        const Gap(AppSpacing.md),

                        // SEND AGAIN button — grey disabled-looking
                        _OtpButton(
                          label: 'SEND AGAIN',
                          backgroundColor: AppColors.borderGray,
                          textColor: AppColors.textTertiary,
                          onPressed: () => _onResend(context),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Single OTP digit box ─────────────────────────────────────────────────────
class _OtpBox extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;

  const _OtpBox({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Figma: width=57.75px, height=46px, border #1800AD, rounded-10, px-14 py-27
    return SizedBox(
      width: 57,
      height: 46,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        maxLength: 1,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        decoration: InputDecoration(
          counterText: '',
          contentPadding: EdgeInsets.zero,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.border, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          filled: true,
          fillColor: AppColors.white,
        ),
      ),
    );
  }
}

// ─── OTP action button (VERIFY / SEND AGAIN) ─────────────────────────────────
class _OtpButton extends StatelessWidget {
  final String label;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;
  final bool isLoading;

  const _OtpButton({
    required this.label,
    required this.backgroundColor,
    required this.textColor,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Figma: h-48, full width, rounded-10, shadow
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(color: Colors.white),
          ),
          elevation: 0,
          shadowColor: Colors.transparent,
        ),
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : Text(
                label,
                style: AppTextStyles.fontPoppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: textColor,
                  letterSpacing: -0.3,
                  height: 24 / 20,
                ),
              ),
      ),
    );
  }
}
