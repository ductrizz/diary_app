import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../colors_core.dart';
import '../dimens.dart';
import 'font_app.dart';

const TextStyle fontApp = TextStyle(fontFamily: FontFamily.fontNormally ,fontWeight: FontWeight.w400);

const TextStyle fontDiary = TextStyle(fontFamily: FontFamily.fontDiary);

TextStyle get titleDiaryText => fontDiary.copyWith(fontWeight: FontWeight.bold, fontSize: 24.sp);

TextStyle get contentDiaryText => fontDiary.copyWith(fontWeight: FontWeight.w400, fontSize: 16.sp);

TextStyle get dateDiaryText => fontDiary.copyWith(fontWeight: FontWeight.w500, fontSize: 18.sp, fontStyle: FontStyle.italic);

TextStyle get titleTextApp => fontApp.copyWith(fontWeight: FontWeight.bold, fontSize: 22.sp);

TextStyle get headerTextApp => fontApp.copyWith(fontWeight: FontWeight.bold, fontSize: 18.sp);

TextStyle get bodyTextApp => fontApp.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp);

TextStyle get buttonTextApp => fontApp.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp);

TextStyle get notificationText => fontApp.copyWith(fontWeight: FontWeight.bold, fontSize: 16.sp);

TextStyle get contentDialogText => fontApp.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp);

TextStyle get titleDialogText => fontApp.copyWith(fontWeight: FontWeight.bold, fontSize: 20.sp);




TextStyle get text10 => fontApp.copyWith(fontSize: 10.sp);

TextStyle get text12 => fontApp.copyWith(fontSize: 12.sp);

TextStyle get text14 => fontApp.copyWith(fontSize: 14.sp);

TextStyle get text15 => fontApp.copyWith(fontSize: 15.sp);

TextStyle get text16 => fontApp.copyWith(fontSize: 16.sp);

TextStyle get text18 => fontApp.copyWith(fontSize: 18.sp);

TextStyle get text20 => fontApp.copyWith(fontSize: 20.sp);

TextStyle get text24 => fontApp.copyWith(fontSize: 24.sp);

TextStyle get text26 => fontApp.copyWith(fontSize: 26.sp);

TextStyle get text28 => fontApp.copyWith(fontSize: 28.sp);

TextStyle get text30 => fontApp.copyWith(fontSize: 30.sp);

TextStyle get text34 => fontApp.copyWith(fontSize: 34.sp);

extension TextStyleExt on TextStyle {
  //Decoration style
  TextStyle get none => copyWith(decoration: TextDecoration.none);

  TextStyle get underLine => copyWith(decoration: TextDecoration.underline);

  TextStyle get overLine => copyWith(decoration: TextDecoration.overline);

  TextStyle get lineThrough => copyWith(decoration: TextDecoration.lineThrough);

  TextStyle get thickNess2 => copyWith(decorationThickness: 2);

  TextStyle get decorationBlack => copyWith(decorationColor: Colors.black);

  //Weight style
  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get bold => copyWith(fontWeight: FontWeight.w700);

  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  //Font style
  TextStyle get italic => copyWith(fontStyle: FontStyle.italic);

  //height style
  TextStyle get height16Per => copyWith(height: 1.6);

  TextStyle get height17Per => copyWith(height: 1.7);

  TextStyle get height18Per => copyWith(height: 1.8);

  TextStyle get height19Per => copyWith(height: 1.9);

  TextStyle get height20Per => copyWith(height: 2.0);

  TextStyle get height21Per => copyWith(height: 2.1);

  TextStyle get height22Per => copyWith(height: 2.2);
}

TextTheme customTextTheme({
  required TextStyle titleDiaryText,
  required TextStyle titleTextApp,
  required TextStyle titleDialogText,
  required TextStyle headerTextApp,
  required TextStyle dateDiaryText,
  required TextStyle contentDiaryText,
  required TextStyle bodyTextApp,
  required TextStyle buttonTextApp,
  required TextStyle notificationText,
  required TextStyle contentDialogText,
}){
  return TextTheme(
    titleMedium: titleTextApp,
    titleSmall: titleDiaryText,
    headline1: titleDialogText,
    headline2: headerTextApp,
    bodyLarge: dateDiaryText,
    bodyMedium: contentDiaryText,
    bodyText1: bodyTextApp,
    caption: notificationText,
    button: buttonTextApp,
    bodyText2: contentDialogText,
  );
}

TextTheme get textThemeLight => customTextTheme(
    titleDiaryText: titleDiaryText.copyWith(color: Colors.black),
    titleTextApp: titleTextApp.copyWith(color: Colors.black),
    titleDialogText: titleDialogText.copyWith(color: Colors.red.shade900),
    headerTextApp: headerTextApp.copyWith(color: Colors.black),
    dateDiaryText: dateDiaryText.copyWith(color: Colors.black),
    contentDiaryText: contentDiaryText.copyWith(color: Colors.black),
    bodyTextApp: bodyTextApp.copyWith(color: Colors.black),
    buttonTextApp: buttonTextApp.copyWith(color: Colors.black),
    notificationText: notificationText.copyWith(color: Colors.blue.shade800),
    contentDialogText: contentDialogText..copyWith(color: Colors.blue.shade900)
);

TextTheme get textThemeDark => customTextTheme(
    titleDiaryText: titleDiaryText.copyWith(color: Colors.white),
    titleTextApp: titleTextApp.copyWith(color: Colors.white),
    titleDialogText: titleDialogText.copyWith(color: Colors.yellowAccent),
    headerTextApp: headerTextApp.copyWith(color: Colors.white),
    dateDiaryText: dateDiaryText.copyWith(color: Colors.white),
    contentDiaryText: contentDiaryText.copyWith(color: Colors.white),
    bodyTextApp: bodyTextApp.copyWith(color: Colors.white),
    buttonTextApp: buttonTextApp.copyWith(color: Colors.white),
    notificationText: notificationText.copyWith(color: Colors.yellowAccent),
    contentDialogText: contentDialogText..copyWith(color: Colors.yellowAccent)
);