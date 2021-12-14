import 'package:express/myHomePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final myControlleruser = TextEditingController();
  final myControlleruserpassword = TextEditingController();
  bool _aprovado = false;
  bool _userbool, _passbool;
  final databaseReference = Firestore.instance;
  var userPass;
  Future getData() async {
    databaseReference.collection('user').getDocuments().then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) {
        varificuser(f);
        varificpass(f);
      });
    });
  }

  void varificuser(var very) {
    if (very['user'] == myControlleruser.text) {
      _userbool = true;
    }
  }

  void varificpass(var very) {
    if (very['password'] == myControlleruserpassword.text.toString()) {
      _passbool = true;
    }
  }

  _saveOptions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('option', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Column(
              children: [
                ClipPath(
                  clipper: WaveClipperOne(),
                  child: Container(
                    height: 290,
                    color: Colors.red[900],
                    child: Center(
                      child: Image.asset(
                        'images/icon.png',
                        width: 180,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Login',
            style: TextStyle(color: Colors.red[900], letterSpacing: .5, fontSize: 30),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Form(
                autovalidate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: myControlleruser,
                      decoration: InputDecoration(
                          labelText: "CPF:",
                          labelStyle: TextStyle(color: Colors.lightGreen),
                          errorStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      validator: (value) {
                        if (value.toString().length < 12) {
                          return 'cpf invalido1';
                        }
                      },
                    )
                  ],
                )),
          ),
          Container(
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.only(left: 40, right: 40),
            child: Form(
                autovalidate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      controller: myControlleruserpassword,
                      decoration: InputDecoration(
                          labelText: "Senha:",
                          labelStyle: TextStyle(color: Colors.lightGreen),
                          errorStyle: TextStyle(color: Colors.black),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0))),
                      validator: (value) {
                        switch (value) {
                          case null:
                            return "senha";
                            break;
                          case null:
                            return "senha";

                          default:
                        }
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      width: 180,
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28.0),
                        ),
                        color: Colors.red[700],
                        onPressed: () {
                          getData();
                          Future.delayed(Duration(seconds: 2), () {
                            // 5s over, navigate to a new page
                            if (_userbool == true) {
                              if (_passbool == true) {
                                Navigator.pushReplacement(context, CupertinoPageRoute(builder: (context) => MyHomePage()));
                                _saveOptions();
                              }
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              "Entrar",
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
