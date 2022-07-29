import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generic_bloc/user_bloc/user_bloc.dart';
import '../../repositories/firestore_repository.dart';
import 'package:diary_app/model/user_model.dart' as userModel;

import '../splash/splash_page.dart';

class AvatarWidget extends StatefulWidget {
  AvatarWidget({Key? key,
    this.radiusCircle = 70,
    this.allowEdit = true
  }) : super(key: key);

  bool allowEdit;
  final double radiusCircle;

  @override
  State<AvatarWidget> createState() => _AvatarWidgetState();
}

class _AvatarWidgetState extends State<AvatarWidget> {
  double get _radiusCircle=> widget.radiusCircle;
  bool get _allowEdit => widget.allowEdit;
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
                  return  _imageProfile(userModel);
                }
                return const SplashPage();
              },
          );
        });
  }
  Widget _imageProfile(userModel.UserModel? userModel) => Container(
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
        _allowEdit ? Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Change Picture",
            onPressed: (){
              _userBloc?.add(UserEventImagePicker());
            },
          ),
        ) : const SizedBox.shrink(),
        CircleAvatar(
          radius: _radiusCircle.w,
          backgroundImage: NetworkImage("${userModel?.imageUrl ?? "https://media.travelmag.vn/files/thuannguyen/2020/04/25/cach-chup-anh-dep-tai-da-lat-1-2306.jpeg"}"),
        ),
        SizedBox(height: 10.w,),
        Text("${userModel?.displayName}",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.w,),
      ],
    ),
  );
 /* Widget _imageProfile(userModel.UserModel? userModel) => Container(
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
        _allowEdit ? Container(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Change Picture",
            onPressed: (){
              _userBloc?.add(UserEventImagePicker());
            },
          ),
        ) : const SizedBox.shrink(),
        CircleAvatar(
          radius: _radiusCircle.w,
          backgroundImage: NetworkImage("${userModel?.imageUrl ?? "https://media.travelmag.vn/files/thuannguyen/2020/04/25/cach-chup-anh-dep-tai-da-lat-1-2306.jpeg"}"),
        ),
        SizedBox(height: 10.w,),
        Text("${userModel?.displayName}",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 5.w,),
      ],
    ),
  );*/
}
