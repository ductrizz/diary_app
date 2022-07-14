import 'package:flutter/material.dart';
import '../../res/all_core.dart';
import '../base/base_button.dart';



class VerificationPage extends StatefulWidget {

  VerificationPage({Key? key,}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
  }

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
            'xxxx@mail.com',
            style: text16.semiBold.copyWith(fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
      )
  );

  Widget _widgetMessage() => Container(
    margin: EdgeInsets.only(left: 10, right: 10, top: 20),
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
          },
          baseIcon: Icons.logout,
          buttonName: "Cancel",
          width: MediaQuery.of(context).size.width /2.5,
          baseColor: Colors.red,
        ),
        IconAndTextButton(
          onPressed: () {
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
          onPressed: (){},
          child: Text("Resent Verificaiton Email",
            style: text18.copyWith(color: Colors.red, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500, decoration: TextDecoration.underline),
          ),
      )
    ],
  );
}

