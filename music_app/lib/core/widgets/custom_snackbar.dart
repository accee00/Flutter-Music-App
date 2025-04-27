import 'package:flutter/material.dart';

void showSnackBar({required String message, required BuildContext context}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        elevation: 0,
      ),
    );
}
