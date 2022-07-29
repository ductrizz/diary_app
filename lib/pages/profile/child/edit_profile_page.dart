import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  TextEditingController _genderController = TextEditingController();
  TextEditingController _birthdayController = TextEditingController();

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
            TextField(
              controller: _genderController,
              style: Theme.of(context).textTheme.bodyText1,
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Gender',
              ),
            ),
            TextField(
              controller: _birthdayController,
              style: Theme.of(context).textTheme.bodyText1,
              obscureText: false,
              decoration: const InputDecoration(
                labelText: 'Birthday',
              ),
            )
          ],
        ),
      ),
    );
  }

}
