import 'package:diary_app/res/all_core.dart';
import 'package:get/get.dart';

class Validator {

  static bool isValidEmail(String email){
    final regularExpression = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return regularExpression.hasMatch(email);
  }

  static bool isValidPassword(String password){
    return password.length >= 6;
  }
  static bool isValidConfirmPassword(String password , String confirmPassword){
    return (confirmPassword.toString() == password.toString());
  }
}