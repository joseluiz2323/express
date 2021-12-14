import 'dart:ui';

import 'package:express/myhomeEstoque.dart';
import 'package:express/myhomeQrCode.dart';
import 'package:express/shared/admin.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String _inputtext = '';

class _MyHomePageState extends State<MyHomePage> {
  final myControllermural = TextEditingController();
  String _inputtext;
  bool botbool = false;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myControllermural.dispose();
    super.dispose();
  }

  void _processText() {
    setState(() {
      print('jose');
      _inputtext = myControllermural.text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        actions: [
          Icon(
            Icons.account_circle_rounded,
            color: Colors.black,
            size: 50,
          ),
          SizedBox(
            width: 5,
          )
        ],
        backgroundColor: Color.fromRGBO(255, 0, 0, 1),
      ),
      body: Container(
        color: Color.fromRGBO(255, 0, 0, 1),
        child: Column(
          children: [
            SizedBox(
              width: 5,
              height: 14,
            ),
            Container(
              child: Container(
                width: double.infinity,
                height: 300.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    color: Color.fromRGBO(175, 0, 6, 1)),
                child: Container(
                  child: Center(
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextFormField(
                              controller: myControllermural,
                              onChanged: (text) => setState(() => _inputtext),
                              cursorColor: Colors.green,
                              style: TextStyle(color: Colors.green),
                              decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(color: Colors.green, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide(
                                      color: Colors.green,
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  fillColor: Colors.green,
                                  icon: Icon(Icons.notes_sharp),
                                  labelText: 'postar no mural',
                                  suffixStyle: TextStyle(color: Colors.green),
                                  counterStyle: TextStyle(color: Colors.green)),
                            ),
                          ),
                        ),
                        useradmin == true
                            ? Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                textDirection: TextDirection.rtl,
                                children: [
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                    color: myControllermural.text.length < 5 ? Colors.grey : Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    onPressed: () => print("Button Pressed"),
                                    child: new Text("Postar"),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  RaisedButton(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18.0),
                                      side: BorderSide(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      myControllermural.clear();
                                    },
                                    child: Text('limpar'),
                                  ),
                                ],
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 5,
              height: 50,
            ),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                          bottomLeft: Radius.circular(30.0),
                          bottomRight: Radius.circular(30.0),
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            child: ButtonTheme(
                              buttonColor: Colors.grey[100],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => DropDown()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.qr_code_scanner_sharp,
                                      size: 80,
                                    ),
                                    Text('QrCode')
                                  ],
                                ),
                              ),
                            ),
                            height: 200,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: ButtonTheme(
                              buttonColor: Colors.grey[100],
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              child: RaisedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => EstoquePage()),
                                  );
                                },
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.analytics_outlined,
                                      size: 80,
                                    ),
                                    Text('Verificaçao de'),
                                    Text('Estoque')
                                  ],
                                ),
                              ),
                            ),
                            height: 200,
                          ),
                        ),
                        Expanded(
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.person_remove_alt_1_rounded,
                                  size: 80,
                                ),
                                Text('Minhas'),
                                Text('configurações')
                              ],
                            ),
                            width: 80,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: new BorderRadius.only(
                                topRight: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                              color: Colors.grey[200],
                              border: Border.all(color: Colors.black, width: 0.1),
                            ),
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
