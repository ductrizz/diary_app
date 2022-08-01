import 'package:diary_app/pages/read_diary/read_diary_page.dart';
import 'package:diary_app/res/all_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/diary_entity.dart';
import '../../base/emotional_status.dart';
import '../diary_bloc/diary_bloc.dart';


class ItemDiary extends StatelessWidget {
  const ItemDiary({Key? key, required this.diaryEntity}) : super(key: key);
  final DiaryEntity? diaryEntity;

  @override
  Widget build(BuildContext context) {
    var date = diaryEntity?.dateTime;
    var title = diaryEntity?.diaryTitle;
    var status = diaryEntity?.status ?? EmotionalStatus.smiley.name;
    //DiaryBloc _diaryBloc = BlocProvider.of<DiaryBloc>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.w),
        gradient:  LinearGradient(
            colors: [Colors.white, Colors.cyan.shade100],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      height: 50.w,
      margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.w),
      child: ElevatedButton(
        onPressed: (){
          BlocProvider.of<DiaryBloc>(context).add(DiaryEventRead(diaryEntity));
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReadDiaryPage()));
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Color.alphaBlend(Colors.grey.shade200, Colors.cyan.shade300)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.w),
                    side: BorderSide(width: 2.w , color: Colors.cyan.shade100)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            //Icon(const IconData(0xe22b, fontFamily: 'MaterialIcons'), size: 30, color: Colors.yellow[700],),
            IconStatus(status: status).icon,
            SizedBox(width: 10.w,),
            Text(date.toString(),
                style: bodyTextApp.bold.copyWith(color: Colors.black)),
            SizedBox(width: 10.w,),
            Expanded(
              child: Text(title!,
                style: contentDiaryText.copyWith(color: Colors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
