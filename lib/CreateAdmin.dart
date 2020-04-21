
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lock/AdminDoor.dart';
import 'package:lock/Email/Admin.dart';
import 'package:lock/Email/AccountServices.dart';


//creates view for admin account sign up
class CreateAdmin extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _CreateAdminPageState();

}

class _CreateAdminPageState extends State<CreateAdmin> {

      int buttonCount = 0;
      String userId = "";
      final emailController = TextEditingController();
      final passwordController = TextEditingController();
      final adminController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final passwordField = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
      ),
      controller: passwordController,
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
    );

    final emailField = TextFormField(
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
      ),
      controller: emailController,
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null
    );

    final adminKeyField = TextFormField(
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Key",
        ),
        controller: adminController,
    );


    final loginButton = Material(
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
             userId = await Services().createAccount( emailController.text, passwordController.text,adminController.text);
            setState(() {
              if(buttonCount == 0){
                loadButton();
              }
              if(userId != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Door()),
                );
              }
            });
          },
        ));


    return Scaffold(
      appBar: new AppBar(
        title: new Text('Create Admin'),
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
                SizedBox(height: 25.0),
                adminKeyField,
                SizedBox(height: 35.0,),
                loginButton,
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