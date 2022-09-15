import 'package:flutter/material.dart';

class SnackBarService {
  static void showSnackBar(BuildContext context, String message, Color color) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.clearSnackBars();

    scaffold.showSnackBar(
      SnackBar(
        content: Text(message ?? ''),
        backgroundColor: color,
      ),
    );
  }
}