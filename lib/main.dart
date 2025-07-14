import 'package:flutter/material.dart';
import 'package:scb_login_page/pages/login_page.dart';
import 'package:scb_login_page/widgets/login_form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}
