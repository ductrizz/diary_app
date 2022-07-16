import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/user_model.dart';
import '../base/base_button.dart';
import '../login/login_page.dart';
import 'register_bloc/register_bloc.dart';



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
  RegisterBloc? _registerBloc;
  UserModel? _userModel;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      bloc: _registerBloc,
      listener: (context, registerState){
        if(registerState.isFailure){
          print('Register is failure');
        }else if(registerState.isSubmitting){
          print('Register is Submitting');
        }else if(registerState.isSuccess){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=> LoginPage()));
        }
      },
        child: BlocBuilder<RegisterBloc, RegisterState>(
          builder: (context, registerState) {
            return Scaffold(
                body: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 50.w,
                        ),
                        _titleText(),
                        _entryEmailAndPassword(registerState: registerState),
                        _accessButton()
                      ],
                    ),
                  ),
                ));
          },
        ),);
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

  Widget _entryEmailAndPassword({required RegisterState registerState}) =>
      Container(
        margin: EdgeInsets.all(20.w),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              controller: _entryDisplayNameController,
              onChanged: (value){
                _registerBloc?.add(RegisterEventDisplayNameChanged());
              },
              decoration: InputDecoration(
                labelText: "Display Name (*)",
                helperText: '',
                errorText: (registerState.isDisplayName) ? null :'invalid Display Name',
              ),
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              controller: _entryEmailController,
              onChanged: (value){
                _registerBloc?.add(RegisterEventEmailChanged());
              },
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Email (*)',
                helperText: '',
                errorText: registerState.isEmailValid ? null : 'invalid email',
              ),
            ),
            TextField(
              controller: _entryPasswordController,
              onChanged: (value){
                _registerBloc?.add(RegisterEventPasswordChanged());
              },
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Password (*)',
                  helperText: '',
                  errorText: registerState.isPasswordValid ? null :'invalid password'),
            ),
            TextField(
              controller: _entryConfirmPasswordController,
              onChanged: (value){
                _registerBloc?.add(RegisterEventConfirmPasswordChanged());
              },
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Confirm Password (*)',
                  helperText: '',
                  errorText: registerState.isConfirmPasswordValid ? null : 'The confirmation password must be the same as the password '),
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
            onPressed: () {
              Navigator.of(context).pop();
            },
            baseIcon: Icons.logout,
            buttonName: "Cancel",
            baseColor: Colors.pink,
            width: widthButton,),
          IconAndTextButton(
            onPressed: () async{
              _registerBloc?.add(RegisterEventSignUp(
                  email: _entryEmailController.text,
                  password: _entryPasswordController.text,
                  displayName: _entryDisplayNameController.text));

            },
            baseIcon: Icons.send,
            buttonName: "Sign-Up",
            baseColor: Colors.green,
            width: widthButton,)
        ],
      ),
    );
  }
}
