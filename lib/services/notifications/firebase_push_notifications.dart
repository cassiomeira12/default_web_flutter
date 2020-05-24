import 'dart:convert';
import 'package:dio/dio.dart';

class FirebasePushNotifications {

  static Future<int> sendNotification(String title, String message, String token, String topic) async {
    String serverToken = "AAAAWQPCwag:APA91bHIiaTWTTDxL0JMDhblA7du3MNcH-izSvMF20YrpeGiuWsWxzN_SBZe3zc9_1VnNJTFc3BBh50I93uRGNB6toeY4z2O0CHZjgT2YFbvC9UK_TfVgjpF5BJpdsVlP3Wjuf4wyQU-";

    var dio = Dio(
      BaseOptions(
        baseUrl: "https://fcm.googleapis.com/fcm/send",
        connectTimeout: 5000,
        headers: <String, String> {
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
      ),
    );

    Response response = await dio.post(
      "",
      data: jsonEncode(
          <String, dynamic> {
            'notification': <String, dynamic> {
              'image': null,
              'title': title,
              'body': message,
            },
            'priority': 'high',
            'data': <String, dynamic> {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
            },
            'to': token == null ? '/topics/$topic' : token,
          }
      ),
    );

    return response.statusCode;
  }

}