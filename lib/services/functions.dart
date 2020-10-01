import 'package:estate_agent/constants.dart';
import 'package:flutter/material.dart';

void showInSnackBar(GlobalKey<ScaffoldState> _scaffoldKey, String text, int time) {
  _scaffoldKey.currentState.showSnackBar(
      new SnackBar(content: new Text(text,style:
      TextStyle(
          color: Colors.white,
          fontSize: TChamp
      ),
        textAlign: TextAlign.center,),
        backgroundColor: BLUE_ACCENT,
        duration: Duration(seconds: time),));
}

bool tryParse(String str) {
  if(str == null) {
    return false;
  }
  return int.tryParse(str) != null;
}

Future<void> AlertConnexion(BuildContext context) {
  return showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Oops!'),
        content: Text("Vérifier votre connexion internet!"),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

bool isEmail(String em) {
  if(em == null){
    return true;
  }else {
    String p = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(p);
    return regExp.hasMatch(em);
  }
}