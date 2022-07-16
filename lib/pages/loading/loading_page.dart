import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(
              strokeWidth: 10,
              backgroundColor: Colors.grey,
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.blueAccent),
            ),
          ),
        ),
      ),
    );
  }
}
