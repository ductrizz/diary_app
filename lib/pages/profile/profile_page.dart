import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Profile"),
        titleTextStyle: bodyTextApp,
        actions: [
          IconButton(
              onPressed: (){

              },
              icon: Icon(Icons.edit))
        ],
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }

  Widget _imageProfile() => Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 70,
          backgroundImage: NetworkImage("//image_url"),
        ),
        SizedBox(height: 10.w,),
        Text("Name :: Le duc tri",
          style: bodyTextApp,
        ),
      ],
    ),
    height: 250,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.purple, Colors.pink],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0)),
    ),
  );
  Widget _inforProfile() => Column(
    children: [

    ],
  );

  Widget userFields(){
    return Column();
  }
}

