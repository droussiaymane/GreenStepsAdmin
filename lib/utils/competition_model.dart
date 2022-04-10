import 'package:cloud_firestore/cloud_firestore.dart';

class CompetitionModel {
  final String name;
  final String discreption;
  final List<dynamic> participants;
  final String dateDeDebut;
  final String dateDeFin;

  DocumentReference? reference;

  CompetitionModel(
    this.name,
    this.discreption,
    this.dateDeDebut,
    this.dateDeFin, {
    this.participants = const [],
  });
  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'discreption': discreption,
        'date de debut': dateDeDebut,
        'date de fin': dateDeFin,
        'participants': participants,
      };
  factory CompetitionModel.fromJson(Map<String, dynamic> json) {
    final competition = CompetitionModel(
        json["name"] as String,
        json["discreption"] as String,
        json["date de debut"] as String,
        json["date de fin"] as String,
        participants: json["participants"] as List<dynamic>);
    return competition;
  }
  factory CompetitionModel.fromSnapshot(DocumentSnapshot snapshot) {
    final competition =
        CompetitionModel.fromJson(snapshot.data() as Map<String, dynamic>);
    competition.reference = snapshot.reference;
    return competition;
  }
}
