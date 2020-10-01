import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:estate_agent/constants.dart';
import 'package:estate_agent/screens/signin_screen.dart';
import 'package:estate_agent/services/classes.dart';
import 'package:estate_agent/services/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  FocusNode searchFocus = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>(), flagUri, usernameController, passController, phoneController, emailController;
  var _categorie = ['TENANT', 'LESSOR'];
  //var _categorie = ['SIMPLE_ROOM', 'MODERN_ROOM', 'STUDIO', 'SIMPLE_HOUSE', 'FURNISHED_APARTMENT', 'LUXURY_HOUSE'];
  bool isLoding =false, coched = false, _isHidden = true;
  String _username, url, lang="FR", currencyConnexion, currencySymbol, iso3, pays, _mySelection = "+237",_sername, iso="CM", _password, token, email, type, phone;

  void _toggleVisibility(){
    setState((){
      _isHidden = !_isHidden;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    url = "$BaseUrl/users/create";
    usernameController = new TextEditingController();
    passController = new TextEditingController();
    emailController = new TextEditingController();
    phoneController = new TextEditingController();
    Timer(Duration(milliseconds: 100), () {
      FocusScope.of(context).requestFocus(searchFocus);
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
                              hintText: 'Nom d\'utilisateur',
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
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    margin: EdgeInsets.only(top: 0.0),
                    decoration: new BoxDecoration(
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
                            child: new Icon(Icons.email, color: GRAY,),
                          ),
                        ),
                        new Expanded(
                          flex:12,
                          //child: Padding(
                          child: new TextFormField(
                            controller: emailController,
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(
                                fontSize: TChamp,
                                color: GRAY
                            ),
                            validator: (String value){
                              if(value.isEmpty){
                                return 'Email vide !';
                              }else{
                                email = value;
                                return null;
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText: 'Email',
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
                          child: new Icon(Icons.lock, color: GRAY,),
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
                  padding: EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    decoration: new BoxDecoration(
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
                            controller: phoneController,
                            keyboardType: TextInputType.phone,
                            style: TextStyle(
                              fontSize: TChamp,
                              color: GRAY,
                            ),
                            validator: (String value){
                              if(value.isEmpty){
                                return "Numéro de téléphone invalide !";//SitLocalizations.of(context).invalid_phone;
                              }else{
                                if(_mySelection == "+33" && value.startsWith("0")){
                                  phone = _mySelection.substring(1)+value.substring(1);
                                  _sername = value.substring(1);
                                }else{
                                  phone = _mySelection.substring(1)+value;
                                  _sername = value;
                                }
                                return null;
                              }
                            },
                            decoration: InputDecoration.collapsed(
                              hintText:"Numéro de téléphone",// SitLocalizations.of(context).phone,
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
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Container(
                    decoration: new BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        bottomLeft: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                      color: Colors.white,
                      border: Border.all(
                          color: GRAY,
                          width: border
                      ),
                    ),
                    height: HChamp,
                    child: Row(
                      children: <Widget>[
                        new Expanded(
                          flex:2,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: new Icon(Icons.home, color: GRAY,),
                          ),
                        ),
                        Expanded(
                          flex: 10,
                          child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                icon: Padding(
                                  padding: EdgeInsets.only(right: 10),
                                  child: new Icon(Icons.arrow_drop_down_circle,
                                    color: GRAY,),
                                ),
                                isDense: false,
                                elevation: 1,
                                isExpanded: true,
                                onChanged: (String selected){
                                  setState(() {
                                    type = selected;
                                  });
                                },
                                value: type,
                                hint: Text('Type de maison',
                                  style: TextStyle(
                                    color: GRAY,
                                    fontSize:TChamp,
                                  ),),
                                items: _categorie.map((String name){
                                  return DropdownMenuItem<String>(
                                    value: name,
                                    child: Text(name.replaceAll("_", " "),
                                      style: TextStyle(
                                        color: GRAY,
                                        fontSize:TChamp,
                                      ),),
                                  );
                                }).toList(),
                              )
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
                          phone = phone.replaceAll(" ", "");
                          if(tryParse(phone)==false){
                            showInSnackBar(_scaffoldKey, "Téléphone invalide!", 5);
                          }else if(isEmail(email) == false){
                            showInSnackBar(_scaffoldKey, "Email invalide!", 5);
                          } else {
                            checkConnection();
                          }
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
                      child: new Center(child: isLoding==false?new Text("INSCRIPTION",//SitLocalizations.of(context).suivant,
                        style: new TextStyle(color: Colors.white, fontWeight: FontWeight.normal),):
                      Theme(
                          data: ThemeData(cupertinoOverrideTheme: CupertinoThemeData(brightness: Brightness.dark)),
                          child: CupertinoActivityIndicator(radius: 20,)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkConnection() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      setState(() {
        isLoding = true;
      });
      makeRegister();
    } else if (connectivityResult == ConnectivityResult.wifi) {
      setState(() {
        isLoding = true;
      });
      makeRegister();
    } else {
      AlertConnexion(context);
    }
  }

  makeRegister() async {
    var body = new Register(
      password: this._password,
      username: this._username,
      email: email,
      phone: phone,
      type: type
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
    print("Valeurs used: ${json.encode(body)}");
    if(response.statusCode == 201){
      //var responseJson = json.decode(reply);
      setState(() {
        isLoding = false;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context) => SigninScreen()));
    }else if(response.statusCode == 400){
      setState(() {
        isLoding = false;
      });
      showInSnackBar(_scaffoldKey,"Nom d'utilisateur/email et mot de passe invalides!", 5);
    }else{
      print(response.statusCode);
      var responseJson = json.decode(reply);
      setState(() {
        isLoding = false;
      });
      if(responseJson['message'] == "PHONE_ALREADY_EXIST"){
        showInSnackBar(_scaffoldKey,"Ce numéro poccède déjà un compte!", 5);
      }else
      showInSnackBar(_scaffoldKey,"Service indisponible!", 5);
    }
  }

}
