import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle get heading1 => GoogleFonts.poppins(
        fontSize: 37,
        fontWeight: FontWeight.w700, // Bold
        color: AppColors.textPrimary,
        letterSpacing: -0.8,
        height: 45 / 37,
      );

  static TextStyle get buttonText => GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600, // SemiBold
        color: AppColors.white,
        letterSpacing: -0.3,
        height: 24 / 20,
      );

  // Body text
  static TextStyle get onboardingBody => GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600, // SemiBold
        color: AppColors.textTertiary,
        height: 14 / 14,
      );

  static TextStyle get bodyMedium => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500, // Medium
        color: AppColors.textPrimary,
        letterSpacing: -0.14,
        height: 1.4,
      );

  static TextStyle get bodyRegular => GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400, // Regular
        color: AppColors.textSecondary,
        letterSpacing: -0.12,
        height: 1.5,
      );

  static TextStyle get bodySemiBold => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w600, // SemiBold
        color: AppColors.primary,
        letterSpacing: -0.14,
        height: 1.4,
      );

  static TextStyle get hintText => GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.textHint,
        letterSpacing: -0.14,
        height: 1.4,
      );

  // Specific UI Elements
  static TextStyle get titleLarge => GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleMedium => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get subtitleBold => GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get actionButton => GoogleFonts.inter(
        fontSize: 16,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      );
  static TextStyle get h2 => GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get buttonLarge => GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      );

  // Dynamic Font Factories
  static TextStyle fontPoppins({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.poppins(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle fontInter({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle fontRoboto({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle fontPlusJakartaSans({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.plusJakartaSans(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }

  static TextStyle fontManrope({
    double? fontSize,
    FontWeight? fontWeight,
    Color? color,
    double? letterSpacing,
    double? height,
  }) {
    return GoogleFonts.manrope(
      fontSize: fontSize,
      fontWeight: fontWeight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
    );
  }
}
