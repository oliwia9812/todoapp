import 'package:flutter/material.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/injector.dart';
import 'package:todoapp/styles/app_colors.dart';
import 'package:todoapp/ui/screens/intro/intro_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blocs/bloc_exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskBloc(db: Injector().get<DatabaseHelper>()),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.montserratTextTheme(),
          unselectedWidgetColor: AppColors.lightGray,
        ),
        debugShowCheckedModeBanner: false,
        home: const IntroScreen(),
      ),
    );
  }
}
