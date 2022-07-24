
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBarCus({
  required BuildContext context,
  required String message,
  int duration = 3,
}){
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.grey[300],
    duration: Duration(seconds: duration),
    content: Text(message,
      style: bodyTextApp.semiBold.copyWith(color: Colors.blue.shade800),),
  ),
  );
}