import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';

class AppTextStyles {
  const AppTextStyles._();

  static TextStyle textFieldInput() {
    return const TextStyle(
      color: AppColors.lightGray,
      fontSize: 15.0,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle calendarCardNum(bool selected, BuildContext context) {
    return TextStyle(
      color:
          selected ? AppColors.white : Theme.of(context).colorScheme.tertiary,
      fontSize: 18.0,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle calendarCardText(bool selected, BuildContext context) {
    return TextStyle(
      color:
          selected ? AppColors.white : Theme.of(context).colorScheme.tertiary,
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
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle errorMessage({
    Color color = AppColors.red,
    double fontSize = 13.0,
    FontWeight fontWeight = FontWeight.w400,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle titleLarge({
    required Color? color,
    double fontSize = 24.0,
    FontWeight fontWeight = FontWeight.w700,
  }) {
    return TextStyle(
      color: color,
      fontSize: fontSize,
      fontWeight: fontWeight,
    );
  }

  static TextStyle titleMedium({
    required Color? color,
  }) {
    return TextStyle(
      color: color,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle displaySmall() {
    return const TextStyle(
      color: AppColors.lightGray,
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      height: 1.5,
    );
  }

  static TextStyle labelSmall() {
    return const TextStyle(
      color: AppColors.white,
      fontSize: 14.0,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.2,
    );
  }

  static TextStyle task(bool isCompleted, BuildContext context) {
    return TextStyle(
      decoration: isCompleted ? TextDecoration.lineThrough : null,
      color: isCompleted
          ? Theme.of(context).colorScheme.tertiary
          : Theme.of(context).colorScheme.onBackground,
      fontWeight: FontWeight.w500,
      fontSize: 17.0,
    );
  }
}
