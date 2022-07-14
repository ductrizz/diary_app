part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class RegisterEventDisplayNameChanged extends RegisterEvent{
  String? displayName;

  RegisterEventDisplayNameChanged({this.displayName});

  @override
  List<Object?> get props => [displayName];
}

class RegisterEventEmailChanged extends RegisterEvent{
  String? email;

  RegisterEventEmailChanged({this.email});

  @override
  List<Object?> get props => [email];
}

class RegisterEventPasswordChanged extends RegisterEvent{
  String? password;

  RegisterEventPasswordChanged({this.password});

  @override
  List<Object?> get props => [password];
}

class RegisterEventConfirmPasswordChanged extends RegisterEvent{
  String? password;
  String? confirmPassword;

  RegisterEventConfirmPasswordChanged({this.password, this.confirmPassword});

  @override
  List<Object?> get props => [confirmPassword];
}

class RegisterEventSignUp extends RegisterEvent{
  String email;
  String password;
  String displayName;

  RegisterEventSignUp({required this.email, required this.password, required this.displayName});
  @override
  List<Object?> get props => [email, password, displayName];
}