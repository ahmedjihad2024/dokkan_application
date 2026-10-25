import 'package:flutter/material.dart';

import '../res/color_manager.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  TextTheme get textTheme => Theme.of(this).textTheme;

  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get surfaceColor => isDark ? ColorM.surfaceDark : ColorM.surfaceLight;
  Color get surfaceElevatedColor => isDark ? ColorM.surfaceDarkElevated : ColorM.surfaceLightElevated;
  Color get surfaceSubtleColor => isDark ? ColorM.surfaceDarkSubtle : ColorM.surfaceLightSubtle;
  Color get borderColor => isDark ? ColorM.borderDarkSubtle : ColorM.borderLight;
  Color get textPrimaryColor => isDark ? ColorM.textPrimaryDark : ColorM.textPrimaryLight;
  Color get textSecondaryColor => isDark ? ColorM.textSecondaryDark : ColorM.textSecondaryLight;
  Color get textMutedColor => isDark ? ColorM.textMutedDark : ColorM.textMutedLight;
  Color get dangerContainerColor => isDark ? ColorM.dangerContainerDark : ColorM.dangerContainerLight;
  Color get successContainerColor => isDark ? ColorM.successContainerDark : ColorM.successContainerLight;

  List<Color> get productHeroGradient => isDark
      ? const [ColorM.productGradientDarkStart, ColorM.productGradientDarkEnd]
      : const [ColorM.productGradientLightStart, ColorM.productGradientLightEnd];

  TextStyle get labelSmall => Theme.of(this).textTheme.labelSmall ?? const TextStyle();
}
