import 'package:flutter/material.dart';
import 'package:know_me_frontent_v2/decks/decks-screen.dart';
import 'package:know_me_frontent_v2/login/login-screen.dart';
import 'package:know_me_frontent_v2/services/storage-service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Know Us Better",
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home:
          StorageService.isLoggedIn() ? const HomePage() : const LoginWidget(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Know Us Better"),
      ),
      body: const DecksScreen(),
    );
  }
}
