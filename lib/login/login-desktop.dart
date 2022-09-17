import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../globals.dart' as globals;
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';

import '../main.dart';
import '../register/register-screen.dart';
import '../services/snackbar-service.dart';
import '../services/storage-service.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({Key? key}) : super(key: key);

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool loading = false;

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
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: <Color>[
            Color(0xFF12c2e9),
            Color(0xFFc471ed),
            Color(0xFFf64f59)
          ],
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SvgPicture.asset(
              "assets/login_screen_image.svg",
              height: 400,
              width: 400,
              fit: BoxFit.scaleDown,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
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
                      hintText: "Username",
                      filled: true,
                      fillColor: Colors.grey[200],
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
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
                      isDense: true,
                      contentPadding: const EdgeInsets.all(8),
                    ),
                  ),
                  const SizedBox(height: 25),
                  Row(),
                  const SizedBox(height: 30),
                  Align(
                    child: LayoutBuilder(builder: (context, constraints) {
                      if (loading) {
                        return const CircularProgressIndicator();
                      } else {
                        return ConstrainedBox(
                          constraints: const BoxConstraints(minWidth: 200),
                          child: TextButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                            onPressed: () async => {
                              if (await logIn() == true)
                                {
                                  await Future.delayed(const Duration(seconds: 2)),
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const MainApp();
                                      },
                                    ),
                                        (r) {
                                      return false;
                                    },
                                  ),
                                },
                            },
                            child: const Text(
                              "Login",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      }
                    }),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    alignment: Alignment.center,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        child: const Text(
                          "Not have an account? Register...",
                          style: TextStyle(
                              fontWeight: FontWeight.w100, color: Colors.blue),
                        ),
                        onTap: () => {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const RegisterWidget();
                              },
                            ),
                            (r) {
                              return false;
                            },
                          ),
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<bool> logIn() async {
    setState(() => loading = true);

    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      SnackBarService.showSnackBar(
          context, "Fields cannot be empty", Colors.red);
      setState(() => loading = false);
      return false;
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
      SnackBarService.showSnackBar(
          context, "Successfully logged in", Colors.green);

      StorageService.setLoggedUser(response.body);
      setState(() => loading = false);
      return true;
    } else {
      SnackBarService.showSnackBar(
          context, mapResponseBody['message'], Colors.red);
      setState(() => loading = false);
      return false;
    }
  }
}
