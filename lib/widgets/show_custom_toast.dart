import 'package:flutter/material.dart';

void showCustomToast(BuildContext context, String message) {
  final scaffoldMessenger = ScaffoldMessenger.of(context);
  scaffoldMessenger.removeCurrentSnackBar();
  scaffoldMessenger.showSnackBar(
    SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'mainfont',
          fontSize: 22.0,
          color: Colors.white,
        ),
      ),
      duration: const Duration(seconds: 2),
      backgroundColor: const Color.fromARGB(255, 94, 94, 94),
    ),
  );
}