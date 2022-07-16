import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generic_bloc/user_bloc/user_bloc.dart';
import '../../model/diary_entity.dart';
import '../../res/all_core.dart';
import '../home/diary_bloc/diary_bloc.dart';

class WriteDiaryPage extends StatefulWidget {
  DiaryEntity? diaryEntity;
  int? index;
  WriteDiaryPage({Key? key, this.index, this.diaryEntity}) : super(key: key);

  @override
  State<WriteDiaryPage> createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  final TextEditingController _titleDiaryController = TextEditingController();
  final TextEditingController _contentDiaryController = TextEditingController();
  DiaryBloc? _diaryBloc;
  DiaryEntity? get _diaryEntity => widget.diaryEntity;
  int? get _index => widget.index;
  String? _dateTime;

  @override
  void initState() {
    _diaryBloc = BlocProvider.of<DiaryBloc>(context);
    if(_diaryEntity != null){
      int dateUnix = _diaryEntity!.dateTime as int;
      _dateTime = dateUnix.toDay;
      _titleDiaryController.text = _diaryEntity!.diaryTitle;
      _contentDiaryController.text = _diaryEntity!.diaryContent;
    }else{
      _dateTime = DateTime.now().toDay;
    }
    super.initState();
  }

  void _pressWriteDiary(){
    DiaryEntity newDiary;
    if(_diaryEntity != null){
      print('_diaryEntity :: $_diaryEntity');
      newDiary = DiaryEntity(
          dateTime: _dateTime?.toSinceEpoch as num,
          diaryTitle: _titleDiaryController.text,
          diaryContent: _contentDiaryController.text);
      _diaryBloc?.add(DiaryEventModify(index: _index, newDiary: newDiary));
      _diaryBloc?.add(DiaryEventRead(newDiary));
      BlocProvider.of<UserBloc>(context).add(UserEventGetUser());
    }else{
      newDiary = DiaryEntity(
          dateTime: _dateTime?.toSinceEpoch as num,
          diaryTitle: _titleDiaryController.text,
          diaryContent: _contentDiaryController.text);
      _diaryBloc?.add(DiaryEventWrite(newDiary: newDiary));
      BlocProvider.of<UserBloc>(context).add(UserEventGetUser());
    }
    Navigator.pop(context);
  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<DiaryBloc, DiaryState>(
      bloc: _diaryBloc,
      listener: (context, diaryState){
        if((diaryState is DiaryStateWriteInitial) || (diaryState is DiaryStateModifyInitial)){
          print('Initial:: ${diaryState}');
        }else if(diaryState is DiaryStateWriteSuccess){
          print('DiaryStateWriteSuccess :: ${diaryState}');
        }else if(diaryState is DiaryStateModifySuccess){
          print('DiaryStateModifySuccess :: ${diaryState}');
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
