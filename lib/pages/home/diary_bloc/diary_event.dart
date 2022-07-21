part of 'diary_bloc.dart';

@immutable
abstract class DiaryEvent extends Equatable{
  @override
  List<Object?> get props =>[];
}

class DiaryEventRead extends DiaryEvent{
  DiaryEntity? diaryEntity;

  DiaryEventRead(this.diaryEntity);
  @override
  List<Object?> get props => [diaryEntity];
}

class DiaryEventWrite extends DiaryEvent{
  String? date;
  DiaryEntity? newDiary;

  DiaryEventWrite({required this.date,required this.newDiary});
  @override
  List<Object?> get props => [date, newDiary];
}

class DiaryEventModify extends DiaryEvent{
  String? date;
  DiaryEntity? newDiary;

  DiaryEventModify({this.date, this.newDiary,});

  @override
  List<Object?> get props => [date, newDiary];
}

class DiaryEventDelete extends DiaryEvent{
  String? date;
  DiaryEntity? diaryEntity;

  DiaryEventDelete({required this.diaryEntity});

  @override
  List<Object?> get props => [diaryEntity];
}