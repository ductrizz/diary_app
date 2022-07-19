import 'dart:async';

import 'package:diary_app/pages/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generic_bloc/authentication_bloc/authentication_bloc.dart';
import '../../res/all_core.dart';
import '../base/base_button.dart';



class VerificationPage extends StatefulWidget {

  VerificationPage({Key? key}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  bool isVerified = false;
  AuthenticationBloc? _authenticationBloc;
  Timer? timer;
  User? userFirebase;
  var i = 1;
  @override
  void initState() {
    super.initState();
    userFirebase = FirebaseAuth.instance.currentUser;
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    isVerified =  userFirebase!.emailVerified;
    checkEmailVerified();
    if (!isVerified) {
      timer = Timer.periodic(const Duration(seconds: 3), (_) {
        print("Reload : ${++i}");
        checkEmailVerified();
      });
    }
  }

  Future<void> checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isVerified =  FirebaseAuth.instance.currentUser!.emailVerified;
      if (isVerified) timer?.cancel();
    });
  }



  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isVerified ? HomePage() :Scaffold(
    backgroundColor: Colors.cyan[100],
    body: SafeArea(
      child: Container(
        height: 400,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _titleVerification(),
            _widgetMessage(),
            const SizedBox(height: 25,),
            _buttonActions(),
            const SizedBox(height: 25,),
            _resentVerificationEmail(),
          ],
        ),
      ),
    ),
  );

  Widget _titleVerification() => Container(
      width: double.infinity,
      height: 80,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50), bottomRight: Radius.circular(50)),
        gradient: LinearGradient(
            colors: [Colors.cyanAccent, Colors.cyan],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verify your Email :',
            style: text20.bold,
            textAlign: TextAlign.center,
          ),
          Text(
            '${userFirebase?.email}',
            style: text16.semiBold.copyWith(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      )
  );

  Widget _widgetMessage() => Container(
    margin: const EdgeInsets.only(left: 10, right: 10, top: 20),
    child: Column(
      children: [
        Text(
          'A verification link has been sent to your mail, Click on the link to continue with your registration. Don\'t forget to check Spam Folders',
          style: text16.semiBold,
        ),
        SizedBox(height: 20,),
        Text(' If you are not automatically directed to the homepage after verification, click button "Reload" below',
          style: text16.semiBold),
      ],
    ),);

  Widget _buttonActions() => Container(
    margin: EdgeInsets.only(top: 10, left: 10, right: 10),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconAndTextButton(
          onPressed: () {
            _authenticationBloc?.add(AuthenticationEventSignOut());
          },
          baseIcon: Icons.logout,
          buttonName: "Cancel",
          width: MediaQuery.of(context).size.width /2.5,
          baseColor: Colors.red,
        ),
        IconAndTextButton(
          onPressed: () {
            checkEmailVerified();
          },
          baseIcon: Icons.refresh,
          buttonName: "Reload",
          width: MediaQuery.of(context).size.width /2.5,
          baseColor: Colors.green,
        ),
      ],
    ),
  );

  Widget _resentVerificationEmail() => Column(
    children: [
      Text("If you can't find the verification email:",
        style: text18.semiBold,),
      TextButton(
          onPressed: () async{
            await FirebaseAuth.instance.currentUser?.sendEmailVerification();
            print("Email :: ${FirebaseAuth.instance.currentUser?.email}");
          },
          child: Text("Resent Verificaiton Email",
            style: text18.copyWith(color: Colors.red, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
          ),
      )
    ],
  );
}

