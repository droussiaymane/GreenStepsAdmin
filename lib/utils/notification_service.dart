import 'dart:async';
import 'dart:convert' show json;
// import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

abstract class IFCMNotificationService {
  Future<void> sendNotificationToUser({
    required String fcmToken,
    required String title,
    required String body,
    required String type,
  });
  Future<void> sendNotificationToAll({
    required String title,
    required String body,
  });
}

class FCMNotificationService extends IFCMNotificationService {
  // final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final String _endpoint = 'https://fcm.googleapis.com/fcm/send';
  final String _contentType = 'application/json';
  final String _authorization =
      'key=AAAAOVxU9bE:APA91bHHLJo22EUvg1HimawCD-uUzvEmwBmEzRlSY6c7sFb4isgVk1nsZNfBsRtfQPWT_X7j7xiL2nCPEGuHl5js3oZ6I-3t7DasAISZw6srDnpuLtseIFTJl43JHtC4uRb1gcMaaUT6';

  Future<http.Response> _sendNotificationByToken(
    String to,
    String title,
    String body,
    String type,
  ) async {
    final dynamic data = json.encode(
      {
        'token': to,
        'priority': 'high',
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'type': type,
        },
        'content_available': true
      },
    );
    try {
      http.Response response = await http.post(
        Uri.parse(_endpoint),
        body: data,
        headers: {
          'Content-Type': _contentType,
          'Authorization': _authorization
        },
      );

      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<http.Response> _sendNotificationByTopic(
    String to,
    String title,
    String body,
    String type,
  ) async {
    final dynamic data = json.encode(
      {
        'topic': to,
        'priority': 'high',
        'notification': {
          'title': title,
          'body': body,
        },
        'data': {
          'type': type,
        },
        'content_available': true
      },
    );
    try {
      http.Response response = await http.post(
        Uri.parse(_endpoint),
        body: data,
        headers: {
          'Content-Type': _contentType,
          'Authorization': _authorization
        },
      );

      return response;
    } catch (error) {
      throw Exception(error);
    }
  }

  @override
  Future<void> sendNotificationToUser({
    required String fcmToken,
    required String title,
    required String body,
    required String type,
  }) {
    return _sendNotificationByToken(
      fcmToken,
      title,
      body,
      type,
    );
  }

  @override
  Future<void> sendNotificationToAll(
      {required String title, required String body}) {
    return _sendNotificationByTopic("all", title, body, "compettion");
  }
}
