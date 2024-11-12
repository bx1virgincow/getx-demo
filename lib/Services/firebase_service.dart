import 'dart:developer';

import 'package:demo/core/data/shared_pref.dart';
import 'package:demo/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
  final _firebaseMessaging = FirebaseMessaging.instance;

  //init notification
  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    final fcmToken = await _firebaseMessaging.getToken();

    log('fcmtoken: $fcmToken');
    //save to shared preference
    await SharedPref.saveFCMToken(fcmToken ?? '');
    initPushNotification();
  }

  //handle notification click
  void handleNotification(RemoteMessage? message) {
    if (message == null) return;

    //navigate to notification screen
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  //function to initialize background settings
  Future initPushNotification() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    //handle notification
    FirebaseMessaging.instance.getInitialMessage().then(handleNotification);
    //attach event listener for when
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);

    //background handler
    // FirebaseMessaging.onBackgroundMessage(h)
  }
}
