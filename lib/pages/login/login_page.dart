import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../res/all_core.dart';
import '../base/base_button.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


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
      )
    );
  }

  ///child Widget::
  Widget _titleText() => Container(
    margin: const EdgeInsets.only(left: 20, right: 20, top: 20),
    child: Text(
      'Login',
      style: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w800,
          fontStyle: FontStyle.italic,
          color: Colors.blue[900]),
    ),
  );

  Widget _entryEmailAndPassword() => Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      children: [
        TextField(
          keyboardType: TextInputType.emailAddress,
          obscureText: false,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: true ? 'invalid email' : null,
          ),
        ),
        TextField(
          obscureText: false,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText:
            true ? 'invalid password' : null,
          ),
        )
      ],
    ),
  );

  Widget _accessButton() => Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: [
        TextButton(
          onPressed: () {
          },
          child: SizedBox(
            width: double.infinity,
            child: Text(
              'Forget Password ?',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
              ),
            ),
          ),
        ),
        TextElevationButton(
            onPressed: (){},
            buttonName: "Sign-in with email and password",baseColor: Colors.green,
        ),
        SizedBox(height: 10.w,),
        TextElevationButton(
            onPressed: (){},
            buttonName: "Sign-in with Google Account"),
        SizedBox(height: 10.w,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Don't have an Account ?",
            style: text16.bold,),
            TextButton(
              onPressed: () {
              },
              child: Text(
                'Sign Up',
                style: text18.bold.copyWith(
                    color: Colors.red,
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
