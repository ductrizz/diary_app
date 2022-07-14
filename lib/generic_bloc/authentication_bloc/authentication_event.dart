part of 'authentication_bloc.dart';

class AuthenticationEvent extends Equatable{
  @override
  List<Object?> get props => [];
}

class AuthenticationEventStart extends AuthenticationEvent{

}

class AuthenticationEventSignIn extends AuthenticationEvent{

}

class AuthenticationEventSignOut extends AuthenticationEvent{

}