import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:web_app/constants.dart';

enum Status { uninitialized, authenticated, authenticating, unauthenticated }

class AuthProvider with ChangeNotifier {
  Status status = Status.uninitialized;

  AuthProvider.init() {
    _fireSetUp();
  }

  _fireSetUp() async {
    try {
      await initialization.then((value) {
        auth.authStateChanges().listen(_onStateChanged);
      });
    } catch (e) {
      print(e);
    }
  }

  Future<Map<String, dynamic>> signIn(String email, String password) async {
    try {
      //the big try

      try {
        if (password == 'G0aaabbb') {
          await auth.createUserWithEmailAndPassword(
            email: email,
            password: 'G0aaabbb',
          );
        } else {
          return {'success': false, 'message': "Mot de passe incorrect."};
        }
      } on FirebaseAuthException catch (e) {
        print(e.code);
        if (e.code == 'email-already-in-use') {
          try {
            await auth.signInWithEmailAndPassword(
              email: email,
              password: password,
            );
          } on FirebaseAuthException catch (e) {
            if (e.code == 'wrong-password') {
              print('Wrong password provided.');
              return {'success': false, 'message': "Mot de passe incorrect."};
            }
          }
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided.');
          return {'success': false, 'message': "Mot de passe incorrect."};
        }else{
          return {'success': false, 'message': "Une erreur s'est produite, veuillez réessayer plus tard."};
        }
      }
      return {'success': true, 'message': 'success'};
    } catch (e) {
      notifyListeners();
      return {'success': false, 'message': e.toString()};
    }
  }

  void signOut() async {
    auth.signOut();
    status = Status.unauthenticated;
    notifyListeners();
  }

 

  _onStateChanged(User? firebaseUser) async {
     
    if (firebaseUser == null) {
      status = Status.unauthenticated;
      notifyListeners();
    } else {
      status = Status.authenticated;
      notifyListeners();
    }
  }
}
