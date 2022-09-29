import 'package:flutter/material.dart';
import 'package:know_me_frontend_v2/app/app-screen.dart';
import 'package:know_me_frontend_v2/login/login-screen.dart';
import 'package:know_me_frontend_v2/services/storage-service.dart';

final theme = ThemeData(
    textTheme: const TextTheme(
      bodyText2: TextStyle(
        color: Color(0xFFFFFFFF),
        fontFamily: 'Roboto',
      ),
    ),
    primaryColor: Colors.white,
    backgroundColor: Colors.black);

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Know Us Better",
      theme: theme,
      home:
          StorageService.isLoggedIn() ? const AppScreen() : const LoginWidget(),
    );
  }
}