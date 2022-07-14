

class RoutePage{
  static const initialRoute = routerHomePage;
  static final routes = {
    /*routerHomePage : (context) => HomePage(),
    routerLoginPage: (context) => LoginPage(),
    routerRegisterPage : (context) => RegisterPage(),
    routerDiaryPage : (context) => DiaryPage(),
    routerReadDiaryPage : (context) => ReadDiaryPage(),
    routerWriteDiaryPage : (context) => WriteDiaryPage(),*/
  };

  static const routerHomePage = '/HomePage';
  static const routerCalendarPage = '/CalendarPage';
  static const routerEventsPage = '/EventsPage';
  static const routerLoginPage = '/LoginPage';
  static const routerRegisterPage = '/RegisterPage';
  static const routerDiaryPage = '/DiaryPage';
  static const routerReadDiaryPage = '/ReadDiaryPage';
  static const routerWriteDiaryPage = '/WriteDiaryPage';

}

enum NavbarItem {calendar, event, diary }