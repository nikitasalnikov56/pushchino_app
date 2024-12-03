import 'package:flutter/material.dart';

class AppControllers {
  static final login = TextEditingController();
  static final password = TextEditingController();

  static void dispose() {
    login.dispose();
    password.dispose();
  }
}