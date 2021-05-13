import 'package:flutter/material.dart';
import 'package:login_sign_up/homePage.dart';
import 'package:login_sign_up/login.dart';
import 'package:login_sign_up/sign_up.dart';

void main() {
  runApp(MaterialApp(
    title: 'Login',
    routes: {
      '/': (context) => SignUp(),
      '/Login': (context) => Login(),
      '/Home': (context) => Home(),
    },
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        fontFamily: 'Mukta',
        accentColor: Colors.amber,
        primarySwatch: Colors.amber,
        buttonColor: Colors.amber),
  ));
}
