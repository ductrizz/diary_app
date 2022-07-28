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

class UserStateImageInitial extends UserState {}

class UserStateImagePickerInProgress extends UserState {}

class UserStateImagePickerSuccessful extends UserState {
  File image;
  UserStateImagePickerSuccessful(this.image);

  @override
  List<Object> get props => [image];
}

class UserStateImagePickerFailed extends UserState {
  String message;

  UserStateImagePickerFailed(this.message);

  @override
  List<Object> get props => [message];
}

