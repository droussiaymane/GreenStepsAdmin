// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

//contants :
const kPrimaryColor = Color(0xFF0B6738);
const kOtherColor = Color(0xFF757a90);
const kLightPrimaryColor = Color(0xFF90A78C);
const kSecondaryColor = Color(0xFF0b2967);
const kLightSecondaryColor = Color.fromARGB(255, 29, 55, 108);

const TextStyle khead = TextStyle(fontSize: 30,fontWeight: FontWeight.bold,);
const TextStyle kbody = TextStyle(fontSize: 15);
const TextStyle kerror = TextStyle(fontSize: 15,color: kOtherColor);
const TextStyle kbutton = TextStyle(fontWeight: FontWeight.bold,fontSize: 15);
const TextStyle kutilisateur = TextStyle(color: Colors.white,fontSize: 15);
const TextStyle kTableCulumn = TextStyle(color: kSecondaryColor,fontSize: 15,fontWeight: FontWeight.bold);
const TextStyle kTableRow = TextStyle(color: kPrimaryColor,fontSize: 14);
const TextStyle kcustomCardTextStyle = TextStyle(color: Colors.white, fontSize: 25);
const TextStyle kcustomCardDateStyle = TextStyle(color: Colors.white, fontSize: 15);
const TextStyle kcustomCardColumnStyle = TextStyle(fontSize: 25);
const TextStyle kRadioButtonStyle = TextStyle(fontSize: 25,color: kSecondaryColor);

const  BorderSide borderSide =  BorderSide(
    width: 2,
    style: BorderStyle.solid,
    color: kOtherColor,
  );



//otheres
enum filterTES { tous, etudiant, staff }
enum sex { male, female }





List<String> departements = [
    "1337",
    "GTI",
    "CBS",
    "MSN",
    "ESAFE",
    "SAP+D",
    "ISSPB",
    "CS",
    "EMINES",
    "CI",
    "ALKHAWARIZMI",
    "Maher Center",
    "SHBM",
  ];






//firebase
final Future<FirebaseApp> initialization = Firebase.initializeApp(options: const FirebaseOptions(
      apiKey: "AIzaSyD4QK5HawV_zqhfFF7yI9LNk-JoUGXxhwg",
    authDomain: "greensteps-c5820.firebaseapp.com",
    projectId: "greensteps-c5820",
    storageBucket: "greensteps-c5820.appspot.com",
    messagingSenderId: "246362207665",
    appId: "1:246362207665:web:99075308e7ca842d7bb990"
    ),);
FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
FirebaseAuth auth = FirebaseAuth.instance;





//theme
ThemeData lightTheme(BuildContext context) {
  return ThemeData(
    colorScheme: const ColorScheme.light(
      primary: kPrimaryColor,
      secondary: kSecondaryColor,
    ),
    // textTheme: GoogleFonts.comicNeueTextTheme(Theme.of(context).textTheme),
  );
}


