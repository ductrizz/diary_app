import 'package:diary_app/generic_bloc/user_bloc/user_bloc.dart';
import 'package:diary_app/pages/write_diary/write_diary_page.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../model/diary_entity.dart';
import '../home/diary_bloc/diary_bloc.dart';
import '../home/home_page.dart';
import '../loading/loading_page.dart';

class ReadDiaryPage extends StatefulWidget {
  ReadDiaryPage({Key? key}) : super(key: key);

  @override
  State<ReadDiaryPage> createState() => _ReadDiaryPageState();
}

class _ReadDiaryPageState extends State<ReadDiaryPage> with WidgetsBindingObserver {
  DiaryEntity? diaryEntity;
  DiaryBloc? _diaryBloc;
  UserBloc? _userBloc;

  @override
  void initState() {
    super.initState();
    _diaryBloc = BlocProvider.of<DiaryBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Read Diary"),
        titleTextStyle: titleTextApp,
        actions: [
          popupMenuButton()
        ],
      ),
      //backgroundColor: diaryBackground,
      body: SafeArea(
          child: BlocBuilder<DiaryBloc, DiaryState>(builder: (context, diaryState){
            if(diaryState is DiaryStateReadInitial){
              return LoadingPage();
            }else if(diaryState is DiaryStateReadSuccess){
              diaryEntity = diaryState.diaryEntity;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(diaryEntity!.diaryTitle, style:  titleDiaryText,),
                    Text('(${diaryEntity!.dateTime})', style: dateDiaryText),
                    const Divider(height: 20,thickness: 3,indent: 150, endIndent: 150, color: Color.fromRGBO(
                        84, 92, 84, 1.0),),
                    Expanded(
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(diaryEntity!.diaryContent, style: contentDiaryText))),
                  ],),
              );
            }else{
              return const Center(child: Text('Loading is Failure'));
            }
          },)
      ),
    );
  }

  PopupMenuButton<int> popupMenuButton() => PopupMenuButton<int>(
    itemBuilder: (context) => [
      // popupmenu item 1
      PopupMenuItem(
        value: 1,
        // row has two child icon and text.
        child: Row(children: const [
          Icon(Icons.delete_forever, color: Colors.red,),
          SizedBox(width: 10,),
          Text("Delete Diary")
        ],),
      ),
      // popupmenu item 2
      PopupMenuItem(
        value: 2,
        // row has two child icon and text
        child: Row(children: const [
          Icon(Icons.edit, color: Colors.black,),
          SizedBox(width: 10,),
          Text("Edit Diary")
        ],),
      ),
    ],
    offset: Offset(5, 55),
   // color: Colors.white,
    elevation: 2,
    onSelected: (value){
      if(value == 1){
        _diaryBloc?.add(DiaryEventDelete(date: diaryEntity!.dateTime));
        _userBloc?.add(UserEventGetUser());
        Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
        print('tap 1');
      }
      if(value == 2){
        print('tap 2');
        Navigator.push(context,
            MaterialPageRoute(builder: (context)=> WriteDiaryPage(diaryEntity: diaryEntity)));
      }
    },
  );
}