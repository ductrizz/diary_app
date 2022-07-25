import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import '../colors_core.dart';
import '../dimens.dart';
import 'font_family.dart';

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




TextTheme get customTextTheme => TextTheme(
  subtitle1: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.normal, fontSize: 14.sp),
  subtitle2: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.bold, fontSize: 14.sp),
  caption: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.normal, fontSize: 14.sp),
  bodyText1: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.w400, fontSize: 18.sp),
  bodyText2: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.w400, fontSize: 16.sp),
  headline6: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.normal, fontSize: 24.sp),
  headline5: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.bold, fontSize: 26.sp),
  headline4: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.bold, fontSize: 28.sp),
  headline3: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.w600, fontSize: 20.sp),
  headline2: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.w600, fontSize: 24.sp),
  headline1: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.bold, fontSize: 36.sp),
  button: TextStyle(fontFamily: FontFamily.fontNormally, fontWeight: FontWeight.bold, fontSize: 18.sp),
);

TextTheme get customPrimaryTextTheme => TextTheme(
  subtitle1: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.normal, fontSize: 14.sp),
  subtitle2: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.bold, fontSize: 14.sp),
  caption: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.normal, fontSize: 12.sp),
  bodyText1: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.w400, fontSize: 16.sp),
  bodyText2: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.w400, fontSize: 16.sp),
  headline6: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.normal, fontSize: 22.sp),
  headline5: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.bold, fontSize: 24.sp),
  headline4: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.bold, fontSize: 16.sp),
  headline3: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.w600, fontSize: 18.sp),
  headline2: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.w600, fontSize: 22.sp),
  headline1: TextStyle(fontFamily: FontFamily.fontDiary, fontWeight: FontWeight.bold, fontSize: 34.sp),
);