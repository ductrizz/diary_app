
import 'package:flutter/material.dart';

@immutable
class DiaryEntity {
  DiaryEntity({
    required this.dateTime,
    required this.diaryTitle,
    required this.diaryContent,
    this.status = 'smiley',
  });

  final num dateTime;
  String diaryTitle;
  String diaryContent;
  String? status;

  Map<String, Object?> toJson(){
    return {
      'dateTime' : dateTime,
      'diaryTitle' : diaryTitle,
      'diaryContent' : diaryContent,
      'status': status
    };
  }

  DiaryEntity.fromJson(dynamic json) :
      this(
          dateTime: json['dateTime']! as num,
          diaryTitle: json['diaryTitle']! as String,
          diaryContent: json['diaryContent']! as String,
          status: json['status']! as String
      );


  @override
  String toString() {
    return 'DiaryEntity{dateTime: $dateTime, diaryTitle: $diaryTitle, diaryContent: $diaryContent, status : $status}';
  }

}