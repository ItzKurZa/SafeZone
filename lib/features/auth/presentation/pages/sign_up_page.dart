import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../core/presentation/widgets/custom_button.dart';
import '../../../../core/presentation/widgets/custom_text_field.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/sign_up_bloc.dart';
import '../bloc/sign_up_event.dart';
import '../bloc/sign_up_state.dart';
import 'login_page.dart';
import 'otp_page.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpBloc(),
      child: const _SignUpView(),
    );
  }
}

class _SignUpView extends StatefulWidget {
  const _SignUpView();

  @override
  State<_SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<_SignUpView> {
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _addressCtrl = TextEditingController();
  final _bloodTypeCtrl = TextEditingController();
  final _medicalCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    _confirmCtrl.dispose();
    _phoneCtrl.dispose();
    _addressCtrl.dispose();
    _bloodTypeCtrl.dispose();
    _medicalCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state is SignUpPersonalInfoStep) {
          // handled by builder — step 2 view
        }
        if (state is SignUpOtpStep) {
          final bloc = context.read<SignUpBloc>();
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => BlocProvider.value(
                value: bloc,
                child: const OtpPage(),
              ),
            ),
          );
        }
        if (state is SignUpError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                children: [
                  const Gap(AppSpacing.xl),
                  // Logo
                  Image.asset('assets/images/logo.png', height: 100),
                  const Gap(AppSpacing.sm),
                  // Title
                  Text('ĐĂNG KÝ', style: AppTextStyles.heading1),
                  const Gap(AppSpacing.xl),

                  // Card
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.border, width: 2),
                    ),
                    child: Column(
                      children: [
                        // Step-based content
                        if (state is SignUpRoleStep)
                          _RoleStepContent(selectedRole: state.selectedRole)
                        else if (state is SignUpCredentialsStep)
                          _CredentialsStepContent(
                            nameCtrl: _nameCtrl,
                            emailCtrl: _emailCtrl,
                            passwordCtrl: _passwordCtrl,
                            confirmCtrl: _confirmCtrl,
                          )
                        else if (state is SignUpPersonalInfoStep)
                          _PersonalInfoStepContent(
                            role: state.role,
                            phoneCtrl: _phoneCtrl,
                            addressOrOrgCtrl: _addressCtrl,
                            bloodOrCodeCtrl: _bloodTypeCtrl,
                            medicalOrRegionCtrl: _medicalCtrl,
                          )
                        else
                          _RoleStepContent(selectedRole: null),

                        const Gap(AppSpacing.xl),

                        // Continue Button
                        CustomButton(
                          text: 'Continue',
                          isLoading: state is SignUpLoading,
                          onPressed: () => _onContinue(context, state),
                        ),
                        const Gap(AppSpacing.md),

                        // Already have account
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Already have an account?',
                              style: AppTextStyles.bodyRegular,
                            ),
                            const Gap(6),
                            GestureDetector(
                              onTap: () => Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const LoginPage()),
                              ),
                              child: Text(
                                'Log In',
                                style: AppTextStyles.bodySemiBold
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Gap(AppSpacing.xl),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _onContinue(BuildContext context, SignUpState state) {
    final bloc = context.read<SignUpBloc>();
    if (state is SignUpRoleStep) {
      if (state.selectedRole == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select a role')),
        );
        return;
      }
      // Dispatch step 1 (role already selected) → moves to Credentials
      bloc.add(const SignUpStep1Submitted(
        name: '', email: '', password: '', confirmPassword: '',
      ));
    } else if (state is SignUpCredentialsStep) {
      bloc.add(SignUpStep1Submitted(
        name: _nameCtrl.text,
        email: _emailCtrl.text,
        password: _passwordCtrl.text,
        confirmPassword: _confirmCtrl.text,
      ));
    } else if (state is SignUpPersonalInfoStep) {
      bloc.add(SignUpStep2Submitted(
        phone: _phoneCtrl.text,
        address: _addressCtrl.text,
        bloodType: _bloodTypeCtrl.text,
        medicalHistory: _medicalCtrl.text,
      ));
    }
  }
}

