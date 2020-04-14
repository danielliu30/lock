
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lock/AdminDoor.dart';
import 'package:lock/Email/Admin.dart';
import 'package:lock/Email/AccountServices.dart';
import 'package:lock/GuestDoor.dart';

class Login extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _LoginPageState();

}

class _LoginPageState extends State<Login> {

  int buttonCount = 0;
  String userId = "";
  String _email = "";
  String _pword = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
      ),
      controller: passwordController,
      onSaved: (value) => _pword = value,
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
    );
    final emailField = TextFormField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
        ),
        controller: emailController,
        onSaved: (value) => _email = value.trim(),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null
    );


    final loginButon = Material(
        elevation: 5.0,
        color: Color(0xff01A0C7),
        child: MaterialButton(
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          child: updateButtonState(),
          onPressed: () async {
            var admin = await Services().login(emailController.text, passwordController.text);
            setState(() {
              if(buttonCount == 0){
                loadButton();
              }
              if(admin != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Door()),
                );
              }else{
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => GuestDoor()));
              }
            });
          },

        ));

    return Scaffold(
      appBar: new AppBar(
        title: new Text('Login'),
      ),
      body: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                SizedBox(height: 25.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(height: 35.0,),
                loginButon,
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadButton() {
    setState(() {
      buttonCount = 1;
    });

    Timer(Duration(milliseconds: 3300), () {
      setState(() {
        buttonCount = 2;
      });
    });
  }

  Widget updateButtonState(){
    if(buttonCount == 0){
      return new Text(
        "Login",
      );
    }else if (buttonCount == 1) {
      return CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      );
    } else {
      return Icon(Icons.check, color: Colors.white);
    }
  }
}