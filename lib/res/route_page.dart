

import 'package:diary_app/pages/verification/verification_page.dart';

import '../pages/home/home_page.dart';
import '../pages/login/login_page.dart';
import '../pages/read_diary/read_diary_page.dart';
import '../pages/register/register_page.dart';
import '../pages/write_diary/write_diary_page.dart';

class RoutePage{
  static const initialRoute = '/';
  static final routes = {
    routerHomePage : (context) => HomePage(),
    routerLoginPage: (context) => LoginPage(),
    routerRegisterPage : (context) => RegisterPage(),
    routerReadDiaryPage : (context) => ReadDiaryPage(),
    routerWriteDiaryPage : (context) => WriteDiaryPage(),
    routerVerificationPage : (context) => VerificationPage(),
  };

  static const routerHomePage = '/HomePage';
  static const routerLoginPage = '/LoginPage';
  static const routerRegisterPage = '/RegisterPage';
  static const routerReadDiaryPage = '/ReadDiaryPage';
  static const routerWriteDiaryPage = '/WriteDiaryPage';
  static const routerVerificationPage = '/VerificationPage';

}

enum NavbarItem {calendar, event, diary }