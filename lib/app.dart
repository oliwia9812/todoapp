import 'package:flutter/material.dart';
import 'package:todoapp/bloc_observer.dart';
import 'package:todoapp/database/database_helper.dart';
import 'package:todoapp/injector.dart';
import 'package:todoapp/presentation/screens/intro/intro_screen.dart';
import 'package:todoapp/styles/app_themes.dart';
import 'blocs/bloc_exports.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Bloc.observer = SimpleBlocObserver();
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (BuildContext context) =>
              CategoryBloc(db: Injector().get<DatabaseHelper>())
                ..add(GetCategories()),
        ),
        BlocProvider<TaskBloc>(
          create: (BuildContext context) => TaskBloc(
              db: Injector().get<DatabaseHelper>(),
              categoryBloc: BlocProvider.of<CategoryBloc>(context))
            ..add(
              const GetTasks(),
            ),
        ),
        BlocProvider<ThemeBloc>(
          create: (BuildContext context) => ThemeBloc(),
        ),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeChanged) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const IntroScreen(),
              theme: state.theme,
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const IntroScreen(),
              theme: AppThemes.darkTheme,
            );
          }
        },
      ),
    );
  }
}
