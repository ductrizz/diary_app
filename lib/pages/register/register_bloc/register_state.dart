part of 'register_bloc.dart';

class RegisterState extends Equatable{
  RegisterState({
    required this.isDisplayName,
    required this.isEmailValid,
    required this.isPasswordValid,
    required this.isConfirmPasswordValid,
    required this.isSubmitting,
    required this.isSuccess,
    required this.isFailure});

  bool get isFormValid => isEmailValid && isPasswordValid && isConfirmPasswordValid;

  bool isDisplayName;
  bool isEmailValid;
  bool isPasswordValid;
  bool isConfirmPasswordValid;
  bool isSubmitting;
  bool isSuccess;
  bool isFailure;

  factory RegisterState.initial(){
    return RegisterState(
      isDisplayName: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.loading({required String email, required String password}) {
    return RegisterState(
      isDisplayName: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: true,
      isSuccess: false,
      isFailure: false,
    );
  }

  factory RegisterState.success() {
    return RegisterState(
      isDisplayName: true,
      isEmailValid: true,
      isPasswordValid: true,
      isConfirmPasswordValid: true,
      isSubmitting: false,
      isSuccess: true,
      isFailure: false,
    );
  }

  factory RegisterState.failure({String? email,String? password}) {
    return RegisterState(
      isDisplayName: false,
      isEmailValid: false,
      isPasswordValid: false,
      isConfirmPasswordValid: false,
      isSubmitting: false,
      isSuccess: false,
      isFailure: true,
    );
  }

  RegisterState update({
    bool? isDisplayName,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
  }) {
    return copyWith(
      isDisplayName: isDisplayName ?? this.isDisplayName,
      isEmailValid: isEmailValid ?? this.isEmailValid,
      isPasswordValid: isPasswordValid ?? this.isPasswordValid,
      isConfirmPasswordValid: isConfirmPasswordValid ?? this.isConfirmPasswordValid,
      isSubmitting: false,
      isSuccess: false,
      isFailure: false,
    );
  }

  RegisterState copyWith({
    UserModel? userModel,
    bool? isDisplayName,
    bool? isEmailValid,
    bool? isPasswordValid,
    bool? isConfirmPasswordValid,
    bool? isSubmitting,
    bool? isSuccess,
    bool? isFailure,
  }){
    return RegisterState(
        isDisplayName: isDisplayName ?? this.isDisplayName,
        isEmailValid: isEmailValid ?? this.isEmailValid,
        isPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isConfirmPasswordValid: isPasswordValid ?? this.isPasswordValid,
        isSubmitting: isSubmitting ?? this.isSubmitting,
        isSuccess: isSuccess ?? this.isSuccess,
        isFailure: isFailure ?? this.isFailure);
  }

  @override
  List<Object?> get props => [
    isEmailValid,
    isPasswordValid,
    isConfirmPasswordValid,
    isSubmitting,
    isSuccess,
    isFailure
  ];
}