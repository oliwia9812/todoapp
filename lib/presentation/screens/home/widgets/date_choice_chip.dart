import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';

class CustomDateChoiceChip extends StatelessWidget {
  final IconData? icon;
  final String? title;
  final ValueChanged<bool>? onSelected;
  final bool selected;

  const CustomDateChoiceChip({
    super.key,
    this.title,
    this.icon,
    this.onSelected,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: ChoiceChip(
        labelPadding: const EdgeInsets.symmetric(
          vertical: 4.0,
          horizontal: 13.5,
        ),
        pressElevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        selectedColor: AppColors.blue,
        side: BorderSide(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        label: _buildLabel(),
        selected: selected,
        onSelected: onSelected,
      ),
    );
  }

  Widget _buildLabel() {
    return Row(
      children: [
        if (icon != null) _buildChipsIcon(),
        if (title != null)
          const SizedBox(
            width: 8.0,
          ),
        if (title != null) _buildChipsTitle(),
      ],
    );
  }

  Widget _buildChipsIcon() {
    return Icon(
      icon,
      size: 18.0,
      color: selected ? AppColors.white : AppColors.lightGray,
    );
  }

  Widget _buildChipsTitle() {
    return Text(
      title!,
      style: AppTextStyles.choiceChip(
          color: selected ? AppColors.white : AppColors.lightGray),
    );
  }
}
