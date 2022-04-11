import 'package:cloud_firestore/cloud_firestore.dart';

class CompetitionModel {
  final String name;
  final String discreption;
  final String dateDeDebut;
  final String dateDeFin;
  final int nombreDeParticipants;
  DocumentReference? reference;

  CompetitionModel(this.name, this.discreption, this.dateDeDebut,
      this.dateDeFin, this.nombreDeParticipants);
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'discreption': discreption,
        'date de debut': dateDeDebut,
        'date de fin': dateDeFin,
        'nombre de participants': nombreDeParticipants,
      };
  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    final competition = CompetitionModel(
      json["name"] as String,
      json["discreption"] as String,
      json["date de debut"] as String,
      json["date de fin"] as String,
      json["nombre de participants"] as int,
    );
    return competition;
  }
  factory CompetitionModel.fromSnapshot(DocumentSnapshot snapshot) {
    final competition =
        CompetitionModel.fromJson(snapshot.data() as Map<String, dynamic>);
    competition.reference = snapshot.reference;
    return competition;
  }
}

class Participant {
  final DocumentReference user;
  final String prenom;
  final String nom;
  final String sexe;
  final String departement;
  final num poids;
  final num taille;
  final int rang;
  final Map<String, dynamic> pasHistorique;

  DocumentReference? reference;

  Participant(this.user, this.prenom, this.nom, this.sexe, this.departement,
      this.poids, this.taille, this.rang, this.pasHistorique);

  factory Participant.fromJson(Map<String, dynamic> json) {
    final participant = Participant(
        json["user"],
        json["prenom"],
        json["nom"],
        json["sexe"],
        json["departement"],
        json["poids"],
        json["taille"],
        json["rang"],
        json["pasHistorique"]);

    return participant;
  }
  factory Participant.fromSnapshot(DocumentSnapshot snapshot) {
    final participant =
        Participant.fromJson(snapshot.data() as Map<String, dynamic>);
    participant.reference = snapshot.reference;
    return participant;
  }
}
