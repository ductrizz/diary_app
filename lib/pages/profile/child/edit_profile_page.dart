import 'dart:ui';

import 'package:diary_app/generic_bloc/user_bloc/user_bloc.dart';
import 'package:diary_app/model/user_model.dart';
import 'package:diary_app/pages/base/base_button.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key? key,
    required this.displayName,
    required this.gender,
    required this.birthday,
  }) : super(key: key);
  String displayName;
  String gender;
  String birthday;

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _displayNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _displayNameController.text = widget.displayName;
    _genderController.text = widget.gender;
    _birthdayController.text = widget.birthday;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        titleTextStyle: Theme.of(context).textTheme.headline5,
      ),
      body: Container(
        margin: EdgeInsets.all(10.w),
        child: Column(
          children: [
            SizedBox(height: 20.w,),
            TextField(
              controller: _displayNameController,
              style: Theme.of(context).textTheme.bodyText1,
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Gender',
              ),
            ),
            SizedBox(height: 10.w,),
            TextField(
              controller: _genderController,
              style: Theme.of(context).textTheme.bodyText1,
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Gender',
              ),
            ),
            SizedBox(height: 10.w,),
            TextField(
              controller: _birthdayController,
              style: Theme.of(context).textTheme.bodyText1,
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Birthday',
              ),
            ),
            SizedBox(height: 50.w,),
            IconAndTextButton(onPressed:(){
              context.read<UserBloc>().add(UserEventUpdateInforUser(userModel: UserModel(
                displayName: _displayNameController.text,
                gender: _genderController.text,
                birthday: _birthdayController.text,
              )));
            },
              baseIcon: Icons.save,
              buttonName: "Save New Information",
              baseColor: Colors.green,
            ),
            SizedBox(height: 10.w,),
            IconAndTextButton(onPressed:(){},
              baseIcon: Icons.logout,
              buttonName: "Cancel",
              baseColor: Colors.pink,),
          ],
        ),
      ),
    );
  }

}
