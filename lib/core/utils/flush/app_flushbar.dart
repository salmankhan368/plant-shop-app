import 'package:another_flushbar/another_flushbar.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class AppFlushBar {
  static void showSuccess(BuildContext context, String message, param2) {
    Flushbar(
      message: message,
      backgroundColor: const Color.fromARGB(255, 90, 215, 94),
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(12),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      icon: Icon(Iconsax.tick_circle, color: Colors.white),
    ).show(context);
  }

  static void showError(BuildContext context, String message) {
    Flushbar(
      message: message,
      backgroundColor: Colors.red.shade600,
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(12),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.circular(8),
      icon: Icon(Iconsax.close_circle, color: Colors.white),
    ).show(context);
  }
}
