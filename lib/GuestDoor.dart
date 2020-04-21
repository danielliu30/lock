
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:lock/Email/AccountServices.dart';


//creates view for guest users after sign in
class GuestDoor extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final lockButton = SizedBox(
        width: MediaQuery.of(context).size.width/2.2,
        child: MaterialButton(
          color: Color.fromRGBO(252, 78, 3, 50.0),
//          minWidth: MediaQuery
//              .of(context)
//              .size
//              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
          },
          child: Text("Lock",
            textAlign: TextAlign.center,
          ),
        ));
    final unlockButton= SizedBox(
        width: MediaQuery.of(context).size.width/2.2,
        child: MaterialButton(
          color: Color.fromRGBO(140, 252, 3, 50.0),
//          minWidth: MediaQuery
//              .of(context)
//              .size
//              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
          },
          child: Text("Unlock",
            textAlign: TextAlign.center,
          ),

        ));

    final callOwner= SizedBox(
        width: MediaQuery.of(context).size.width/2.2,
        child: MaterialButton(
          color: Color.fromRGBO(0, 191, 255, 50.0),
//          minWidth: MediaQuery
//              .of(context)
//              .size
//              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () => launch("tel://6142869636"),
          child: Text("Call Owner",
            textAlign: TextAlign.center,
          ),
        ));

    final requestCode = SizedBox(
        width: MediaQuery.of(context).size.width/2.2,
        child: MaterialButton(
          color: Color.fromRGBO(0, 191, 150, 50.0),
          child: Text("Request Code",
            textAlign: TextAlign.center,
          ),
//          minWidth: MediaQuery
//              .of(context)
//              .size
//              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: ()async {
            String code = await Services().getCode();
            showDialog(context: context,
                builder: (context){
                  return Dialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                    child: Container(
                        height: 400.0,
                        width: 360.0,
                        child: ListView(
                          children: <Widget>[
                            SizedBox(height: 20),
                            Center(
                              child: Text(
                                "Door Code",
                                style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                            ),
                            SizedBox(height: 20),
                                FlatButton(
                              color: Color.fromRGBO(120, 220, 10, 50),
                              child: Text(code),
                              onPressed: (){
                                  Navigator.pop(context);
                              },
                            )
                          ],
                        )
                    ),
                  );

                });
          },
        ));

    final userButton = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        callOwner,
        requestCode
      ],
    );

    final doorControl = ButtonBar(
      alignment: MainAxisAlignment.center,
      children: <Widget>[
        unlockButton,
        lockButton
      ],
    );
    
    return new Scaffold(
      appBar: new AppBar(
        title: Text("Welcome Door"),
        centerTitle: true,
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
            SizedBox(height: 150),
            doorControl,
            SizedBox(height: 50),
            userButton
          ],
        ),
      ),
    );
  }
}