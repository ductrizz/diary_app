import 'package:diary_app/pages/child_widget/avata_widget.dart';
import 'package:diary_app/pages/profile/child/edit_profile_page.dart';
import 'package:diary_app/pages/profile/child/profile_widget.dart';
import 'package:diary_app/repositories/firestore_repository.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        titleTextStyle: Theme.of(context).textTheme.headline5,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1,
              child: AvatarWidget()),
          Expanded(
            flex: 2,
            child: ProfileWidget(
                editPress: () async{
                  var user = await FirestoreRepository().getUserCredentials();
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => EditProfilePage(
                        displayName: user.displayName ?? "",
                        gender: user.gender ?? "",
                        birthday: user.birthday ?? "",)));
                },
              ),
          ),
        ],
      ),
    );
  }
}


/*import 'package:diary_app/generic_bloc/authentication_bloc/loading_dialog.dart';
import 'package:diary_app/generic_bloc/user_bloc/user_bloc.dart';
import 'package:diary_app/pages/base/base_button.dart';
import 'package:diary_app/pages/splash/splash_page.dart';
import 'package:diary_app/repositories/firestore_repository.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diary_app/model/user_model.dart' as userModel;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserBloc? _userBloc;
  FirestoreRepository _firestoreRepository = FirestoreRepository();

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Profile"),
        titleTextStyle: bodyTextApp,
      ),
        // body:
        // FutureBuilder<userModel.UserModel>(
        //     future: _firestoreRepository.getUserCredentials(),
        //     builder: (BuildContext context, snapshort){
        //       if(snapshort.hasError){
        //         return Text("Something went wrong");
        //       }
        //       if((snapshort.connectionState == ConnectionState.done) && snapshort.hasData){
        //         var userModel = snapshort.data;
        //         return BlocBuilder<UserBloc, UserState>(
        //           builder: (context, userState){
        //             return Column(
        //               children: [
        //                 _imageProfile(userModel),
        //                 _inforProfile(context, userModel)
        //               ],
        //             );
        //           },
        //         );
        //       }
        //       return SplashPage();
        //     },
        //   ),
      body: BlocBuilder<UserBloc, UserState>(builder: (context, userState){
        if(userState is UserStateImagePickerSuccessful){
          Navigator.of(context).pop();
        }
        return FutureBuilder<userModel.UserModel>(
          future: _firestoreRepository.getUserCredentials(),
          builder: (BuildContext context, snapshort){
            if(snapshort.hasError){
              return Text("Something went wrong");
            }
            if((snapshort.connectionState == ConnectionState.done) && snapshort.hasData){
              var userModel = snapshort.data;
              return Column(
                children: [
                  _imageProfile(userModel),
                  _inforProfile(context, userModel)
                ],
              );
            }
            return SplashPage();
          },
        );
      },

      )

    );
  }

  Widget _imageProfile(userModel.UserModel? userModel) => Container(
    height: 250,
    width: double.infinity,
    decoration: const BoxDecoration(
      gradient: LinearGradient(
          colors: [Colors.cyanAccent, Colors.blue],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter),
      borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(20.0),
          bottomLeft: Radius.circular(20.0)),
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Change Picture",
            onPressed: (){
              print("update Image");
              showDialogLoading(context);
              _userBloc?.add(UserEventImagePicker());
            },
          ),
        ),
        CircleAvatar(
          radius: 80,
          backgroundImage: NetworkImage("${userModel?.imageUrl ?? "https://media.travelmag.vn/files/thuannguyen/2020/04/25/cach-chup-anh-dep-tai-da-lat-1-2306.jpeg"}"),
        ),
        SizedBox(height: 10.w,),
        Text("${userModel?.displayName}",
          style: bodyTextApp.bold,
        ),
      ],
    ),
  );

  Widget _inforProfile(BuildContext context, userModel.UserModel? userModel) => Column(
    children: [
      Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: (){},
          icon: Icon(Icons.edit_note, size: 30.w,),
        ),
      ),
      userFields(
        context,
        icon: Icons.mail,
        title: 'Email',
        details: "${userModel?.email}",
      ),

      userFields(context,
          icon: Icons.person_outline, title: 'Gender', details: "Male"),

      userFields(
        context,
        icon: Icons.calendar_month,
        title: 'Birthday',
        details: "25-08-1993"),

    ],
  );

  Widget userFields(BuildContext context, {
    required IconData icon,
    required String title,
    required String details}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Container(
            width: double.infinity - 50,
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1.0, color: Colors.grey),
              ),
            ),
            child: Column(
              children: [
                (Row(
                  children: [
                    Icon(
                      icon,
                      size: 17,
                    ),
                    SizedBox(height: 10.w,),
                    Text(
                      title,
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 40.w,),
                  ],
                )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 35),
                    child: Text(
                      details,
                      style: Theme.of(context).textTheme.headline5,
                    )),
                SizedBox(height: 15.w,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/

