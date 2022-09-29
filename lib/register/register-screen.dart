import 'package:flutter/material.dart';
import 'package:know_me_frontend_v2/register/register-desktop.dart';
import 'package:know_me_frontend_v2/register/register-mobile.dart';

class RegisterWidget extends StatelessWidget {
  const RegisterWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600) {
            return const RegisterMobile();
          } else {
            return const RegisterDesktop();
          }
        },
      ),
    );
  }
}
