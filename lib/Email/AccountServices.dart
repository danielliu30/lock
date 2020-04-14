
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:lock/Email/Admin.dart';
import 'package:lock/Email/User.dart';

class Services{

  static FirebaseUser adminUser = null;
  static FirebaseAuth _fBAuth = FirebaseAuth.instance;
  final Firestore _fsAuth = Firestore.instance;


  Future<String> createAdmin (String email, String pword,[String adminKey]) async{
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
  
  Future<List<DocumentSnapshot>> getGuestList ()async{
    var guestList = await _fsAuth.collection("AdminList").document(adminUser.uid).collection("Guests").getDocuments();
    return guestList.documents;
  }

  Future<void >signOut() async{
     var before = await _fBAuth.currentUser();
     await _fBAuth.signOut();
     var test = await _fBAuth.currentUser();
     var test1 = await _fBAuth.currentUser();
  }

  Future<void> deleteGuest(String email) async{
      var guest = await _fsAuth.collection("AdminList").document(adminUser.uid).collection("Guests").getDocuments();
      var pword = guest.documents.asMap()[0].data["password"].toString();
      var temp = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.trim(), password: pword.trim());
      await _fsAuth.collection("AdminList").document(adminUser.uid).collection("Guests").document(temp.user.uid).delete();
      temp.user.delete();
  }
}

