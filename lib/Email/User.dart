import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';


class User {
  String _email;
  String _uid;
  String _password;

  User(String email, FirebaseUser userId, String password) {
    this._email = email;
    this._uid = userId.uid;
    this._password = password;
  }

  Map<String, dynamic> toJson() =>
      {
        'email': _email,
        'uid': _uid,
        'password': _password
      };

}