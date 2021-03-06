import 'package:diary_app/generic_bloc/theme/theme_cubit.dart';
import 'package:diary_app/pages/base/base_button.dart';
import 'package:diary_app/pages/profile/profile_page.dart';
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
  bool isDarkModel = false;


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
        title: Text('My Diary'),
        titleTextStyle: Theme.of(context).textTheme.headline5,
        actions: [
          IconButton(
            key: Key('btnRouteWrite',),
            onPressed: (){
              canWriteNew();
            },
            icon: Icon(Icons.add_box_outlined,),
            tooltip: "Add Diary",
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
        //backgroundColor: Colors.white,
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
              TextInkWellButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => ProfilePage()));
              },
                buttonName: 'Profile',
                baseIcon: Icons.person,),
              TextInkWellButton(onPressed: (){},
                buttonName: 'Change Password',
                baseIcon: Icons.lock_reset,),
              TextInkWellButton(onPressed: (){
              },
                buttonName: 'Setting',
                baseIcon: Icons.settings,),
              Container(
                margin: EdgeInsets.only(left: 30),
                child: Column(
                  children: [
                    TextInkWellButton(onPressed: (){
                      context.read<ThemeCubit>().toggleTheme();
                      },
                      buttonName: 'Change Background App',
                      baseIcon: Icons.brightness_6,),
                  ],
                ),
              ),
              TextInkWellButton(onPressed: (){
                _authenticationBloc?.add(AuthenticationEventSignOut());
              },
                buttonName: 'Sign-Out Account',
                baseIcon: Icons.logout,),
            ],
          ),)
    );
}


