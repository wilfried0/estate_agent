import 'dart:async';
import 'package:estate_agent/screens/list_house_screen.dart';
import 'package:estate_agent/screens/signin_screen.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState(){
    super.initState();
    Timer(Duration(seconds: 5), onDoneLoading);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 50.0, right: 50.0),
            child: new Image.asset('assets/images/house.png'),
          ),
          Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height-40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.copyright, color: GRAY_LIGTH,),
                Text("Copyright 2020", style: TextStyle(
                    color: GRAY_LIGTH,
                    fontStyle: FontStyle.italic
                ),),
              ],
            ),
          )
        ],
      ),
    );
  }

  onDoneLoading() async {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigninScreen()));
  }
}
