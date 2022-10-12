import 'package:flutter/material.dart';
import 'package:todoapp/presentation/widgets/logo.dart';
import 'package:todoapp/styles/app_decorations.dart';
import 'package:todoapp/presentation/screens/home/home_screen.dart';
import 'package:todoapp/presentation/widgets/custom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          _getHeader(),
          _getBody(context),
        ],
      ),
    );
  }

  Widget _getHeader() {
    return Expanded(
      child: Center(
        child: AppLogo(),
      ),
    );
  }

  Widget _getBody(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: AppDecorations.bottomModal(context),
        padding: const EdgeInsets.fromLTRB(33.0, 84.0, 33.0, 64.0),
        child: Stack(
          children: [
            Align(
              child: Column(
                children: [
                  Text(
                    'Organize your life',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 24.0,
                  ),
                  Text(
                    'Become focused, organized, and calm with ToDoApp. Top #1 task manager and to-do list in the world.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: CustomButton(
                textButton: 'Get started',
                callback: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((context) => const HomeScreen()),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
