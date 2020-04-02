
import 'package:flutter/material.dart';

import 'package:lock/Email/BluetoothConnection.dart';
import 'package:lock/Email/Services.dart';



class GuestDoor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final lockButton = Material(
        elevation: 5.0,
        color: Color.fromRGBO(252, 78, 3, 50.0),
        child: MaterialButton(
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
          },
          child: Text("Lock",
            textAlign: TextAlign.center,
          ),
        ));
    final unlockButton= Material(
        elevation: 5.0,
        color: Color.fromRGBO(140, 252, 3, 50.0),
        child: MaterialButton(
          minWidth: MediaQuery
              .of(context)
              .size
              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            BluetoothConnection().getConnection();
          },
          child: Text("Unlock",
            textAlign: TextAlign.center,
          ),
        ));


    return new Scaffold(
      appBar: new AppBar(
        title: Text("Welcome Door"),
        actions: <Widget>[
          FlatButton(
            child: Text("Sign Out"),
            color: Color.fromRGBO(250,250 ,250, 50),
            shape: CircleBorder(),
            onPressed: () async{
              await Services().signOut();
              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          )
        ],
        leading: new Container(),
      ),
      body: new Container(
        child: Column(
          children: <Widget>[
            lockButton,
            unlockButton,
          ],
        ),
      ),

    );
  }
}