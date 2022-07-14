part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable{
  @override
  List<Object> get props => [];
}

class AuthenticationStateUninitialized extends AuthenticationState {
  //waiting to see if the user is authenticated or not on app start.
  //=> if the authentication state was uninitialized, the user might be seeing a splash screen.
}

class AuthenticationStateSuccess extends AuthenticationState {
  User? userFirebase;
  AuthenticationStateSuccess({this.userFirebase});

  @override
  List<Object> get props => [userFirebase!];

  @override
  String toString() {
    return 'AuthenticationStateSuccess{userFirebase email: ${userFirebase?.email}}';
  }

}

class AuthenticationStateFailure extends AuthenticationState {
  final String? messageError;

  AuthenticationStateFailure({this.messageError});
  @override
  List<Object> get props => [messageError!];
  //successfully authenticated
  //=>if the authentication state was unauthenticated, the user might see a login form.
}