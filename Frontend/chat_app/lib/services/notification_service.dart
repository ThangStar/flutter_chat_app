import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  NotificationService();

  static showNoti(int id, FlutterLocalNotificationsPlugin fln,
      Function(String) callBackEmitMessage, Map<String, dynamic> icerik) async {
    String longdata = icerik["notification"]["body"];

    var bigTextStyleInformation = BigTextStyleInformation(longdata);

    var androidInit = const AndroidInitializationSettings("mipmap/ic_launcher");
    var darwinInitialization = const DarwinInitializationSettings();
    var initSetting =
        InitializationSettings(android: androidInit, iOS: darwinInitialization);
    fln.initialize(
      initSetting,
      onDidReceiveNotificationResponse: (details) {
        onDidReceiveNotificationResponse(details, callBackEmitMessage);
      },
    );

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      "CHANNEL_ID",
      "CHANEL NAME",
      importance: Importance.high,
      playSound: true,
      sound: const UriAndroidNotificationSound(
          'assets/raw/notification_sound.mp3'),
      styleInformation: bigTextStyleInformation,
      priority: Priority.high,
      actions: [
        const AndroidNotificationAction("ID_MESSAGE", "Trả lời",
            cancelNotification: true,
            inputs: [AndroidNotificationActionInput(label: "Nhập tin nhắn..")],
            showsUserInterface: true,
            titleColor: Colors.amber,
            allowGeneratedReplies: true)
      ],
    );
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails(badgeNumber: 1);
    var noti = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await fln.show(id, icerik["notification"]["title"],
        icerik["notification"]["body"], noti);
  }
}

void onDidReceiveNotificationResponse(NotificationResponse notificationResponse,
    Function(String) callBackEmitMessage) async {
  final String? payload = notificationResponse.payload;
  if (notificationResponse.payload != null) {
    debugPrint('notification payload: ${payload.toString()}');
    debugPrint('notification ID: ${notificationResponse.id}');
    debugPrint('notification Action ID: ${notificationResponse.actionId}');

    if (notificationResponse.input?.isNotEmpty ?? false) {
      callBackEmitMessage(notificationResponse.input ?? "Any error");
      print(
          'notification action tapped with input: ${notificationResponse.input}');
    }
  }
}
