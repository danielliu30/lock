import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class Admin{

    String _adminKey;
    String _email;
    String _uid;
    FirebaseUser _fbUser;

    Admin(String adminKey, String email, FirebaseUser fbUser){
      _adminKey = adminKey;
      _email = email;
      _uid = fbUser.uid;
    }
    Map<String, dynamic> toJson() =>{
      'adminKey':_adminKey,
      'email':_email,
      'uid':_uid
    };
    void deleteUser(){

    }
    //getter and setter
}