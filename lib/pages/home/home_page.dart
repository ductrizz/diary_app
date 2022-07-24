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
        titleTextStyle: Theme.of(context).textTheme.headline1,
        content: Text("Today's diary already exists. Do you want to modify?"),
        contentTextStyle: Theme.of(context).textTheme.bodyText2,
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
        title: const Text('My Diary'),
        titleTextStyle: titleTextApp,
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
      drawer: BlocBuilder<UserBloc, UserState>(
          builder: (context, userState){
            String? _displayName;
            if(userState is UserStateInitial){
              //
            }else if(userState is UserStateSuccess){
              userModel = userState.userModel;
              _displayName = userModel?.displayName;
            }else if(userState is UserStateFailure){
              //
            }
            return _drawerHomePage(_displayName ?? "...");
          }
          ),
      body:  BlocBuilder<UserBloc, UserState>(
          builder: (context, userState){
            if(userState is UserStateInitial){
              //
            }else if(userState is UserStateSuccess){
              userModel = userState.userModel;
              listDiary = userState.diaryEntities;
            }else if(userState is UserStateFailure){
              //
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

  Drawer _drawerHomePage(String displayName) => Drawer(
        backgroundColor: Colors.white,
        width: MediaQuery.of(context).size.width * 0.8,
        elevation: 100.w,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 10.w,),
              Image.network("https://media.travelmag.vn/files/thuannguyen/2020/04/25/cach-chup-anh-dep-tai-da-lat-1-2306.jpeg",
                width: 100,),
              Text('${displayName}',style: contentDiaryText,),
              TextInkWellButton(onPressed: (){},
                buttonName: 'Profile',
                baseIcon: Icons.person,),
              TextInkWellButton(onPressed: (){},
                buttonName: 'Write New Diary',
                baseIcon: Icons.edit,),
              TextInkWellButton(onPressed: (){},
                buttonName: 'Change Password',
                baseIcon: Icons.lock_reset,),
              TextInkWellButton(onPressed: (){},
                buttonName: 'Setting',
                baseIcon: Icons.settings,),
              TextInkWellButton(onPressed: (){},
                buttonName: 'Sign-Out Account',
                baseIcon: Icons.logout,),

            ],
          ),)
    );
}


