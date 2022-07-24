part of 'user_bloc.dart';

class UserEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class UserEventGetUser extends UserEvent{
}

class UserEventUpdateInforUser extends UserEvent{
  UserModel? userModel;

  UserEventUpdateInforUser({this.userModel});

  @override
  List<Object?> get props => [userModel];
}
