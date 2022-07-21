import 'package:diary_app/pages/base/base_button.dart';
import 'package:diary_app/pages/write_diary/write_diary_page.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../generic_bloc/authentication_bloc/authentication_bloc.dart';
import '../../generic_bloc/user_bloc/user_bloc.dart';
import '../../model/diary_entity.dart';
import '../../model/user_model.dart';
import 'child/item_diary.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key,}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  AuthenticationBloc? _authenticationBloc;
  UserBloc? _userBloc;
  UserModel? userModel;
  List<DiaryEntity>? listDiary;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context)
      ..add(UserEventGetUser());
    super.initState();
  }

  void canWriteNew(){
    var fecthDiaryToday = listDiary?.where((diary) => diary.dateTime == DateTime.now().toDay);
    print("fecthDiaryToday:: ${fecthDiaryToday?.isNotEmpty}");
    if (fecthDiaryToday?.isNotEmpty ?? false){
      showDialog(context: context, builder: (BuildContext context) => AlertDialog(
        title: Text("Diary Already Exists!",),
        titleTextStyle: titleTextApp.copyWith(color: Colors.red.shade900),
        content: Text("Today's diary already exists. Do you want to modify?"),
        contentTextStyle: notificationTextApp.copyWith(color: Colors.black),
        actions: [
          CustomTextButton(onPressed: (){
            Navigator.of(context).pop();
          }, buttonName: "Cancel"),
          CustomTextButton(onPressed: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=> WriteDiaryPage(diaryEntity: fecthDiaryToday!.first,)));
          },
              buttonName: "Modify"),
          CustomTextButton(onPressed: (){
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context)=> WriteDiaryPage()));
          },
              buttonName: "Write New"),
        ],
      ));
    }else{
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=> WriteDiaryPage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('HOME PAGE'),
        actions: [
          IconButton(
            key: const Key('btnRouteWrite',),
            onPressed: (){
              canWriteNew();
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
              /*ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  content: Text(" Write Success") ));*/
            }else if(userState is UserStateSuccess){
              userModel = userState.userModel;
              listDiary = userState.diaryEntities;
            }else if(userState is UserStateFailure){

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


