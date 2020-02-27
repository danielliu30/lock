
import 'package:flutter/material.dart';
import 'package:lock/CreateAdmin.dart';
import 'package:lock/Email/Services.dart';
import 'package:lock/Login.dart';

import 'package:lock/main.dart';

final emailController = TextEditingController();
final passwordController = TextEditingController();

class Door extends StatelessWidget {



  @override
  Widget build(BuildContext context) {

    final passwordField = TextFormField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
                const Radius.circular(10.0)
            )
        ),
        contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        hintText: "Password",
      ),
      controller: passwordController,
      //onSaved: (value) => _pword = value,
      validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null,
    );
    final emailField = TextFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: const BorderRadius.all(
              const Radius.circular(10.0)
            )
          ),
         // contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
        ),
        controller: emailController,
        //onSaved: (value) => _email = value.trim(),
        validator: (value) => value.isEmpty ? 'Email can\'t be empty' : null
    );
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

    final addGuest= SizedBox(
        width: MediaQuery.of(context).size.width/2.2,
        child: MaterialButton(
          color: Color.fromRGBO(0, 191, 255, 50.0),
//          minWidth: MediaQuery
//              .of(context)
//              .size
//              .width,
          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: () {
            showDialog(context: context,
            builder: (context){
              return Dialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                child: Container(
                  height: 400.0,
                  width: 360.0,
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 17.0),
                      emailField,
                      passwordField,
                      MaterialButton(
                        child: Text("Create Guest"),
                        color: Color.fromRGBO(0, 191, 255, 50.0),
                        onPressed: (){
                            Services().createAdmin(emailController.text,passwordController.text);
                            Navigator.pop(context);
                        },
                      )
                    ],
                  )
                ),

              );

            });
          },
          child: Text("Add Guest",
            textAlign: TextAlign.center,
          ),
        ));

    final removeGuest = SizedBox(
        width: MediaQuery.of(context).size.width/2.2,
        child: MaterialButton(
          color: Color.fromRGBO(0, 191, 150, 50.0),
          child: Text("Remove Guest",
            textAlign: TextAlign.center,
          ),
//          minWidth: MediaQuery
//              .of(context)
//              .size
//              .width,

          padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          onPressed: ()async {
            var guestList = await Services().getGuestList();
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
                                "Guests",
                                style: TextStyle(fontSize: 24, color: Colors.blue, fontWeight: FontWeight.bold),
                              ),
                             ),
                            SizedBox(height: 20),
                            for(var d in guestList) FlatButton(
                              color: Color.fromRGBO(120, 220, 10, 50),
                              child: Text(d.data["email"]),
                              onPressed: (){
                                  Services().deleteGuest(d.data["email"]);
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
          addGuest,
          removeGuest
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