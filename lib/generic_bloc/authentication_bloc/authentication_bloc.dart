import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../repositories/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState>{
  final UserRepository _userRepository;

  AuthenticationBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(AuthenticationStateUninitialized()){
    on<AuthenticationEventStart>(authenticationBlocStart);
    on<AuthenticationEventSignIn>(authenticationBlocSignIn);
    on<AuthenticationEventSignOut>(authenticationBlocSignOut);
  }
  Future<void> authenticationBlocStart(AuthenticationEventStart event, Emitter<AuthenticationState> emit) async{
    try{
      final isSignedIn = await _userRepository.isSignedIn();
      if (isSignedIn) {
        final User? userFirebase = _userRepository.getUser();
        emit(AuthenticationStateSuccess(userFirebase: userFirebase));
      } else {
        emit(AuthenticationStateFailure());
      }
    }on FirebaseAuthException catch (_){
      emit(AuthenticationStateFailure(messageError: "Account doesn't exist"));
    }
  }
  Future<void> authenticationBlocSignIn(AuthenticationEventSignIn event, Emitter<AuthenticationState> emit) async{

    final User? userFirebase = _userRepository.getUser();
    emit(AuthenticationStateSuccess(userFirebase: userFirebase));
  }

  Future<void> authenticationBlocSignOut(AuthenticationEventSignOut event, Emitter<AuthenticationState> emit) async{
    await _userRepository.signOut();
    emit(AuthenticationStateFailure());
  }
}