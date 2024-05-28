import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:friendszone_app/models/user.dart' as model;
import 'package:friendszone_app/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // Sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async{
    String res = "Some error occured";
    try{
      if(email.isNotEmpty || email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty   ){
      UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print(cred.user!.uid);

      String photoUrl = await StorageMethods()
      .uploadImageToStorage('profilePics', file, false);

      model.User user = model.User(
        username: username,
        uid: cred.user!.uid,
        email: email,
        bio: bio,
        photoUrl: photoUrl,
        following: [],
        followers: [],
      );

      await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);

      res = "success";
      }
    }
    
    catch(err){
      res = err.toString();
    }
    return res;
  }

  Future<String> loginUser({
    required String email,
    required String password,
  }) async{
    String res = "some errors occured";
    try{
      if(email.isNotEmpty || password.isNotEmpty){
       await _auth.signInWithEmailAndPassword(email: email, password: password);
      } else{
        res = "please enter the field";
      }
    } catch(err){
      res = err.toString();
    }
    return res;
  }
}