// ─── Step 1: Role Selector ────────────────────────────────────────────────────
class _RoleStepContent extends StatelessWidget {
  final String? selectedRole;
  const _RoleStepContent({this.selectedRole});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _RoleOptionTile(
          label: 'Người dân',
          value: 'civilian',
          isSelected: selectedRole == 'civilian',
        ),
        const Gap(AppSpacing.md),
        _RoleOptionTile(
          label: 'Đội cứu hộ',
          value: 'rescuer',
          isSelected: selectedRole == 'rescuer',
        ),
      ],
    );
  }
}

class _RoleOptionTile extends StatelessWidget {
  final String label;
  final String value;
  final bool isSelected;

  const _RoleOptionTile({
    required this.label,
    required this.value,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    // From Figma: selected = #5BD279 border, unselected = #1800AD border
    // Both have white bg, rounded-10, shadow, py-27px, px-14px
    return GestureDetector(
      onTap: () => context.read<SignUpBloc>().add(RoleSelected(value)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 27,
        ),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected ? AppColors.successGreenDark : AppColors.border,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.borderLight.withValues(alpha: 0.24),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Text(
          label,
          style: AppTextStyles.fontInter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.textPrimary,
            letterSpacing: -0.14,
          ),
        ),
      ),
    );
  }
}

// ─── Step 2: Credentials ──────────────────────────────────────────────────────
class _CredentialsStepContent extends StatelessWidget {
  final TextEditingController nameCtrl;
  final TextEditingController emailCtrl;
  final TextEditingController passwordCtrl;
  final TextEditingController confirmCtrl;

  const _CredentialsStepContent({
    required this.nameCtrl,
    required this.emailCtrl,
    required this.passwordCtrl,
    required this.confirmCtrl,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTextField(controller: nameCtrl, hintText: 'Name'),
        const Gap(AppSpacing.formGap),
        CustomTextField(
          controller: emailCtrl,
          hintText: 'Email',
          keyboardType: TextInputType.emailAddress,
        ),
        const Gap(AppSpacing.formGap),
        CustomTextField(
          controller: passwordCtrl,
          hintText: 'Password',
          isPassword: true,
        ),
        const Gap(AppSpacing.formGap),
        CustomTextField(
          controller: confirmCtrl,
          hintText: 'Confirm Password',
          isPassword: true,
        ),
      ],
    );
  }
}

// ─── Step 3: Personal Info ────────────────────────────────────────────────────
class _PersonalInfoStepContent extends StatelessWidget {
  final String role;
  final TextEditingController phoneCtrl;
  final TextEditingController addressOrOrgCtrl;
  final TextEditingController bloodOrCodeCtrl;
  final TextEditingController medicalOrRegionCtrl;

  const _PersonalInfoStepContent({
    required this.role,
    required this.phoneCtrl,
    required this.addressOrOrgCtrl,
    required this.bloodOrCodeCtrl,
    required this.medicalOrRegionCtrl,
  });

  @override
  Widget build(BuildContext context) {
    final isRescuer = role == 'rescuer';

    return Column(
      children: [
        CustomTextField(
          controller: phoneCtrl,
          hintText: 'SDT',
          keyboardType: TextInputType.phone,
        ),
        const Gap(AppSpacing.formGap),
        CustomTextField(
            controller: addressOrOrgCtrl,
            hintText: isRescuer ? 'Tổ chức' : 'Địa chỉ'),
        const Gap(AppSpacing.formGap),
        if (isRescuer) ...[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary, width: 1),
              borderRadius: BorderRadius.circular(100),
            ),
            alignment: Alignment.center,
            child: Text(
              'Thẻ ngành',
              style: AppTextStyles.fontPlusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.textSecondary,
                letterSpacing: -0.24,
              ),
            ),
          ),
          const Gap(2),
        ],
        CustomTextField(
            controller: bloodOrCodeCtrl,
            hintText: isRescuer ? 'Mã nhân viên' : 'Nhóm máu'),
        const Gap(AppSpacing.formGap),
        CustomTextField(
          controller: medicalOrRegionCtrl,
          hintText: isRescuer ? 'Khu vực' : 'Tiền sử bệnh lý',
        ),
      ],
    );
  }
}