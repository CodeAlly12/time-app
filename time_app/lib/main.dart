import 'package:flutter/material.dart';
import 'package:time_app/pages/login_page.dart';
import 'package:time_app/pages/Signup_page.dart';
import 'package:time_app/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'TIME LOG',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          '/': (context) => const Login_page(),
           
          '/home': (context) => const HomePage(),
          '/Signup': (context) => Signup_page()
        });
  }
}
