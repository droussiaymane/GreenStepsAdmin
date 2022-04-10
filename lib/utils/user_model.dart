import 'package:cloud_firestore/cloud_firestore.dart';



class UserModel {
  String? nom;
  String? prenom;
  String? dateNaissance;
  String? sexe;
  String? departement;
  num? taille;
  num? poids;
  int? cible;
  String? email;
  int? nombrePasTotal;
  List<dynamic>? pasHistorique;
  String? token;

  DocumentReference? reference;

  UserModel({
    this.nom,
    this.prenom,
    this.dateNaissance,
    this.sexe,
    this.departement,
    this.taille,
    this.poids,
    this.cible,
    this.email,
    this.reference,
    this.nombrePasTotal,
    this.pasHistorique,
    this.token,
  });

  factory UserModel.fromJson(Map<dynamic, dynamic> json) => UserModel(
        nom: json['nom'] as String? ,
        prenom: json['prenom'] as String? ,
        dateNaissance: json['dateNaissance'] as String? ,
        sexe: json['sexe'] as String? ,
        departement: json['departement'] as String? ,
        taille: (json['taille'] != null)
            ? num.tryParse(json['taille'] as String) ?? 170
            : null,
        poids: (json['poids'] != null)
            ? num.tryParse(json['poids'] as String) ?? 69
            : null,
        cible: (json['cible'] != null)
            ? int.tryParse(json['cible'] as String) ?? 20000
            : null,
        email: json['email'] as String?,
        nombrePasTotal : json["nombrePasTotal"] as int? ?? 0,
        pasHistorique : json['pasHistorique'] as List<dynamic>?,
        token: json['token'] as String?,
      );

  
  factory UserModel.fromSnapshot(DocumentSnapshot snapshot) {
    final userModel = UserModel.fromJson(snapshot.data() as Map<String, dynamic>);
    userModel.reference = snapshot.reference;
    return userModel;
  }
}


