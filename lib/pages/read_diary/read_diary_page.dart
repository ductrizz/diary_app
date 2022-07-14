import 'package:flutter/material.dart';
import '../../res/all_core.dart';

class ReadDiaryPage extends StatelessWidget {
  const ReadDiaryPage({Key? key}) : super(key: key);

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

            },
            child: const Icon(Icons.delete_forever, color: Colors.black,),),
          SizedBox(height: 10,),
          FloatingActionButton(
            tooltip: 'Edit Diary',
            backgroundColor: Color.fromRGBO(65, 165, 172, 0.5),
            onPressed: (){
            },
            child: const Icon(Icons.edit, color: Colors.black,),),
        ],
      ),
      backgroundColor: const Color.fromRGBO(219, 235, 236, 1.0),
      body: SafeArea(
      child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text('diaryEntity!.diaryTitle', style: titleDiaryText,),
        Text('diaryEntity!.dateTime', style: dateDiaryText,),
        const Divider(height: 20,thickness: 3,indent: 150, endIndent: 150, color: Color.fromRGBO(
            84, 92, 84, 1.0),),
        Expanded(
            child: Align(
                alignment: Alignment.topLeft,
                child: Text('diaryEntity!.diaryContent', style: contentDiaryText,))),
      ],),
      )
    );
  }
}
