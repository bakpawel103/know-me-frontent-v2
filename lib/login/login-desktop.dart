import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({Key? key}) : super(key: key);

  @override
  State<LoginDesktop> createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {

  @override
  Widget build(BuildContext context) {
    return Row(
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
                  //...
                ),
                const SizedBox(height: 20),
                TextField(
                  //...
                ),
                const SizedBox(height: 25),
                Row(
                  //...
                ),
                const SizedBox(height: 30),
                TextButton(
                  onPressed: () => {},
                  child: Text("Login"),
                ),
                const SizedBox(height: 15),
                TextButton(
                  onPressed: () => {},
                  child: Text("Register"),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}