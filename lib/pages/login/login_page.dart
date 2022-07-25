import 'package:diary_app/pages/base/base_button.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generic_bloc/authentication_bloc/authentication_bloc.dart';
import '../loading/loading_page.dart';
import '../register/register_page.dart';
import 'login_bloc/login_bloc.dart';


class LoginPage extends StatefulWidget {
  static const String routerName = '/LoginPage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _entryEmailController = TextEditingController();
  final TextEditingController _entryPasswordController =
  TextEditingController();
  LoginBloc? _loginBloc;

  @override
  void initState() {
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _entryEmailController.addListener(() => _loginBloc
        ?.add(LoginEventEmailChanged(email: _entryEmailController.text)));
    _entryPasswordController.addListener(() => _loginBloc?.add(
        LoginEventPasswordChanged(password: _entryPasswordController.text)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        bloc: _loginBloc,
        listener: (context, loginState) {
          if (loginState.isFailure) {
            print('Log In is Fail');
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
              backgroundColor: Colors.grey.shade700.withOpacity(0.3),
              duration: Duration(seconds: 3),
                content: Container(
                    height: 50,
                    child: Center(child: Text(" Log In is Fail", style: text16,)))));
          } else if (loginState.isSuccess) {
            context.read<AuthenticationBloc>().add(AuthenticationEventSignIn());
          } else if (loginState.isSubmitting) {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoadingPage()));
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, loginState) {
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    _titleText(),
                    _entryEmailAndPassword(loginState: loginState),
                    _accessButton()
                  ],
                ),
              ),
            );
          },
        ),
      ),
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
          color: Colors.blue.shade900),
    ),
  );

  Widget _entryEmailAndPassword({LoginState? loginState}) => Container(
    margin: const EdgeInsets.all(20),
    child: Column(
      children: [
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _entryEmailController,
          style: Theme.of(context).textTheme.bodyText1,
          obscureText: false,
          decoration: InputDecoration(
            labelText: 'Email',
            helperText: '',
            errorText: !loginState!.isEmailValid ? 'invalid email' : null,
          ),
        ),
        TextField(
          controller: _entryPasswordController,
          style: Theme.of(context).textTheme.bodyText1,
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            helperText: '',
            errorText:
            !loginState.isPasswordValid ? 'invalid password' : null,
          ),
        )
      ],
    ),
  );

  Widget _accessButton() => Container(
    margin: const EdgeInsets.only(left: 20, right: 20),
    child: Column(
      children: [
        //Button Forget Password
        TextButton(
          onPressed: () {
          },
          child: const SizedBox(
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
        //Button Login with account
        TextElevationButton(onPressed: () {
          _loginBloc?.add(LoginEventSignIn(
              email: _entryEmailController.text,
              password: _entryPasswordController.text));
        },
            buttonName: 'Sign-in with email and password'),
        //Button Login With Google
        TextElevationButton(onPressed: () {
          _loginBloc?.add(LoginEventSignInWithGoogle());
        },
            buttonName: 'Sign-in with Google Account'),
        //Button Sign Up
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Don\'t have an Account ?'),
            TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const RegisterPage()));
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(
                  color: Colors.pink,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
