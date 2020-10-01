import 'package:estate_agent/constants.dart';
import 'package:estate_agent/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: BLUE_ACCENT, accentColor: Colors.white, fontFamily: 'Poppins'),
      home: SplashScreen(),
    );
  }
}