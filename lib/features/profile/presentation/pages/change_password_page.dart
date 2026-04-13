import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Đổi mật khẩu', style: AppTextStyles.titleMedium.copyWith(fontSize: 22)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            _buildInputField('Mật khẩu hiện tại', 'Nhập mật khẩu hiện tại', isObscure: true),
            const SizedBox(height: AppSpacing.md),
            _buildInputField('Mật khẩu mới', 'Nhập mật khẩu mới', isObscure: true),
            const SizedBox(height: AppSpacing.md),
            _buildInputField('Xác nhận mật khẩu', 'Nhập mật khẩu mới', isObscure: true),
            
            const Spacer(),
            
            _buildActionButton(context, 'Thay đổi'),
          ],
        ),
      ),
    );
  }

  Widget _buildInputField(String label, String hint, {bool isObscure = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: AppColors.primary.withValues(alpha: 0.1)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  isObscure ? '********' : hint,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: isObscure ? AppColors.textPrimary : AppColors.textHint,
                  ),
                ),
              ),
              if (isObscure)
                const Icon(Icons.visibility_off_outlined, color: AppColors.textHint, size: 20),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton(BuildContext context, String text) {
    return InkWell(
      onTap: () => Navigator.pop(context),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(
          child: Text(
            text,
            style: AppTextStyles.buttonText.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
