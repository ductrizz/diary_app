import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../model/user_model.dart';
import '../../../repositories/user_repository.dart';
import '../../../validator/validator.dart';


part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState>{
  UserRepository _userRepository;
  RegisterBloc({required UserRepository userRepository}):  _userRepository = userRepository, super(RegisterState.initial()){
    on<RegisterEventDisplayNameChanged>(_onDisplayNameChange);
    on<RegisterEventEmailChanged>(_onEmailChange);
    on<RegisterEventPasswordChanged>(_onPasswordChange);
    on<RegisterEventConfirmPasswordChanged>(_onConfirmPasswordChange);
    on<RegisterEventSignUp>(_onSignUp);
  }

  void _onDisplayNameChange(RegisterEventDisplayNameChanged event, Emitter<RegisterState> emit){
    emit(state.update(
        isDisplayName: (event.displayName.toString() != null) && (event.displayName.toString().trim() != '')
    ));
  }
  void _onEmailChange(RegisterEventEmailChanged event, Emitter<RegisterState> emit){
    emit(state.update(isEmailValid: Validator.isValidEmail(event.email.toString())));
  }

  void _onPasswordChange(RegisterEventPasswordChanged event, Emitter<RegisterState> emit){
    emit(state.update(
        isPasswordValid: Validator.isValidPassword(event.password.toString())
    ));
  }

  void _onConfirmPasswordChange(RegisterEventConfirmPasswordChanged event, Emitter<RegisterState> emit){
    emit(state.update(
        isConfirmPasswordValid: Validator.isValidConfirmPassword(
            event.password.toString(),
            event.confirmPassword.toString())));
  }

  Future<void> _onSignUp(RegisterEventSignUp event, Emitter<RegisterState> emit) async{
    emit(RegisterState.initial());
    try{
      emit(RegisterState.loading(email: event.email, password: event.password));
      await _userRepository.signUp(email: event.email, password: event.password, displayName: event.displayName);
      await _userRepository.sendVerificationEmail();
      emit(RegisterState.success());
    }on FirebaseAuthException catch (_){
      emit(RegisterState.failure());
    }
  }
}