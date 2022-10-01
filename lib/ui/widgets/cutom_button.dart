import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key, required this.callback, required this.textButton});

  final VoidCallback callback;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => callback(),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        backgroundColor: AppColors.blue,
        padding: const EdgeInsets.symmetric(vertical: 18.0),
      ),
      child: Text(
        textButton.toUpperCase(),
        style: AppTextStyles.button(),
      ),
    );
  }
}
