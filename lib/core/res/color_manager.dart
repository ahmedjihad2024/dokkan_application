import 'package:flutter/material.dart';

abstract class ColorM {
  // Brand & Accent Colors (Dokkan Atelier Cognac)
  static const Color primary            = Color(0xFFD47A4A);
  static const Color primaryDark        = Color(0xFFC06C38);
  static const Color primaryLight       = Color(0xFFF9EFEB);
  static const Color primary50          = Color(0xFFFDF6F0);
  static const Color primary100         = Color(0xFFF9E7DB);
  static const Color primary200         = Color(0xFFF3CFB7);
  static const Color primary300         = Color(0xFFEBB18E);
  static const Color primary400         = Color(0xFFE29165);
  static const Color primary500         = Color(0xFFD47A4A);
  static const Color primary600         = Color(0xFFC06C38);
  static const Color primary700         = Color(0xFFA35832);
  static const Color primary800         = Color(0xFF864629);
  static const Color primary900         = Color(0xFF6B3721);

  // Screen Backgrounds (Canvas)
  static const Color backgroundDark     = Color(0xFF0D1117); // Exact Figma Dark Canvas
  static const Color backgroundLight    = Color(0xFFFAF9F6); // Atelier Alabaster Canvas

  // Card & Surface Fills
  static const Color surfaceDark        = Color(0xFF161B22); // Elevated dark cards
  static const Color surfaceLight       = Color(0xFFFFFFFF); // Clean white cards
  static const Color surfaceDarkElevated= Color(0xFF21262D); // Modals, inputs, popups
  static const Color surfaceLightElevated= Color(0xFFF1F5F9); // Light inputs, chips
  static const Color surfaceDarkSubtle  = Color(0xFF131926); // Subtle dark card background
  static const Color surfaceLightSubtle = Color(0xFFF8FAFC); // Subtle card/image container background

  // Banner & Specialized Gradients
  static const Color bannerGradientDarkStart  = Color(0xFF1E293B);
  static const Color bannerGradientDarkEnd    = Color(0xFF0F172A);
  static const Color bannerGradientLightStart = Color(0xFF0F172A);
  static const Color bannerGradientLightEnd   = Color(0xFF1E1B18);
  static const Color bannerDotInactive        = Color(0xFF64748B);

  static const Color productGradientDarkStart  = Color(0xFF1E293B);
  static const Color productGradientDarkEnd    = Color(0xFF0F172A);
  static const Color productGradientLightStart = Color(0xFFF8FAFC);
  static const Color productGradientLightEnd   = Color(0xFFF1F5F9);

  // Borders & Dividers
  static const Color borderDark         = Color(0xFF30363D);
  static const Color borderDarkSubtle   = Color(0xFF283347);
  static const Color borderLight        = Color(0xFFE2E8F0);

  // Typography Colors
  static const Color textPrimaryDark    = Color(0xFFF0F6FC);
  static const Color textSecondaryDark  = Color(0xFF8B949E);
  static const Color textMutedDark      = Color(0xFF6E7681);

  static const Color textPrimaryLight   = Color(0xFF0F172A);
  static const Color textSecondaryLight = Color(0xFF64748B);
  static const Color textMutedLight     = Color(0xFF94A3B8);

  // Status & Utility Colors
  static const Color danger             = Color(0xFFEF4444);
  static const Color dangerContainerDark= Color(0xFF2A1215);
  static const Color dangerContainerLight= Color(0xFFFEF2F2);

  static const Color success            = Color(0xFF10B981);
  static const Color successContainerDark= Color(0xFF0D2818);
  static const Color successContainerLight= Color(0xFFECFDF5);

  static const Color warning            = Color(0xFFF59E0B);
  static const Color ratingGold         = Color(0xFFF59E0B);

  // Neutrals
  static const Color gray900            = Color(0xFF111827);
  static const Color white              = Color(0xFFFFFFFF);
  static const Color black              = Color(0xFF000000);
  static const Color transparent        = Colors.transparent;

  static const Color cardBackground     = Color(0xFFE2E8F0);
  static const Color cardborder          = Color(0xFFEEEEEE);

}
