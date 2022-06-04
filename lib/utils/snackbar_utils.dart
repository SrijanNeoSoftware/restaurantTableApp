import 'package:flutter/material.dart';

class SnackBarUtils {
  static void displaySnackBar(
      {BuildContext? context, String? message, Color? color}) {
    ScaffoldMessenger.of(context!).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 2),
        content: Text(message!),
        backgroundColor: color!,
      ),
    );
  }
}
