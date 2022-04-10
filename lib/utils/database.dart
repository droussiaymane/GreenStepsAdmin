import 'package:web_app/constants.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:web_app/utils/utils.dart';

class DataBase {
  String users = "users";
  static String competitions = "competitions";
  static final FCMNotificationService _fcmNotificationService =
      FCMNotificationService();

  static Stream<QuerySnapshot> getCompetitionsStream() {
    return firebaseFirestore
        .collection(competitions)
        .orderBy("date de fin", descending: true)
        .snapshots();
  }

  static void createCompetition(CompetitionModel competitionModel) {
    firebaseFirestore
        .collection(competitions)
        .doc()
        .set(competitionModel.toJson());
  }

  static Future<void> sendMessage(UserModel user,String message) async {
    user.reference!.collection("messages").add({"date":DateTime.now().toString(),"text":message});
    try {
      await _fcmNotificationService.sendNotificationToUser(
        fcmToken: user.token!,
        title: 'nouveau message',
        body: message,
        type: "chat",
      );
    } catch (e) {
      print("################################");
      print(e);
    }
  }
}







// Future<UserModel> getUserById(String id) =>
  //     firebaseFirestore.collection(users).doc(id).get().then((doc) {
  //       return UserModel.fromSnapshot(doc);
  //     });

  // Future<bool> doesUserExist(String id) async => firebaseFirestore
  //     .collection(users)
  //     .doc(id)
  //     .get()
  //     .then((value) => value.exists);

  // Future<List<UserModel>> getAll() async =>
  //     firebaseFirestore.collection(users).get().then((result) {
  //       List<UserModel> users = [];
  //       for (DocumentSnapshot user in result.docs) {
  //         users.add(UserModel.fromSnapshot(user));
  //       }
  //       return users;
  //     });

  // Stream<QuerySnapshot> getUserStream() {
  //   return firebaseFirestore.collection(users).orderBy('nombrePasTotal', descending: true).snapshots();
  // }

  // static Future<QuerySnapshot> getCompetitions() {
  //   return firebaseFirestore.collection(competitions).orderBy("date de fin", descending: true).get();
  // }