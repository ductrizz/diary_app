import 'package:diary_app/generic_bloc/theme/theme_cubit.dart';
import 'package:diary_app/pages/home/diary_bloc/diary_bloc.dart';
import 'package:diary_app/pages/verification/verification_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'generic_bloc/authentication_bloc/authentication_bloc.dart';
import 'generic_bloc/user_bloc/user_bloc.dart';
import 'pages/home/home_page.dart';
import 'pages/loading/loading_page.dart';
import 'pages/login/login_bloc/login_bloc.dart';
import 'pages/login/login_page.dart';
import 'pages/register/register_bloc/register_bloc.dart';
import 'repositories/firestore_repository.dart';
import 'repositories/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  UserRepository userRepository = UserRepository();
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  UserRepository userRepository;
  final FirestoreRepository firestoreRepository = FirestoreRepository();

  MyApp({Key? key, required this.userRepository}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(userRepository: userRepository)
          ..add(AuthenticationEventStart())),
        BlocProvider(create: (context) => LoginBloc(userRepository: userRepository)),
        BlocProvider(create: (context) => RegisterBloc(userRepository: userRepository)),
        BlocProvider(create: (context) => UserBloc(firestoreRepository: firestoreRepository)),
        BlocProvider(create: (context) => DiaryBloc(firestoreRepository: firestoreRepository)),
        BlocProvider(create: (_) => ThemeCubit()),
      ],
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: (_, themeData){
          print(themeData.brightness);
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData,
            home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, authenticationState) {
                  if (authenticationState is AuthenticationStateUninitialized) {
                    Future.delayed(const Duration(seconds: 500));
                    return LoadingPage();
                  }else if (authenticationState is AuthenticationStateSuccess) {
                    return VerificationPage();
                  }else if (authenticationState is AuthenticationStateFailure) {
                    return const LoginPage();
                  }else{
                    return const LoadingPage();
                  }
                }
            ),
          );
        },
      )
    );
  }
}

