import 'package:diary_app/pages/profile/child/edit_profile_page.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../generic_bloc/user_bloc/user_bloc.dart';
import 'package:diary_app/model/user_model.dart' as userModel;

import '../../../repositories/firestore_repository.dart';
import '../../splash/splash_page.dart';


class ProfileWidget extends StatefulWidget {
  ProfileWidget({Key? key, this.editPress}) : super(key: key);

  VoidCallback? editPress;

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  VoidCallback? get _editPress => widget.editPress;
  UserBloc? _userBloc;
  FirestoreRepository _firestoreRepository = FirestoreRepository();

  @override
  void initState() {
    super.initState();
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        builder: (content, userState){
          return FutureBuilder<userModel.UserModel>(
            future: _firestoreRepository.getUserCredentials(),
            builder: (BuildContext context, snapshort){
              if(snapshort.hasError){
                return Text("Something went wrong");
              }
              if((snapshort.connectionState == ConnectionState.done) && snapshort.hasData){
                var userModel = snapshort.data;
                return _inforProfile(context, userModel);
              }
              return const SplashPage();
            },
          );
        });
  }


  Widget _inforProfile(BuildContext context, userModel.UserModel? userModel) => Column(
    children: [
      Container(
        alignment: Alignment.centerRight,
        child: IconButton(
          onPressed: _editPress,
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
            width: double.infinity - 50.w,
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
                      style: Theme.of(context).textTheme.caption?.copyWith(fontWeight: FontWeight.w500),
                      textAlign: TextAlign.left,
                    ),
                    SizedBox(height: 25.w,),
                  ],
                )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 30.w),
                    child: Text(
                      details,
                      style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
                    )),
                SizedBox(height: 15.w,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}





