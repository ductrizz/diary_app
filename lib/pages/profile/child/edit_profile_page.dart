import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }

  Widget _imageProfile() => Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            print("Change Picture");
          },
          child: CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage("//image_url"),
          ),
        ),
        SizedBox(height: 10.w,),
        Text("Name :: Le duc tri",
          style: bodyTextApp.bold,
        ),
      ],
    ),
    height: 250,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.cyanAccent, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0)),
    ),
  );
}
