import 'package:flutter/material.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.blue,
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(35.0),
              ),
              backgroundColor: AppColors.gray,
              context: context,
              builder: (context) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 33.0, vertical: 64.0),
                  height: 300.0,
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Task name',
                            style: TextStyle(
                              color: AppColors.lightGray,
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide:
                                    BorderSide(color: AppColors.lightGray),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              backgroundColor: AppColors.blue,
                              padding:
                                  const EdgeInsets.symmetric(vertical: 18.0),
                            ),
                            onPressed: () {},
                            child: Text(
                              'Add task'.toUpperCase(),
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
                );
              });
        },
      ),
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 64.0,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 48.0,
                  height: 48.0,
                ),
                const SizedBox(height: 36.0),
                const Text(
                  'My tasks',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const Center(
              child: Text(
                'Add your first task',
                style: TextStyle(
                  color: AppColors.lightGray,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
