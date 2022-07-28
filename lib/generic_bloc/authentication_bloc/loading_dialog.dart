import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';

Future<dynamic> showDialogLoading(BuildContext context) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return SimpleDialog(
          elevation: 10.w,
          contentPadding: EdgeInsets.all(90.w),
          backgroundColor: Colors.transparent,
          children: [CircularProgressIndicator(
            strokeWidth: 8.w,
            backgroundColor: Colors.grey,
            valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
          ),],
        );
      });
}