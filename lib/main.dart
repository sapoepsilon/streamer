import 'package:flutter/material.dart';
import 'login.dart';
import "pages/Songs_List.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Login",
      debugShowCheckedModeBanner: false,
      // home: Login(),
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => Login(),
        "/Sonds_List": (BuildContext context) => SongsList(),
      },
    );
  }
}
