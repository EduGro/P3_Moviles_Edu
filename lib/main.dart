import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_login/bloc/auth_bloc.dart';
import 'package:google_login/home/home_page.dart';
import 'package:google_login/login/login_page.dart';
import 'package:google_login/splash_screen.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // inicializar firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //Abrir box donde guardaremos y leeremos los datos
  await Hive.initFlutter();
  await Hive.openBox<String>("news_hive");
  runApp(MyApp());

  runApp(
    BlocProvider(
      create: (context) => AuthBloc()..add(VerifyAuthenticationEvent()),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          if (state is AlreadyAuthState) return HomePage();
          if (state is UnAuthState) return LoginPage();
          return SplashScreen();
        },
      ),
    );
  }
}
