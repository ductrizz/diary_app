import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/diary_entity.dart';
import '../../../model/user_model.dart';
import '../../base/emotional_status.dart';
import '../../read_diary/read_diary_page.dart';


class ItemDiary extends StatelessWidget {
  ItemDiary({Key? key, required this.diaryEntity, this.userModel}) : super(key: key);
  final DiaryEntity? diaryEntity;
  final UserModel? userModel;

  @override
  Widget build(BuildContext context) {
    var date = diaryEntity?.dateTime;
    var title = diaryEntity?.diaryTitle;
    var status = diaryEntity?.status ?? EmotionalStatus.smiley.name;
    //DiaryBloc _diaryBloc = BlocProvider.of<DiaryBloc>(context);
    return Container(
      //decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
      height: 50,
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
      child: ElevatedButton(
        onPressed: (){
         // BlocProvider.of<DiaryBloc>(context).add(DiaryEventRead(diaryEntity));
          Navigator.push(context, MaterialPageRoute(
              builder: (context) => ReadDiaryPage()));
        },
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                    side: const BorderSide(width: 2, color: Colors.white)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:[
            //Icon(const IconData(0xe22b, fontFamily: 'MaterialIcons'), size: 30, color: Colors.yellow[700],),
            IconStatus(status: status).icon,
            const SizedBox(width: 10,),
            Text(date.toString(),
                style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black)),
            const SizedBox(width: 10,),
            Text(title!,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                  overflow: TextOverflow.ellipsis),),
          ],
        ),
      ),
    );
  }
}
