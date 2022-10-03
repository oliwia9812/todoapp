import 'package:flutter/material.dart';
import 'package:todoapp/generated/fonts.gen.dart';
import 'package:todoapp/styles/app_colors.dart';

class AppTextStyles {
  static const montserratFontFamily = FontFamily.montserrat;

  const AppTextStyles._();

  static TextStyle standard() {
    return const TextStyle(
      color: AppColors.lightGray,
      fontFamily: montserratFontFamily,
      fontSize: 16.0,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle title({
    required Color? color,
    double fontSize = 24.0,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return TextStyle(
      color: color,
      fontFamily: montserratFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle bottomModalTitle() {
    return const TextStyle(
      color: AppColors.lightGray,
      fontFamily: montserratFontFamily,
      fontSize: 18.0,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle textField() {
    return const TextStyle(
      color: AppColors.white,
      fontFamily: montserratFontFamily,
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle button() {
    return const TextStyle(
      color: AppColors.white,
      fontFamily: montserratFontFamily,
      fontSize: 15.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    );
  }

  static TextStyle calendarCardNum() {
    return const TextStyle(
      color: AppColors.white,
      fontFamily: montserratFontFamily,
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle calendarCardText() {
    return const TextStyle(
      color: AppColors.white,
      fontFamily: montserratFontFamily,
      fontSize: 14.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle choiceChip({
    required Color? color,
    double fontSize = 14.0,
    FontWeight fontWeight = FontWeight.w500,
  }) {
    return TextStyle(
      color: color,
      fontFamily: montserratFontFamily,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }
}
