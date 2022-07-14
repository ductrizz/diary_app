part of 'user_bloc.dart';

abstract class UserState extends Equatable{
  @override
  List<Object?> get props => [
  ];
}

class UserStateInitial extends UserState{
  @override
  List<Object?> get props => [];

}

class UserStateSuccess extends UserState{
  UserModel? userModel;
  List<DiaryEntity>? diaryEntities;

  UserStateSuccess({this.userModel, this.diaryEntities});

  @override
  List<Object?> get props => [userModel, diaryEntities];

}

class UserStateFailure extends UserState{

  @override
  List<Object?> get props => [];
}
