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
  DiaryEntity? newDiary;

  DiaryEventWrite({required this.newDiary});
  @override
  List<Object?> get props => [newDiary];
}

class DiaryEventModify extends DiaryEvent{
  int? index;
  DiaryEntity? newDiary;

  DiaryEventModify({this.index, this.newDiary,});

  @override
  List<Object?> get props => [index, newDiary];
}

class DiaryEventDelete extends DiaryEvent{
  DiaryEntity? diaryEntity;

  DiaryEventDelete({required this.diaryEntity});

  @override
  List<Object?> get props => [diaryEntity];
}