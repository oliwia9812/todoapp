import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/styles/app_decorations.dart';
import 'package:todoapp/styles/text_styles/app_text_styles.dart';
import 'package:todoapp/ui/screens/home/home_screen.dart';
import 'package:todoapp/ui/widgets/cutom_button.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Expanded(
            child: Center(
              child: SvgPicture.asset('assets/images/logo.svg'),
            ),
          ),
          Expanded(
            child: Container(
              decoration: AppDecorations.bottomModal(),
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 33.0,
                  top: 84.0,
                  right: 33.0,
                  bottom: 64.0,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        children: [
                          Text(
                            'Organize your life',
                            style: AppTextStyles.title(color: AppColors.white),
                          ),
                          const SizedBox(
                            height: 24.0,
                          ),
                          Text(
                            'Become focused, organized, and calm with ToDoApp. Top #1 task manager and to-do list in the world.',
                            textAlign: TextAlign.center,
                            style: AppTextStyles.standard(),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
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
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
