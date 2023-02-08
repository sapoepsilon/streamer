import 'package:flutter/material.dart';
import 'login.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}
