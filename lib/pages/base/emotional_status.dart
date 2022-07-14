import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum EmotionalStatus{
  smiley,
  power,
  happy, //hanh phuc
  unhappy, //buon
  angry, //tuc gian
  tired,
}
class IconStatus{
  static const double iconsize = 30;
  String status;
  IconStatus({required this.status});
  Widget get icon{
    print(status);
    switch(status){
      case "smiley": return Container(
        decoration : BoxDecoration(color: Color(0xFFFFFF8D), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.smiley);
      case "happy": return Container(
        decoration : BoxDecoration(color: Color(0xFFFFFF8D), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.happy,);
      case "unhappy": return Container(
        decoration : BoxDecoration(color: Color(0xFFB8B8AE), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.unhappy,);
      case "tired": return Container(
        decoration : BoxDecoration(color: Color(0xB26B7445), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.tired,);
      case "angry": return Container(
        decoration : BoxDecoration(color: Color(0xFFEF8F19), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.angry,);
      case "power": return IconStatus.power;
      default: return  Container(
        decoration : BoxDecoration(color: Color(0xFFFFFF8D), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.happy,);
    }
  }
  static const Icon smiley = Icon(FontAwesomeIcons.solidFaceSmileWink, size: iconsize, color: Color(0xFF0A0A0A),);
  static const Icon happy = Icon(FontAwesomeIcons.faceGrinHearts, size: iconsize, color: Color(0xFF0A0A0A),);
  static const Icon unhappy = Icon(FontAwesomeIcons.faceFrownOpen, size: iconsize, color: Color(0xFF0A0A0A),);
  static const Icon tired = Icon(FontAwesomeIcons.faceTired, size: iconsize, color: Color(0xFF0A0A0A),);
  static const Icon angry = Icon(FontAwesomeIcons.faceAngry, size: iconsize, color: Color(0xFF0A0A0A));
  static const Icon power = Icon(FontAwesomeIcons.solidHandBackFist, size: iconsize, color: Color(
      0xFFF8F870));
}