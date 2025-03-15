import 'package:flutter/material.dart';

class MySnackbar {
  static void displayErrorMessage(String message, BuildContext context) {
    var snackBar = SnackBar(
      content: Text(message),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
