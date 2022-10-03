import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';

class AppDecorations {
  AppDecorations._();

  static BoxDecoration bottomModal() {
    return const BoxDecoration(
      color: AppColors.gray,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(35.0),
        topRight: Radius.circular(35.0),
      ),
    );
  }

  static InputDecoration formField() {
    return const InputDecoration(
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGray),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.blue,
        ),
      ),
    );
  }

  static BoxDecoration calendarCard() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: AppColors.gray,
    );
  }
}
