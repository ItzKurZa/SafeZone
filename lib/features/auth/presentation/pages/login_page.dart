import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/presentation/widgets/social_login_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import 'sign_up_page.dart';
import '../../../home/presentation/pages/home_shell.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Provide AuthBloc locally for demo, ideally injected globally or via router
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const _LoginView(),
    );
  }
}

class _LoginView extends StatefulWidget {
  const _LoginView();

  @override
  State<_LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<_LoginView> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed() {
    context.read<AuthBloc>().add(
          LoginSubmitted(
            email: _emailController.text,
            password: _passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is AuthSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const HomeShell()),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  const Gap(60),
                  // Logo Header
                  Image.asset('assets/images/logo.png', height: 100),
                  const Gap(10),
                  Text('ĐĂNG NHẬP', style: AppTextStyles.heading1),
                  const Gap(40),

                  // Login Card Outline (based on Figma layout)
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border, width: 2),
                    ),
                    child: Column(
                      children: [
                        SocialLoginButton(
                          text: 'Continue with Google',
                          onTap: () {},
                        ),
                        const Gap(AppSpacing.md),
                        Row(
                          children: [
                            const Expanded(child: Divider()),
                            const Gap(10),
                            Text('Or login with', style: AppTextStyles.bodyRegular),
                            const Gap(10),
                            const Expanded(child: Divider()),
                          ],
                        ),
                        const Gap(AppSpacing.md),
                        CustomTextField(
                          controller: _emailController,
                          hintText: 'Enter your email',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const Gap(AppSpacing.formGap),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: 'Password',
                          isPassword: true,
                        ),
                        const Gap(AppSpacing.sm),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  height: 24,
                                  width: 24,
                                  child: GestureDetector(
                                    onTap: () {},
                                    child: SvgPicture.asset(
                                      'assets/icons/checkbox_unselected.svg',
                                    ),
                                  ),
                                ),
                                const Gap(4),
                                Text('Remember me', style: AppTextStyles.bodyRegular),
                              ],
                            ),
                            Text(
                              'Forgot Password ?',
                              style: AppTextStyles.bodySemiBold.copyWith(
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const Gap(AppSpacing.xl),
                        CustomButton(
                          text: 'Log In',
                          isLoading: state is AuthLoading,
                          onPressed: _onLoginPressed,
                        ),
                        const Gap(AppSpacing.md),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                            const Gap(6),
                            GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const SignUpPage()),
                              ),
                              child: Text(
                                  'Sign Up', style: AppTextStyles.bodySemiBold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
