part of 'login_bloc.dart';


abstract class LoginEvent extends Equatable{

  @override
  List<Object?> get props => [];
}

class LoginEventEmailChanged extends LoginEvent{
  String? email;
  LoginEventEmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class LoginEventPasswordChanged extends LoginEvent{
  String? password;

  LoginEventPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class LoginEventSignIn extends LoginEvent{
  String email;
  String password;

  LoginEventSignIn({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class LoginEventSignInWithGoogle extends LoginEvent{

}
