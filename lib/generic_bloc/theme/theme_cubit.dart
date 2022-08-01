import 'package:diary_app/res/fonts/font_family.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../res/all_core.dart';

class ThemeCubit extends Cubit<ThemeData> {
  /// {@macro brightness_cubit}
  ThemeCubit() : super(_lightTheme);

  static final _lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: ligthColors().primaryColor,
    primaryColorDark: ligthColors().primaryColorDark,
    primaryColorLight: ligthColors().primaryColorLight,//Colors.cyan,
    backgroundColor: ligthColors().backgroundColor,
    scaffoldBackgroundColor: ligthColors().scaffoldBackgroundColor,//whiteColor,
    bottomAppBarColor: ligthColors().bottomAppBarColor,
    highlightColor: ligthColors().highlightColor,
    splashColor: ligthColors().splashColor,
    textTheme: customTextTheme,
    fontFamily: FontFamily.fontNormally,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      color: ligthColors().backgroundAppBarColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: ligthColors().statusBarColor,
      ),
    ),
  );

  static final _darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: darkColors().primaryColor,
    primaryColorDark: darkColors().primaryColorDark,
    primaryColorLight: darkColors().primaryColorLight,//Colors.cyan,
    backgroundColor: darkColors().backgroundColor,
    scaffoldBackgroundColor: darkColors().scaffoldBackgroundColor,//whiteColor,
    bottomAppBarColor: darkColors().bottomAppBarColor,
    highlightColor: darkColors().highlightColor,
    splashColor: darkColors().splashColor,
    textTheme: customTextTheme,
    fontFamily: FontFamily.fontNormally,
    appBarTheme: AppBarTheme(
      color: darkColors().backgroundAppBarColor,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: darkColors().statusBarColor,
      ),
    ),
  );
  /// Toggles the current brightness between light and dark.
  void toggleTheme() {
    emit(state.brightness == Brightness.dark ? _lightTheme : _darkTheme);
  }
}