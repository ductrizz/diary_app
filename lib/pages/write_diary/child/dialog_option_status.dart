import 'package:diary_app/pages/base/emotional_status.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';

SimpleDialog dialogOptionStatus(BuildContext context) => SimpleDialog(
  title: Text('How do you feel today?'),
  titleTextStyle: titleTextApp.copyWith(color: Colors.black),
  children:[
    _simpleDialogOption(context, EmotionalStatus.smiley),
    _simpleDialogOption(context, EmotionalStatus.happy),
    _simpleDialogOption(context, EmotionalStatus.unhappy),
    _simpleDialogOption(context, EmotionalStatus.tired),
    _simpleDialogOption(context, EmotionalStatus.angry),
    _simpleDialogOption(context, EmotionalStatus.power),
  ],
  elevation: 10,
  //backgroundColor: Colors.green,
);

SimpleDialogOption _simpleDialogOption(BuildContext context, EmotionalStatus emotionalStatus) {
  return SimpleDialogOption(
      onPressed: () {
        Navigator.pop(context, emotionalStatus.name); },
      child: Row(children: [
        IconStatus(status: emotionalStatus.name).icon,
        SizedBox(width: 10,),
        Text(emotionalStatus.stringStatus, style: normalTextApp.copyWith(color: Colors.black),)
      ],)
  );
}