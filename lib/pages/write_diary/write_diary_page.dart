import 'package:flutter/material.dart';
import '../../res/all_core.dart';

class WriteDiaryPage extends StatefulWidget {
  const WriteDiaryPage({Key? key}) : super(key: key);

  @override
  State<WriteDiaryPage> createState() => _WriteDiaryPageState();
}

class _WriteDiaryPageState extends State<WriteDiaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Edit Diary',
        backgroundColor: const Color.fromRGBO(65, 165, 172, 0.5),
        onPressed: (){

        },
        child: const Icon(Icons.save, color: Colors.black,),),
      backgroundColor: const Color.fromRGBO(219, 235, 236, 1.0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            _titleDiary(),
            _contentDiary(),
          ],),
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
      Text('(25/08/1993)', textAlign: TextAlign.right, style: dateDiaryText,),
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
