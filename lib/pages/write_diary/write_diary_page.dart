import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generic_bloc/user_bloc/user_bloc.dart';
import '../../model/diary_entity.dart';
import '../../res/all_core.dart';
import '../home/diary_bloc/diary_bloc.dart';

class WriteDiaryPage extends StatefulWidget {
  DiaryEntity? diaryEntity;
  WriteDiaryPage({Key? key, this.diaryEntity}) : super(key: key);

  @override
  State<WriteDiaryPage> createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  final TextEditingController _titleDiaryController = TextEditingController();
  final TextEditingController _contentDiaryController = TextEditingController();
  DiaryBloc? _diaryBloc;
  DiaryEntity? get _diaryEntity => widget.diaryEntity;
  String? _dateTime;
  DiaryEntity? newDiary;

  @override
  void initState() {
    _diaryBloc = BlocProvider.of<DiaryBloc>(context);
    if(_diaryEntity != null){
      _dateTime = _diaryEntity!.dateTime;
      _titleDiaryController.text = _diaryEntity!.diaryTitle;
      _contentDiaryController.text = _diaryEntity!.diaryContent;
    }else{
      _dateTime = DateTime.now().toDay;
    }
    super.initState();
  }
  void _pressWriteDiary(){

    newDiary = DiaryEntity(
        dateTime: _dateTime,
        diaryTitle: _titleDiaryController.text,
        diaryContent: _contentDiaryController.text);
    if(_diaryEntity != null){
      //Modify
      _diaryBloc?.add(DiaryEventModify(date: _dateTime, newDiary: newDiary));
    }else{
      //Write
      _diaryBloc?.add(DiaryEventWrite(date: _dateTime ,newDiary: newDiary));
    }
    BlocProvider.of<UserBloc>(context).add(UserEventGetUser());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<DiaryBloc, DiaryState>(
      bloc: _diaryBloc,
      listener: (context, diaryState){
        if((diaryState is DiaryStateWriteInitial) || (diaryState is DiaryStateModifyInitial)){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              //duration: Duration(seconds: 3),
              content: Text("Initial")
          ));
        }else if(diaryState is DiaryStateWriteSuccess){
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 3),
              content: Text(" Write Success") ));
          Navigator.of(context).pop();
        }else if(diaryState is DiaryStateModifySuccess){
          _diaryBloc?.add(DiaryEventRead(newDiary));
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              duration: Duration(seconds: 3),
              content: Text(" Modify Success")));
          Navigator.of(context).pop();
        }else{
           print(('Failure :: ${diaryState}'));
        }
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          tooltip: 'Edit Diary',
          backgroundColor: const Color.fromRGBO(65, 165, 172, 0.5),
          onPressed: _pressWriteDiary,
          child: const Icon(Icons.save, color: Colors.black,),),
        backgroundColor: ColorName.diaryBackground,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              _titleDiary(),
              _contentDiary(),
            ],),
          ),
        ),
      ),
    );
  }

  //Sub-Widget
  Widget _titleDiary() => Column(
    children: [
      TextField(
        textAlign: TextAlign.center,
        controller: _titleDiaryController,
        onChanged: (value) {},
        decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: 'Diary Title',
            hintStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
        ),
        style: titleDiaryText,
      ),
      Text('(${_dateTime})', textAlign: TextAlign.right, style: dateDiaryText,),
      const Divider(height: 15,thickness: 3,indent: 150, endIndent: 150, color: Color.fromRGBO(84, 92, 84, 1.0),),
    ],
  );

  Widget _contentDiary() =>Expanded(
    child: TextField(
      controller: _contentDiaryController,
      onChanged: (value) {
      },
      decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Diary Description',
          hintStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic)
      ),
      style: contentDiaryText,
      keyboardType: TextInputType.multiline,
      maxLines: null,
    ),
  );
}
