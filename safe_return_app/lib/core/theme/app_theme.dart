import 'package:flutter/material.dart';

/// Design tokens extracted directly from Figma (SafeReturn - UI)
class AppColors {
  // Brand Primary
  static const Color primaryBlue = Color(0xFF234CFA);
  static const Color primaryBlueLight = Color(0xFFEFF2FF);

  // Neutral Colors
  static const Color textPrimary = Color(0xFF111827);
  static const Color textHeading = Color(0xFF171715);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color textMuted = Color(0xFF9CA3AF);
  static const Color border = Color(0xFFE5E7EB);
  static const Color background = Color(0xFFFFFFFF);
  static const Color surfaceCard = Color(0xFFF7F8FA);
  static const Color surfaceAlt = Color(0xFFF4F2EA);

  // Status & Semantic Colors
  // Green / Approved / Claimed / Returned
  static const Color statusGreen = Color(0xFF16A34A);
  static const Color statusGreenBg = Color(0xFFDCFCE7);

  // Teal / Stored
  static const Color statusTeal = Color(0xFF0F766E);
  static const Color statusTealBg = Color(0xFFCCFBF1);

  // Orange / Pending / Reported
  static const Color statusOrange = Color(0xFFD97706);
  static const Color statusOrangeBg = Color(0xFFFEF3C7);

  // Blue / Matched
  static const Color statusBlue = Color(0xFF234CFA);
  static const Color statusBlueBg = Color(0xFFE0E7FF);

  // Red / Danger / Rejection
  static const Color statusRed = Color(0xFFDC2626);
  static const Color statusRedBg = Color(0xFFFEE2E2);

  // Asset Brown
  static const Color itemBrown = Color(0xFF8A6047);
}

class AppRadii {
  static const double r4 = 4.0;
  static const double r8 = 8.0;
  static const double r12 = 12.0;
  static const double r16 = 16.0;
  static const double r20 = 20.0;
  static const double r24 = 24.0;
  static const double full = 999.0;
}

class AppSpacing {
  static const double s4 = 4.0;
  static const double s8 = 8.0;
  static const double s12 = 12.0;
  static const double s16 = 16.0;
  static const double s20 = 20.0;
  static const double s24 = 24.0;
  static const double s32 = 32.0;
}

class AppTypography {
  static const TextStyle h1 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.textHeading,
    height: 1.25,
  );

  static const TextStyle h2 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textHeading,
    height: 1.3,
  );

  static const TextStyle h3 = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
    height: 1.35,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );

  static const TextStyle subtext = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.35,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
    height: 1.3,
  );

  static const TextStyle button = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.2,
  );
}
