import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../entities/jwt-response.dart';
import '../globals.dart' as globals;
import 'dart:convert';
import 'dart:developer';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({Key? key}) : super(key: key);

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[Colors.red, Colors.blue],
        ),
      ),
      child: Row(
        children: [
          Expanded(
              child: Image.asset(
            'assets/mountain.jpg',
            fit: BoxFit.cover,
          )),
          Expanded(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 21),
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome back',
                    style: GoogleFonts.inter(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Login to your account',
                    style: GoogleFonts.inter(
                      fontSize: 23,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 35),
                  TextField(
                    controller: usernameController,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Username/Email",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black45),
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      prefixIcon: const Icon(Icons.password),
                      hintText: "Password",
                      filled: true,
                      fillColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(),
                  const SizedBox(height: 30),
                  TextButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.blue)),
                    onPressed: () => logIn(),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextButton(
                    child: const Text(
                      "Register",
                      style: TextStyle(fontWeight: FontWeight.w100),
                    ),
                    onPressed: () => {},
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> logIn() async {
    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      return;
    }

    var url = '${globals.baseApiUri}api/auth/signin';
    Map data = {
      'username': usernameController.text,
      'password': passwordController.text
    };

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json.encode(data));

    Map mapResponseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.clearSnackBars();

      scaffold.showSnackBar(
        SnackBar(
          content: const Text('Successfully logged in'),
          backgroundColor: Colors.green,
        ),
      );

      globals.loggedIn = true;
      globals.loggedInUser = JwtResponse.fromJson(jsonDecode(response.body));
    } else {
      final scaffold = ScaffoldMessenger.of(context);
      scaffold.clearSnackBars();

      scaffold.showSnackBar(
        SnackBar(
          content: Text(mapResponseBody['message'] ?? ''),
          backgroundColor: Colors.red,
        ),
      );
    }

    log(response.body);
    log(response.statusCode.toString());
  }
}
