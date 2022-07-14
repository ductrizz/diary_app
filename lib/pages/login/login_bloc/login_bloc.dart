import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../repositories/user_repository.dart';
import '../../../validator/validator.dart';

part 'login_state.dart';
part 'login_event.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState>{
  final UserRepository _userRepository;
  LoginBloc({required UserRepository userRepository}) : _userRepository = userRepository, super(LoginState.initial()){
    on<LoginEventEmailChanged>(_onEmailChange);
    on<LoginEventPasswordChanged>(_onPasswordChange);
    on<LoginEventSignIn>(_onSignIn);
    on<LoginEventSignInWithGoogle>(_onSignInWithGoogle);
  }

  void _onEmailChange(LoginEventEmailChanged event, Emitter<LoginState> emit){
    emit(state.update(isEmailValid: Validator.isValidEmail(event.email.toString())));
  }

  void _onPasswordChange(LoginEventPasswordChanged event, Emitter<LoginState> emit){
    emit(state.update(isPasswordValid: Validator.isValidPassword(event.password.toString())));
  }

  Future<void> _onSignIn(LoginEventSignIn event, Emitter<LoginState> emit) async{
    emit(LoginState.initial());
    try{
        await _userRepository.signIn(email: event.email, password: event.password);
        emit(LoginState.success());
    }on FirebaseAuthException catch (_){
      emit(LoginState.failure());
    }
  }

  Future<void> _onSignInWithGoogle(LoginEventSignInWithGoogle event, Emitter<LoginState> emit) async{
    try{
      await _userRepository.signInWithGoogle();
      emit(LoginState.success());
    }on FirebaseAuthException catch (_){
      emit(LoginState.failure());
    }
  }
}