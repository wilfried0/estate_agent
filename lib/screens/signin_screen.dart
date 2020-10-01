import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:estate_agent/constants.dart';
import 'package:estate_agent/screens/list_house_screen.dart';
import 'package:estate_agent/screens/signup_screen.dart';
import 'package:estate_agent/services/classes.dart';
import 'package:estate_agent/services/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SigninScreen extends StatefulWidget {
  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {

  FocusNode searchFocus = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>(), flagUri, usernameController, passController;
  bool isLoding =false, coched = false, _isHidden = true;
  String _username, url, lang="FR", currencyConnexion, currencySymbol, iso3, pays, _mySelection = "+237",_sername, iso="CM", _password, token;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = "$BaseUrl/users/login";
    usernameController = new TextEditingController();
    passController = new TextEditingController();
    Timer(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(searchFocus);
    });
  }

  void _toggleVisibility(){
    setState((){
      _isHidden = !_isHidden;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: GRAY_LIGTH,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height/4,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0.0, bottom: 10.0, left: 40.0, right: 40.0),
                    child: new Image.asset('assets/images/house.png'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: new Text("Bienvenue",//SitLocalizations.of(context).bienvenue,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: TChamp+3,
                          fontWeight: FontWeight.bold
                      ),),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left:20.0, top:10.0, right: 20.0),
                  child: Align(
                    alignment: Alignment.center,
                    child: new Text("sur votre plateforme de vente, achat et location de maisons",//SitLocalizations.of(context).bienvenu_text,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: TChamp,
                      ),),
                  ),
                ),


                /*Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                      border: Border.all(
                          color: GRAY,
                          width: border
                      ),
                    ),
                    height: HChamp,
                    child:_mySelection==null?Container(): Row(
                      children: <Widget>[
                        Expanded(
                            flex: 5,
                            child: CountryCodePicker(
                              showFlag: true,
                              textStyle: TextStyle(
                                  fontSize: TChamp,
                                  color: GRAY
                              ),
                              initialSelection:_mySelection,
                              onChanged: (CountryCode code) {
                                setState(() {
                                  _mySelection = code.dialCode.toString();
                                  flagUri = "${code.flagUri}";
                                  iso3 = "${code.codeIso}";
                                  iso = "${code.code}";
                                  print(iso3);
                                  pays = "${code.name}";
                                });
                              },
                            )
                        ),
                        new Expanded(
                          flex:10,
                          child: new TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontSize: TChamp,
                              color: GRAY,
                            ),
                            validator: (String value){
                              if(value.isEmpty){
                                return "Téléphone/Email invalide !";//SitLocalizations.of(context).invalid_phone;
                              }else{
                                if(_mySelection == "+33" && value.startsWith("0")){
                                  _username = _mySelection.substring(1)+value.substring(1);
                                  _sername = value.substring(1);
                                }else{
                                  _username = _mySelection.substring(1)+value;
                                  _sername = value;
                                }
                                return null;
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText:"Téléphone/Email",// SitLocalizations.of(context).phone,
                              hintStyle: TextStyle(
                                fontSize: TChamp,
                                color: GRAY,
                              ),
                              //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),*/

                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
                  child: Container(
                    margin: EdgeInsets.only(top: 0.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        topLeft: Radius.circular(10.0),
                        topRight: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                      border: Border.all(
                          width: border,
                          color: GRAY
                      ),
                    ),
                    height: HChamp,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex:2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new Icon(Icons.person, color: GRAY,),
                          ),
                        ),
                        new Expanded(
                          flex:12,
                          //child: Padding(
                          child: new TextFormField(
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: TChamp,
                                color: GRAY
                            ),
                            validator: (String value){
                              if(value.isEmpty){
                                return 'Nom d\'utilisatuer vide !';
                              }else{
                                _username = value;
                                return null;
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Nom d\'utilisateur/Email',
                              hintStyle: TextStyle(
                                  color: GRAY,
                                  fontSize: TChamp),
                              //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            ),
                          ),
                          //),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 0),
                  child: Container(
                    margin: EdgeInsets.only(top: 0.0),
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                      border: Border.all(
                          width: border,
                          color: GRAY
                      ),
                    ),
                    height: HChamp,
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          flex:2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new Icon(Icons.lock, color: GRAY,),
                          ),
                        ),
                        new Expanded(
                          flex:10,
                          //child: Padding(
                          child: new TextFormField(
                            controller: passController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: TChamp,
                                color: GRAY
                            ),
                            validator: (String value){
                              if(value.isEmpty){
                                return 'Champ mot de passe vide !';
                              }else{
                                _password = value;
                                return null;
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Mot de passe',
                              hintStyle: TextStyle(
                                color: GRAY,
                                fontSize: TChamp),
                              //contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                            ),
                            obscureText: _isHidden,
                          ),
                          //),
                        ),
                        Expanded(
                          flex:2,
                          child: new IconButton(
                            onPressed: _toggleVisibility,
                            icon: _isHidden? new Icon(Icons.visibility_off,):new Icon(Icons.visibility,),
                            color: GRAY,
                            iconSize: 20.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: new GestureDetector(
                    onTap: () {
                      if(isLoding == true){
                        showInSnackBar(_scaffoldKey,"Requête déjà en cours de traitement!", 5);
                      }else{
                        if(_formKey.currentState.validate()){
                          /*_username = _username.replaceAll(" ", "");
                          if(tryParse(_username)==false){
                            showInSnackBar(_scaffoldKey, "Téléphone invalide!", 5);
                          }else {
                            checkConnection();
                          }*/
                          checkConnection();
                        }
                      }
                    },
                    child: new Container(
                      height: HChamp,
                      width: MediaQuery.of(context).size.width - 40,
                      decoration: new BoxDecoration(
                        color: BLUE_ACCENT,
                        border: new Border.all(
                          color: Colors.transparent,
                          width: 0.0,
                        ),
                        borderRadius: new BorderRadius.circular(10.0),
                      ),
                      child: new Center(child: isLoding==false?new Text("CONNEXION",//SitLocalizations.of(context).suivant,
                        style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal),):
                      Theme(
                          data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                          child: CupertinoActivityIndicator(radius: 20,)),
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Pas encore inscrit?", style: TextStyle(
                          color: Colors.black
                      ),),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => SignupScreen()));
                        },
                        child: Text("  Créer un compte!", style: TextStyle(
                          color: BLUE_ACCENT,
                          fontWeight: FontWeight.bold
                        ),),
                      )
                    ],
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  makeLogin() async {
    //var bytes = utf8.encode('$_sername:$_password');
    //var credentials = base64.encode(bytes);
    var body = new Login(
      password: this._password,
      username: this._username
    );
    HttpClient client = new HttpClient();
    client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
    HttpClientRequest request = await client.postUrl(Uri.parse(url));
    request.headers.set('Accept', 'application/json');
    //request.headers.set('Authorization', 'Basic $credentials');
    request.headers.set('Content-type', 'application/json');
    request.add(utf8.encode(json.encode(body)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    print(reply +"\n ${response.statusCode}");
    print("Valeurs used: $_username:$_password");
    if(response.statusCode == 200){
      //var responseJson = json.decode(reply);
      token = reply;
      setState(() {
        isLoding = false;
      });
      this.save();
      Navigator.push(context, MaterialPageRoute(builder: (context) => ListHouseScreen()));
    }else if(response.statusCode == 400){
      setState(() {
        isLoding = false;
      });
      showInSnackBar(_scaffoldKey,"Nom d'utilisateur/email et mot de passe invalides!", 5);
    }else{
      print(response.statusCode);
      setState(() {
        isLoding = false;
      });
      showInSnackBar(_scaffoldKey,"Service indisponible!", 5);
    }
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isLoding = true;
      });
      makeLogin();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isLoding = true;
      });
      makeLogin();
    } else {
      AlertConnexion(context);
    }
  }

  void save() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(TOKEN, token);
  }
}