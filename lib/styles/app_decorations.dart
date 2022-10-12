import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';

class AppDecorations {
  AppDecorations._();

  static BoxDecoration bottomModal(BuildContext context) {
    return BoxDecoration(
      color: Theme.of(context).colorScheme.surface,
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(35.0),
        topRight: Radius.circular(35.0),
      ),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(10, 0, 0, 0),
          offset: Offset(0, 1),
          spreadRadius: 3,
          blurRadius: 15,
        ),
        BoxShadow(
          color: Color.fromARGB(5, 0, 0, 0),
          offset: Offset(0, 0),
          spreadRadius: 2,
          blurRadius: 6,
        ),
      ],
    );
  }

  static BoxDecoration calendarCard(bool selected, BuildContext context) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(16.0),
      color: selected ? AppColors.blue : Theme.of(context).colorScheme.surface,
    );
  }

  static InputDecoration formField(BuildContext context) {
    return InputDecoration(
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppColors.lightGray),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
