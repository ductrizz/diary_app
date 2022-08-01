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
    switch(status){
      case "smiley": return Container(
        decoration : BoxDecoration(color: const Color(0xFFFFFF8D), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.smiley);
      case "happy": return Container(
        decoration : BoxDecoration(color: const Color(0xFFFFFF8D), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.happy,);
      case "unhappy": return Container(
        decoration : BoxDecoration(color: const Color(0xFFB8B8AE), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.unhappy,);
      case "tired": return Container(
        decoration : BoxDecoration(color: const Color(0xB26B7445), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.tired,);
      case "angry": return Container(
        decoration : BoxDecoration(color: const Color(0xFFEF8F19), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.angry,);
      case "power": return IconStatus.power;
      default: return  Container(
        decoration : BoxDecoration(color: const Color(0xFFFFFF8D), borderRadius: BorderRadius.circular(15)),
        child: IconStatus.happy,);
    }
  }
  static const Icon smiley = Icon(FontAwesomeIcons.faceSmile, size: iconsize, color: Color(0xFF0A0A0A),);
  static const Icon happy = Icon(FontAwesomeIcons.faceGrinHearts, size: iconsize, color: Color(0xFF0A0A0A),);
  static const Icon unhappy = Icon(FontAwesomeIcons.faceFrownOpen, size: iconsize, color: Color(0xFF0A0A0A),);
  static const Icon tired = Icon(FontAwesomeIcons.faceTired, size: iconsize, color: Color(0xFF0A0A0A),);
  static const Icon angry = Icon(FontAwesomeIcons.faceAngry, size: iconsize, color: Color(0xFF0A0A0A));
  static const Icon power = Icon(FontAwesomeIcons.solidHandBackFist, size: iconsize, color: Color(
      0xFFE0881C));
}

extension UploadDocumentNameExt on  EmotionalStatus{
  String get name {
    switch (this) {
      case EmotionalStatus.smiley:
        return 'smiley';
      case EmotionalStatus.happy:
        return 'happy';
      case EmotionalStatus.unhappy:
        return 'unhappy';
      case EmotionalStatus.angry:
        return 'angry';
      case EmotionalStatus.tired:
        return 'tired';
      case EmotionalStatus.power:
        return 'power';
      default:
        return 'smiley';
    }
  }
}

extension UploadDocumentStringStatus on  EmotionalStatus{
  String get stringStatus {
    switch (this) {
      case EmotionalStatus.smiley:
        return 'A beautiful day';
      case EmotionalStatus.happy:
        return 'I feel so happy';
      case EmotionalStatus.unhappy:
        return "I'm so sad";
      case EmotionalStatus.angry:
        return 'I was angry';
      case EmotionalStatus.tired:
        return 'A tired day';
      case EmotionalStatus.power:
        return 'I feel full of energy';
      default:
        return 'A beautiful day';
    }
  }
}