import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../entities/jwt-response.dart';
import '../globals.dart' as globals;
import 'dart:convert';
import 'dart:developer';

import '../login/login-screen.dart';
import '../utils/snackbar-service.dart';

class RegisterMobile extends StatefulWidget {
  const RegisterMobile({Key? key}) : super(key: key);

  @override
  State<RegisterMobile> createState() => _RegisterMobileState();
}

class _RegisterMobileState extends State<RegisterMobile> {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
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
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Center(
              child: SizedBox(
                width: 300,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome a new user',
                      style: GoogleFonts.inter(
                        fontSize: 17,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Register a new account',
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
                      controller: emailController,
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
                        hintText: "Email",
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
                    const SizedBox(height: 10),
                    TextField(
                      controller: confirmPasswordController,
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
                        hintText: "Confirm Password",
                        filled: true,
                        fillColor: Colors.grey[200],
                        isDense: true,
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(),
                    const SizedBox(height: 30),
                    TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue)),
                      onPressed: () async => {
                        if (await register() == true)
                          {
                            await Future.delayed(const Duration(seconds: 3)),
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const LoginWidget();
                                },
                              ),
                              (r) {
                                return false;
                              },
                            ),
                          },
                      },
                      child: const Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      child: MouseRegion(
                        cursor: SystemMouseCursors.click,
                        child: GestureDetector(
                          child: const Text(
                            "Already have an account? Log in...",
                            style: TextStyle(
                                fontWeight: FontWeight.w100,
                                color: Colors.blue),
                          ),
                          onTap: () => {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return const LoginWidget();
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
          ),
        ),
      ),
    );
  }

  Future<bool> register() async {
    if (usernameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      SnackBarService.showSnackBar(
          context, "Fields cannot be empty", Colors.red);
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      SnackBarService.showSnackBar(
          context, "Passwords has to be the same", Colors.red);
      return false;
    }

    var url = '${globals.baseApiUri}api/auth/signup';
    Map data = {
      'username': usernameController.text,
      'email': emailController.text,
      'password': passwordController.text
    };

    var response = await http.post(Uri.parse(url),
        headers: {"Content-Type": "application/json"}, body: json.encode(data));

    Map mapResponseBody = json.decode(response.body);

    if (response.statusCode == 200) {
      SnackBarService.showSnackBar(
          context, "Successfully registered", Colors.green);
      return true;
    } else {
      SnackBarService.showSnackBar(
          context, mapResponseBody['message'], Colors.red);
      return false;
    }
  }
}
