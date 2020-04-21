

import 'package:flutter/material.dart';
import 'package:lock/Login.dart';
import 'CreateAdmin.dart';

void main() => runApp(new MyApp());

//creates view for start up page
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Welcome',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new Select()
    );
  }
}

class Select extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginButon = Material(
        elevation: 5.0,
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Login()),
            );
          },
          child: Text("Login",
            textAlign: TextAlign.center,
          ),
        ));
    final adminButton = Material(
        elevation: 5.0,
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CreateAdmin()),
            );
          },
          child: Text("Create Admin",
            textAlign: TextAlign.center,
          ),
        ));
    return Scaffold(
      appBar: AppBar(
        title: Text('Select'),
      ),
      body: Center(
        child : Column(
            children: <Widget>[
              SizedBox(height: 405.0),
              loginButon,
              SizedBox(height: 25.0),
              adminButton
            ]
        ),
      ),
    );
  }
}
