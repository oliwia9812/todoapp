import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todoapp/ui/screens/home/home_screen.dart';

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
              decoration: const BoxDecoration(
                color: AppColors.gray,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(35.0),
                  topRight: Radius.circular(35.0),
                ),
              ),
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
                        children: const [
                          Text(
                            'Organize your life',
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: 24.0,
                                fontWeight: FontWeight.w700),
                          ),
                          SizedBox(
                            height: 24.0,
                          ),
                          Text(
                            'Become focused, organized, and calm with ToDoApp. Top #1 task manager and to-do list in the world.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              color: AppColors.lightGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            backgroundColor: AppColors.blue,
                            padding: const EdgeInsets.symmetric(vertical: 18.0),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => HomeScreen()),
                              ),
                            );
                          },
                          child: Text(
                            'Get started'.toUpperCase(),
                            style: const TextStyle(
                                color: AppColors.white,
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold),
                          ),
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
