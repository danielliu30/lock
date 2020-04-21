
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lock/Email/Admin.dart';
import 'package:lock/Email/User.dart';
import 'dart:math';

//Object used to handle CRUD operations associated with guest and admin accounts
class Services{

  static FirebaseUser adminUser = null; //Firebase Account
  static FirebaseAuth _fBAuth = FirebaseAuth.instance; //connection to Firebase
  final Firestore _fsAuth = Firestore.instance; //connection to database

  //creates guest or admin account based on optional parameter admminKey
  Future<String> createAccount (String email, String pword,[String adminKey]) async{
    try{
      if(adminKey!= null && adminKey.toLowerCase() == "admin"){
        AuthResult result =  await _fBAuth.createUserWithEmailAndPassword(
            email: email.trim(), password: pword.trim());
        adminUser = result.user;
        Admin admin = new Admin(adminKey, email, adminUser);
        //checkAcc = await _fsAuth.collection("AdminList").where("email"== email).getDocuments();
        await _fsAuth.collection("AdminList").document(adminUser.uid).setData(admin.toJson());
      }else{

        AuthResult result =  await _fBAuth.createUserWithEmailAndPassword(
            email: email.trim(), password: pword.trim());
        var guest  = result.user;
        User added = new User(email,guest,pword);
        var check = await _fsAuth.collection("AdminList").document(adminUser.uid)
            .collection("Guests").document(guest.uid).setData(added.toJson());
        await _fBAuth.signOut();
      }
      return adminUser.uid;
    }catch(e){
      if(e is PlatformException){
        print(e.details);
      }
    }
    return null;
  }

  //login account using email and password
  Future<DocumentSnapshot> login(String email, String password)  async{
    AuthResult result;
    try{
      result = await _fBAuth.signInWithEmailAndPassword(email: email.trim(), password: password.trim());
      adminUser = result.user;
      var snapShot = await Firestore.instance.collection('AdminList').document(adminUser.uid).get();
      if (snapShot.exists){
        return snapShot;
      }
    }catch(e){
      if(e is PlatformException){
        print(e.details);
      }
    }
    return null;
  }

  //returns a list of guests
  Future<List<DocumentSnapshot>> getGuestList ()async{
    var guestList = await _fsAuth.collection("AdminList").document(adminUser.uid).collection("Guests").getDocuments();
    return guestList.documents;
  }

  //sign out user or admin
  Future<void >signOut() async{
     var before = await _fBAuth.currentUser();
     await _fBAuth.signOut();
     var test = await _fBAuth.currentUser();
     var test1 = await _fBAuth.currentUser();
  }

  //removes guest using email
  Future<void> deleteGuest(String email) async{
      var guest = await _fsAuth.collection("AdminList").document(adminUser.uid).collection("Guests").getDocuments();
      var pword = guest.documents.asMap()[0].data["password"].toString();
      var temp = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: pword.trim());
      await _fsAuth.collection("AdminList").document(adminUser.uid).collection("Guests").document(temp.user.uid).delete();
      temp.user.delete();
  }

  //creates door code
  Future<void> generateCode() async{
    var rng = new Random();
    var number = rng.nextInt(900000) + 100000;
    await _fsAuth.collection("DoorCode").document("IrEZ9agFV8FjafIvd7oY").updateData(codeToJson(number));
  }

  //fetches door code
  Future<String> getCode() async {
    var guest = await _fsAuth.collection("DoorCode")
        .document("IrEZ9agFV8FjafIvd7oY").get();
    var item = await guest.data.values.toList()[0];
    return  await item;

  }

  Map<String, dynamic> codeToJson(int code) =>{
    'adminKey':code
  };
}

