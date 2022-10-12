import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback callback;
  final String textButton;
  bool inTaskModal;

  CustomButton({
    super.key,
    required this.callback,
    required this.textButton,
    this.inTaskModal = false,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () => callback(),
            style: ElevatedButton.styleFrom(
              shape: const StadiumBorder(),
              backgroundColor: Theme.of(context).colorScheme.secondary,
              padding: const EdgeInsets.symmetric(vertical: 16.0),
            ),
            child: Text(
              textButton.toUpperCase(),
              style: Theme.of(context).textTheme.labelSmall,
            ),
          ),
        ),
      ),
    );
  }
}
