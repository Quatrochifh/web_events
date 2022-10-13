// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCkYyXi7d5wOhCaffuR1a2gTJWOABCZJC8',
    appId: '1:888563375299:web:6a5e2e907769a449989676',
    messagingSenderId: '888563375299',
    projectId: 'webevent360-9ad0f',
    authDomain: 'webevent360-9ad0f.firebaseapp.com',
    storageBucket: 'webevent360-9ad0f.appspot.com',
    measurementId: 'G-GJ6R6WXBF4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDV8SuIpuOdjuOa3WMdcW6GpSV-pz0pwXw',
    appId: '1:888563375299:android:d18e407d87146c22989676',
    messagingSenderId: '888563375299',
    projectId: 'webevent360-9ad0f',
    storageBucket: 'webevent360-9ad0f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDcFoNSVUu6aKpljhhKy36t1qFmyhyYR8w',
    appId: '1:888563375299:ios:cf79da655d121a5a989676',
    messagingSenderId: '888563375299',
    projectId: 'webevent360-9ad0f',
    storageBucket: 'webevent360-9ad0f.appspot.com',
    iosClientId: '888563375299-c0sq7m43ccpfdnloukoeogjfaf97pi8c.apps.googleusercontent.com',
    iosBundleId: 'com.webevent360.webevent360',
  );
}
