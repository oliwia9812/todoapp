part of 'theme_bloc.dart';

abstract class ThemeState extends Equatable {
  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitial extends ThemeState {}

class ThemeChanged extends ThemeState {
  final ThemeData theme;

  const ThemeChanged({required this.theme});
}
