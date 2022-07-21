part of 'diary_bloc.dart';

@immutable
abstract class DiaryState extends Equatable{
  @override
  List<Object?> get props => [];
}
class DiaryStateInitial extends DiaryState{

}

//State Write Diary
class DiaryStateWriteInitial extends DiaryState{}

class DiaryStateWriteSuccess extends DiaryState{}

class DiaryStateWriteFailure extends DiaryState{
  String? messageError;

  DiaryStateWriteFailure({this.messageError});
  @override
  List<Object?> get props => [messageError];
}

//State Read Diary
class DiaryStateReadInitial extends DiaryState{

}

class DiaryStateReadSuccess extends DiaryState{
  DiaryEntity? diaryEntity;

  DiaryStateReadSuccess({this.diaryEntity});

  @override
  List<Object?> get props => [diaryEntity];
}

class DiaryStateReadFailure extends DiaryState{
  String? messageError;

  DiaryStateReadFailure({this.messageError});

  @override
  List<Object?> get props => [messageError];
}
//State Modify Diary
class DiaryStateModifyInitial extends DiaryState{

}
class DiaryStateModifySuccess extends DiaryState{
  DiaryEntity? diaryEntity;

  DiaryStateModifySuccess({this.diaryEntity});

  @override
  List<Object?> get props => [diaryEntity];
}
class DiaryStateModifyFailure extends DiaryState{
  String? messageError;

  DiaryStateModifyFailure({this.messageError});
  @override
  List<Object?> get props => [messageError];
}
//State Modify Diary
class DiaryStateDeleteInitial extends DiaryState{

}
class DiaryStateDeleteSuccess extends DiaryState{

}
class DiaryStateDeleteFailure extends DiaryState{
  String? messageError;

  DiaryStateDeleteFailure({this.messageError});
  @override
  List<Object?> get props => [messageError];
}

