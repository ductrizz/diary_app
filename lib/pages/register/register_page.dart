import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../base/base_button.dart';



class RegisterPage extends StatefulWidget {
  static const String routerName = '/RegisterPage';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _entryDisplayNameController = TextEditingController();
  final TextEditingController _entryEmailController = TextEditingController();
  final TextEditingController _entryPasswordController = TextEditingController();
  final TextEditingController _entryConfirmPasswordController = TextEditingController();


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 50,
                ),
                _titleText(),
                _entryEmailAndPassword(),
                _accessButton()
              ],
            ),
          ),
        ));
  }

  ///child Widget::
  Widget _titleText() =>
      Container(
        margin: const EdgeInsets.all(20),
        child: Text(
          'Register Account',
          style: TextStyle(
              fontSize: 45,
              fontWeight: FontWeight.w800,
              fontStyle: FontStyle.italic,
              color: Colors.blue.shade900),
        ),
      );

  Widget _entryEmailAndPassword() =>
      Container(
        margin: EdgeInsets.all(20.w),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              controller: _entryDisplayNameController,
              onChanged: (value){
              },
              decoration: InputDecoration(
                labelText: "Display Name (*)",
                helperText: '',
                errorText: false
                    ? 'invalid Display Name'
                    : null,
              ),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _entryEmailController,
              onChanged: (value){

              },
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Email (*)',
                helperText: '',
                errorText: false
                    ? 'invalid email' : null,
              ),
            ),
            TextField(
              controller: _entryPasswordController,
              onChanged: (value){

              },
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password (*)',
                  helperText: '',
                  errorText: false
                      ? 'invalid password' : null),
            ),
            TextField(
              controller: _entryConfirmPasswordController,
              onChanged: (value){
              },
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Confirm Password (*)',
                  helperText: '',
                  errorText: false
                      ? 'The confirmation password must be the same as the password '
                      : null),
            )
          ],
        ),
      );

  Widget _accessButton() {
    var widthButton = MediaQuery
        .of(context)
        .size
        .width / 2.7;
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.all(20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconAndTextButton(
            onPressed: () {},
            baseIcon: Icons.logout,
            buttonName: "Cancel",
            baseColor: Colors.pink,
            width: widthButton,),
          IconAndTextButton(
            onPressed: () {},
            baseIcon: Icons.send,
            buttonName: "Sign-Up",
            baseColor: Colors.green,
            width: widthButton,)
        ],
      ),
    );
  }
}
