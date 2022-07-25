import 'package:diary_app/pages/base/emotional_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../generic_bloc/user_bloc/user_bloc.dart';
import '../../model/diary_entity.dart';
import '../../res/all_core.dart';
import '../base/snackbar_messenger.dart';
import '../home/diary_bloc/diary_bloc.dart';
import 'child/dialog_option_status.dart';

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
  String? _selectedStatus = EmotionalStatus.smiley.name;

  @override
  void initState() {
    _diaryBloc = BlocProvider.of<DiaryBloc>(context);
    if(_diaryEntity != null){
      _dateTime = _diaryEntity!.dateTime;
      _titleDiaryController.text = _diaryEntity!.diaryTitle;
      _contentDiaryController.text = _diaryEntity!.diaryContent;
      _selectedStatus = _diaryEntity!.status;
    }else{
      _dateTime = DateTime.now().toDay;
      _displayDialog(context);
    }
    super.initState();
  }
  void _pressWriteDiary(){
    newDiary = DiaryEntity(
        dateTime: _dateTime,
        diaryTitle: _titleDiaryController.text,
        diaryContent: _contentDiaryController.text,
        status: _selectedStatus);
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
          showSnackBarCus(context: context, message: "Save Diary!", duration: 1);
        }else if(diaryState is DiaryStateWriteSuccess){
          showSnackBarCus(context: context, message: "Successfully Write New Diary!");
          Navigator.of(context).pop();
        }else if(diaryState is DiaryStateModifySuccess){
          _diaryBloc?.add(DiaryEventRead(newDiary));
          showSnackBarCus(context: context, message: "Successfully Modify New Diary!");
          Navigator.of(context).pop();
        }else if(diaryState is DiaryStateModifyFailure){
          showSnackBarCus(context: context, message: "Modify is Failure : ${diaryState.messageError}");
        }else if(diaryState is DiaryStateWriteFailure){
          showSnackBarCus(context: context, message: "Write is Failure : ${diaryState.messageError}");
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Write Diary"),
          titleTextStyle: titleTextApp,
          actions: [
            IconButton(
                onPressed: (){
                  _displayDialog(context);
                  },
                icon: Icon(Icons.emoji_emotions_outlined))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          tooltip: 'Edit Diary',
          backgroundColor: const Color.fromRGBO(65, 165, 172, 0.5),
          onPressed: _pressWriteDiary,
          child: const Icon(Icons.save, color: Colors.black,),),
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
      Divider(height: 15.w,thickness: 3.w ,indent: 150.w , endIndent: 150.w, color: Color.fromRGBO(84, 92, 84, 1.0),),
    ],
  );

  Widget _contentDiary() =>Expanded(
    child: TextField(
      controller: _contentDiaryController,
      onChanged: (value) {
      },
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Diary Description',
          hintStyle: bodyTextApp,
      ),
      style: contentDiaryText,
      keyboardType: TextInputType.multiline,
      maxLines: null,
    ),
  );

  _displayDialog(BuildContext context) async {
    _selectedStatus = await showDialog(
        context: context,
        builder: (BuildContext context){
          return dialogOptionStatus(context);
        }
    );
  }
}
