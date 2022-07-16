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

class _ReadDiaryPageState extends State<ReadDiaryPage> {
  int? index;
  DiaryEntity? diaryEntity;

  @override
  void didUpdateWidget(covariant ReadDiaryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            tooltip: 'DeleteDiary',
            backgroundColor: Color.fromRGBO(246, 23, 5, 0.5019607843137255),
            onPressed: (){
              BlocProvider.of<DiaryBloc>(context).add(DiaryEventDelete(diaryEntity: diaryEntity));
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
            },
            child: const Icon(Icons.delete_forever, color: Colors.black,),),
          SizedBox(height: 10,),
          FloatingActionButton(
            tooltip: 'Edit Diary',
            backgroundColor: Color.fromRGBO(65, 165, 172, 0.5),
            onPressed: (){
              Navigator.push(context,
                  MaterialPageRoute(builder: (context)=>WriteDiaryPage(index: index ,diaryEntity: diaryEntity,)));
            },
            child: const Icon(Icons.edit, color: Colors.black,),),
        ],
      ),

      backgroundColor: const Color.fromRGBO(219, 235, 236, 1.0),
      body: SafeArea(
          child: BlocBuilder<DiaryBloc, DiaryState>(builder: (context, diaryState){
            if(diaryState is DiaryStateReadInitial){
              return LoadingPage();
            }else if(diaryState is DiaryStateReadSuccess){
              index = diaryState.index;
              diaryEntity = diaryState.diaryEntity;
              var timerUnix =diaryEntity!.dateTime as int;
              var dateTime = timerUnix.toDay;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(diaryEntity!.diaryTitle, style:  titleDiaryText,),
                    Text('(${dateTime})', style: dateDiaryText),
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
}