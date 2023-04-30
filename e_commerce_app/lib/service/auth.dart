import 'package:cloud_firestore/cloud_firestore.dart';
import "package:firebase_auth/firebase_auth.dart";
import 'package:flutter/material.dart';
import "../screens/get_started_page.dart";

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  signIn(String email, String password) async {
    await _auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
      MaterialPageRoute(builder: (context) => const GetStartedPage());
    });
  }

  signOut() async {
    return await _auth.signOut();
  }

  Future<User?> createUser(
      String firstName, String lastName, String email, String password) async {
    var user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    await _firestore.collection("User").doc(user.user!.uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
    });

    return user.user;
  }
}
