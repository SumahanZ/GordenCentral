// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyD6ik1-Vrcg7QnRkq2dFA_vLVzwttFuYMw',
    appId: '1:1037521507097:web:cef05100781224340deb88',
    messagingSenderId: '1037521507097',
    projectId: 'tugasakhirskripsi-pn',
    authDomain: 'tugasakhirskripsi-pn.firebaseapp.com',
    storageBucket: 'tugasakhirskripsi-pn.appspot.com',
    measurementId: 'G-BFVH1X3SQJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDv4i0RI4cmmgc03zXL2bAPgMuOjPOAbKs',
    appId: '1:1037521507097:android:4fb450be05aa16130deb88',
    messagingSenderId: '1037521507097',
    projectId: 'tugasakhirskripsi-pn',
    storageBucket: 'tugasakhirskripsi-pn.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAatDWq-wE3Mqr35LVzblYfFvTxw6J6tVM',
    appId: '1:1037521507097:ios:2be39e29351c88410deb88',
    messagingSenderId: '1037521507097',
    projectId: 'tugasakhirskripsi-pn',
    storageBucket: 'tugasakhirskripsi-pn.appspot.com',
    iosBundleId: 'com.example.tugasAkhirProject',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAatDWq-wE3Mqr35LVzblYfFvTxw6J6tVM',
    appId: '1:1037521507097:ios:2be39e29351c88410deb88',
    messagingSenderId: '1037521507097',
    projectId: 'tugasakhirskripsi-pn',
    storageBucket: 'tugasakhirskripsi-pn.appspot.com',
    iosBundleId: 'com.example.tugasAkhirProject',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD6ik1-Vrcg7QnRkq2dFA_vLVzwttFuYMw',
    appId: '1:1037521507097:web:7b3348c10d9b10890deb88',
    messagingSenderId: '1037521507097',
    projectId: 'tugasakhirskripsi-pn',
    authDomain: 'tugasakhirskripsi-pn.firebaseapp.com',
    storageBucket: 'tugasakhirskripsi-pn.appspot.com',
    measurementId: 'G-ND8MTMZQVK',
  );
}