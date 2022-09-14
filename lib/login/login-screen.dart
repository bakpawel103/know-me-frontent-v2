import 'package:flutter/material.dart';

import 'login-desktop.dart';
import 'login-mobile.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          if (constraints.maxWidth < 600) {
            return const LoginMobile();
          } else {
            return const LoginDesktop();
          }
        },
      ),
    );
  }
}
