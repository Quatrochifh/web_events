import 'package:app_settings/app_settings.dart';
import 'package:appweb3603/component_functions.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:permission_handler/permission_handler.dart';

class Permissions {

  static Future<dynamic> fcheckNotificationPermission() async {
    dynamic fireInstance = FirebaseMessaging.instance;
    NotificationSettings settings = await fireInstance.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      return true;
    }
    return false;
  }

  static dynamic checkGalleryPermission() async {
    dynamic photosPermission = await Permission.photos.status.isGranted;
    dynamic cameraPermission = await Permission.camera.status.isGranted;
    dynamic mediaLibraryPermission = await Permission.mediaLibrary.isGranted;
    return photosPermission || cameraPermission || mediaLibraryPermission;
  }

  static dynamic checkNotificationPermission() async {
    dynamic permission = await Permission.notification.status.isGranted;
    return permission;
  }

  static dynamic checkContactPermission() async {
    dynamic permission = await Permission.contacts.status.isGranted;
    return permission;
  }

  static dynamic requestContactPermission() async {
    return await Permission.contacts.request().then((results) {
      if (!results.isGranted) {
        showAlert(
          title: "Habilitar o acesso total aos seus Contatos",
          callback: () {
            Future.delayed(Duration(
              seconds: 1
            ), () {
              Permissions.openAppSettings();
              hideAlert();
            });
          },
          icon: null,
          successTitle: "Abrir Conf.",
          cancelTitle: "Cancelar",
          cancelCallback: () {
            hideAlert();
          }
        );
      }
      return results;
    });
  }

  static dynamic requestNotificationPermission() async {
    return await Permission.notification.request().then((results) {
      if (!results.isGranted) {
        showAlert(
          title: "Habilitar Notificações",
          callback: () {
            Future.delayed(Duration(
              seconds: 1
            ), () {
              Permissions.openAppSettings();
              hideAlert();
            });
          },
          icon: null,
          successTitle: "Abrir Conf.",
          cancelTitle: "Cancelar",
          cancelCallback: () {
            hideAlert();
          }
        );
      }
      return results;
    });
  }

  static dynamic requestGalleryPermission() async {
    return await Permission.photos.request().then((results) {
      if (!results.isGranted) {
        showAlert(
          title: "Habilitar o acesso total à Fotos e Galeria",
          callback: () {
            Future.delayed(Duration(
              seconds: 1
            ), () {
              Permissions.openAppSettings();
              hideAlert();
            });
          },
          icon: null,
          successTitle: "Abrir Conf.",
          cancelTitle: "Cancelar",
          cancelCallback: () {
            hideAlert();
          }
        );
      }
      return results;
    });
  }

  static void openAppSettings() {
    AppSettings.openAppSettings();
  }

}