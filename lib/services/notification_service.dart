import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationService {
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // Request notification permissions for iOS
  Future<void> requestNotificationPermissions() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  // Initialize FCM
  Future<void> initializeFCM() async {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("onMessage: ${message.notification?.title} ${message.notification?.body}");
      // Handle the message here
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("onMessageOpenedApp: ${message.notification?.title} ${message.notification?.body}");
      // Handle the message here
    });
  }

  // Get FCM token
  Future<String?> getToken() async {
    return await _fcm.getToken();
  }
}
