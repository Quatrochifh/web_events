import 'package:appweb3603/firebase_options.dart';
import 'package:appweb3603/objects/object_notification.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:appweb3603/entities/Notification.dart' as notification_entity;
import 'package:flutter/material.dart';

class OBFirebase {
  late OBNotification _obNotification;

  late dynamic _context;

  late String? _firebaseToken;

  OBFirebase({dynamic context}) {
    this._context = context;
    this._obNotification = OBNotification();
    this._firebaseToken = "";
  }

  /*
   * Notificações do Firebase
  */
  Future<void> setUpFirebaseNotifications() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform, //This line is necessary
    );

    dynamic fireInstance = FirebaseMessaging.instance;

    NotificationSettings settings = await fireInstance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    this._firebaseToken = await FirebaseMessaging.instance.getToken();

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission. Token: ${this._firebaseToken}');
    }

    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      notificationReceived(initialMessage);
    } else {
      return;
    }

    FirebaseMessaging.onMessage.listen(notificationReceived);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(notificationReceived);
  }

  /*
   * Handles das notificações do Firebase
  */
  Future<void> handleMessage(RemoteMessage message) async {
    String title = "", description = "";

    String route =
        message.data.containsKey('route') ? message.data['route'] : '';
    String routeValue = message.data.containsKey('routeValue')
        ? message.data['routeValue']
        : '';

    if (message.notification != null) {
      description = message.notification!.body!;
      title = message.notification!.title!;
    }

    notification_entity.Notification notification =
        new notification_entity.Notification(
            title: title,
            description: description,
            routeName: route,
            routeValue: routeValue);
    _obNotification.handleMessage(notification, _context);
  }

  /*
   * Notificações recebidas
  */
  Future<void> notificationReceived(RemoteMessage message) async {
    String title = "", description = "";

    String route =
        message.data.containsKey('route') ? message.data['route'] : '';
    String routeValue = message.data.containsKey('routeValue')
        ? message.data['routeValue']
        : '';

    if (message.notification != null) {
      description =
          message.notification!.body == null ? "" : message.notification!.body!;
      title = message.notification!.title!;
    }

    notification_entity.Notification notification =
        new notification_entity.Notification(
            title: title,
            description: description,
            routeName: route,
            routeValue: routeValue);

    debugPrint("Notificação recebida: $route");

    _obNotification.displayNotification(notification);
  }

  String? get firebaseToken => this._firebaseToken;
}
