import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'color_manager.dart';
import 'fonts_manager.dart';
import 'sizes_manager.dart';

class ThemeManager {
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: FontsM.inter.name,
      textTheme: _buildTextTheme(ColorM.textPrimaryLight),
      scaffoldBackgroundColor: ColorM.backgroundLight,
      colorScheme: const ColorScheme.light(
        primary: ColorM.primary,
        secondary: ColorM.primaryDark,
        surface: ColorM.surfaceLight,
        onSurface: ColorM.textPrimaryLight,
        error: ColorM.danger,
        outline: ColorM.borderLight,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: ColorM.textPrimaryLight),
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeightM.semiBold,
          color: ColorM.textPrimaryLight,
        ),
      ),
      cardTheme: CardThemeData(
        color: ColorM.surfaceLight,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
          side: const BorderSide(color: ColorM.borderLight, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: ColorM.primary,
          foregroundColor: ColorM.white,
          minimumSize: Size(double.infinity, SizeM.buttonHeight.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeM.buttonBorderRadius.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightM.semiBold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: ColorM.textPrimaryLight,
          minimumSize: Size(double.infinity, SizeM.buttonHeight.h),
          side: const BorderSide(color: ColorM.borderLight, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeM.buttonBorderRadius.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightM.semiBold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorM.surfaceLightElevated,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: ColorM.textMutedLight,
          fontWeight: FontWeightM.regular,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
          borderSide: const BorderSide(color: ColorM.borderLight, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
          borderSide: const BorderSide(color: ColorM.borderLight, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
          borderSide: const BorderSide(color: ColorM.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
          borderSide: const BorderSide(color: ColorM.danger, width: 1.2),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: ColorM.borderLight,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      fontFamily: FontsM.inter.name,
      textTheme: _buildTextTheme(ColorM.textPrimaryDark),
      // Exact Figma dark canvas fill #0D1117
      scaffoldBackgroundColor: ColorM.backgroundDark,
      colorScheme: const ColorScheme.dark(
        primary: ColorM.primary,
        secondary: ColorM.primaryDark,
        surface: ColorM.surfaceDark,
        onSurface: ColorM.textPrimaryDark,
        error: ColorM.danger,
        outline: ColorM.borderDark,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        iconTheme: const IconThemeData(color: ColorM.textPrimaryDark),
        titleTextStyle: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeightM.semiBold,
          color: ColorM.textPrimaryDark,
        ),
      ),
      cardTheme: CardThemeData(
        color: ColorM.surfaceDark,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeM.cardBorderRadius.r),
          side: const BorderSide(color: ColorM.borderDark, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: ColorM.primary,
          foregroundColor: ColorM.white,
          minimumSize: Size(double.infinity, SizeM.buttonHeight.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeM.buttonBorderRadius.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightM.semiBold,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          elevation: 0,
          foregroundColor: ColorM.textPrimaryDark,
          minimumSize: Size(double.infinity, SizeM.buttonHeight.h),
          side: const BorderSide(color: ColorM.borderDark, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeM.buttonBorderRadius.r),
          ),
          textStyle: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeightM.semiBold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: ColorM.surfaceDarkElevated,
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: ColorM.textMutedDark,
          fontWeight: FontWeightM.regular,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
          borderSide: const BorderSide(color: ColorM.borderDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
          borderSide: const BorderSide(color: ColorM.borderDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
          borderSide: const BorderSide(color: ColorM.primary, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(SizeM.inputBorderRadius.r),
          borderSide: const BorderSide(color: ColorM.danger, width: 1.2),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: ColorM.borderDark,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static TextTheme _buildTextTheme(Color color) {
    return TextTheme(
      headlineLarge: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeightM.bold,
        color: color,
      ),
      headlineMedium: TextStyle(
        fontSize: 24.sp,
        fontWeight: FontWeightM.bold,
        color: color,
      ),
      headlineSmall: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeightM.semiBold,
        color: color,
      ),
      titleLarge: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeightM.semiBold,
        color: color,
      ),
      titleMedium: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightM.medium,
        color: color,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightM.medium,
        color: color,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeightM.regular,
        color: color,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightM.regular,
        color: color,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightM.regular,
        color: color,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeightM.semiBold,
        color: color,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeightM.medium,
        color: color,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        fontWeight: FontWeightM.medium,
        color: color,
      ),
    );
  }
}
