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
    apiKey: 'AIzaSyCmL8yYcC_IcpmsxaQCn5tFTXiTfNGpk8s',
    appId: '1:799968073066:web:7406736852a014f325c113',
    messagingSenderId: '799968073066',
    projectId: 'mis-183213',
    authDomain: 'mis-183213.firebaseapp.com',
    storageBucket: 'mis-183213.appspot.com',
    measurementId: 'G-L6DZ2LXHCH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyC3NFpwia7yZovvpMviKQdPBDWSc5dvUDs',
    appId: '1:799968073066:android:905c78c620da5de825c113',
    messagingSenderId: '799968073066',
    projectId: 'mis-183213',
    storageBucket: 'mis-183213.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCo2y2Fg_HpTFk6TleOG4At2xSwOszmcJA',
    appId: '1:799968073066:ios:b40febb3922e883c25c113',
    messagingSenderId: '799968073066',
    projectId: 'mis-183213',
    storageBucket: 'mis-183213.appspot.com',
    iosBundleId: 'finki.ukim.mk.lab3',
  );
}
