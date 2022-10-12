import 'package:flutter/material.dart';
import 'package:todoapp/generated/fonts.gen.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';

class AppThemes {
  AppThemes._();

  static const montserratFontFamily = FontFamily.montserrat;

  static ThemeData darkTheme = ThemeData(
    fontFamily: montserratFontFamily,
    scaffoldBackgroundColor: AppColors.backgroundDark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: AppColors.blue,
      onPrimary: AppColors.white,
      secondary: AppColors.blue,
      onSecondary: AppColors.white,
      tertiary: AppColors.lightGray,
      surface: AppColors.darkGray,
      onSurface: AppColors.darkBlue,
      error: AppColors.red,
      onError: AppColors.white,
      background: AppColors.white,
      onBackground: AppColors.white,
    ),
    textTheme: TextTheme(
      titleLarge: AppTextStyles.titleLarge(color: AppColors.white),
      titleMedium: AppTextStyles.titleMedium(color: AppColors.white),
      displaySmall: AppTextStyles.displaySmall(),
      labelSmall: AppTextStyles.labelSmall(),
    ),
    unselectedWidgetColor: AppColors.lightGray,
  );

  static ThemeData lightTheme = ThemeData(
    fontFamily: montserratFontFamily,
    scaffoldBackgroundColor: AppColors.backgroundLight,
    primaryColor: AppColors.darkBlue,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.blue,
      onPrimary: AppColors.white,
      secondary: AppColors.darkBlue,
      onSecondary: AppColors.white,
      tertiary: AppColors.lightGray,
      surface: AppColors.white,
      onSurface: AppColors.darkBlue,
      error: AppColors.red,
      onError: AppColors.white,
      background: AppColors.white,
      onBackground: AppColors.darkBlue,
    ),
    textTheme: TextTheme(
      titleLarge: AppTextStyles.titleLarge(color: AppColors.darkBlue),
      titleMedium: AppTextStyles.titleMedium(color: AppColors.darkBlue),
      displaySmall: AppTextStyles.displaySmall(),
      labelSmall: AppTextStyles.labelSmall(),
    ),
    unselectedWidgetColor: AppColors.lightGray,
  );
}
