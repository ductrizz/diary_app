import 'package:diary_app/generic_bloc/authentication_bloc/authentication_bloc.dart';
import 'package:diary_app/repositories/user_repository.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../base/base_button.dart';
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
  AuthenticationBloc? _authenticationBloc;
  UserRepository userRepository = UserRepository();
  bool isExisted = false;

  @override
  void initState() {
    super.initState();
    _registerBloc = BlocProvider.of<RegisterBloc>(context);
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
  }

  Future<void> checkEmailExisted() async{
    isExisted = await userRepository.isEmailExisted(email: _entryEmailController.text);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterBloc, RegisterState>(
      bloc: _registerBloc,
      listener: (context, registerState){
        if(registerState.isFailure){

        }else if(registerState.isSubmitting){

        }else if(registerState.isSuccess){
          _authenticationBloc?.add(AuthenticationEventSignOut());
          Navigator.pop(context);
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
                _entryDisplayNameController.addListener(() => _registerBloc?.add(
                    RegisterEventDisplayNameChanged(displayName: value)));
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
                _entryEmailController.addListener(() => _registerBloc?.add(
                    RegisterEventEmailChanged(email: value)));
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
                _entryPasswordController.addListener(() => _registerBloc?.add(
                    RegisterEventPasswordChanged(password: value)));
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
                _entryConfirmPasswordController.addListener(() => _registerBloc?.add(
                    RegisterEventConfirmPasswordChanged(password: value)));
              },
              obscureText: true,
              decoration: InputDecoration(
                  labelText: 'Confirm Password (*)',
                  helperText: '',
                  errorText: registerState.isConfirmPasswordValid ? null :
                  'The confirmation password must be the same as the password'),
            )
          ],
        ),
      );

  Widget _accessButton() {
    var widthButton = MediaQuery.of(context).size.width / 2.7;
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
              await checkEmailExisted();
              if(isExisted){
                ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                    backgroundColor: Colors.grey.shade900.withOpacity(0.3),
                    duration: const Duration(seconds: 3),
                    content: SizedBox(
                        height: 50.w,
                        child: Center(child: Text(" Email is Exited! Please Change Email", style: text16.copyWith(color: Colors.black),)))));
              }else{
                _registerBloc?.add(RegisterEventSignUp(
                    email: _entryEmailController.text,
                    password: _entryPasswordController.text,
                    displayName: _entryDisplayNameController.text));
              }
            },
            baseIcon: Icons.send,
            buttonName: "Sign-Up",
            baseColor: Colors.green,
            width: widthButton,)
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _entryEmailController.dispose();
    _entryPasswordController.dispose();
    _entryDisplayNameController.dispose();
    _entryConfirmPasswordController.dispose();
  }
}
