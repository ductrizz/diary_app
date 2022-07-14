import 'package:diary_app/pages/write_diary/write_diary_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generic_bloc/authentication_bloc/authentication_bloc.dart';
import '../../generic_bloc/user_bloc/user_bloc.dart';
import '../../model/diary_entity.dart';
import '../../model/user_model.dart';
import 'child/item_diary.dart';


class HomePage extends StatefulWidget {
  static const String routerName = '/HomePage';
  User? userFirebase;
  HomePage({Key? key, this.userFirebase}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  User? get _userFirebase => widget.userFirebase;
  AuthenticationBloc? _authenticationBloc;
  UserBloc? _userBloc;


  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context)
      ..add(UserEventGetUser());
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    UserModel? userModel;
    List<DiaryEntity>? listDiary;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('HOME PAGE'),
        actions: [
          IconButton(
            key: const Key('btnRouteWrite',),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> WriteDiaryPage()));
            },
            icon: const Icon(Icons.add_box_outlined,),
            tooltip: "Add Diary",
          ),
          IconButton(
            key: const Key('btnSignOut',),
            onPressed: (){
              _authenticationBloc?.add(AuthenticationEventSignOut());
            },
            icon: const Icon(Icons.logout,),
            tooltip: "Sign Out",
          ),
        ],
      ),
      body:  BlocBuilder<UserBloc, UserState>(
          builder: (context, userState){
            if(userState is UserStateInitial){
              print('Initial HomePage');
            }else if(userState is UserStateSuccess){
              userModel = userState.userModel;
              listDiary = userState.diaryEntities;
            }else if(userState is UserStateFailure){
              print('Failure HomePage');
            }
            return ListView.builder(
                itemCount: listDiary?.length ?? 0,
                itemBuilder: (context, index){
                  DiaryEntity _diaryEntity = listDiary![index];
                  return ItemDiary(diaryEntity : _diaryEntity);
                });
          }),
    );
  }
}


