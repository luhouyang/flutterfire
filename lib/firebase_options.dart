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
    apiKey: 'AIzaSyAsHDhG0-GRjD9fAwLfEi_fBusdzQB0zeE',
    appId: '1:449311767233:web:cc41da286b5185dbeb3240',
    messagingSenderId: '449311767233',
    projectId: 'note-2o24',
    authDomain: 'note-2o24.firebaseapp.com',
    storageBucket: 'note-2o24.appspot.com',
    measurementId: 'G-CKGL9NZ25N',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCaU71nHYFX-s9-OM_COzDjKp4X0Gm76sE',
    appId: '1:449311767233:android:cbe0bc98f158d4f6eb3240',
    messagingSenderId: '449311767233',
    projectId: 'note-2o24',
    storageBucket: 'note-2o24.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB2x9tVm1TVeCSGdaT79yUA26qv1DrBNGY',
    appId: '1:449311767233:ios:39b047c1c66d3a37eb3240',
    messagingSenderId: '449311767233',
    projectId: 'note-2o24',
    storageBucket: 'note-2o24.appspot.com',
    iosBundleId: 'com.example.note',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB2x9tVm1TVeCSGdaT79yUA26qv1DrBNGY',
    appId: '1:449311767233:ios:39b047c1c66d3a37eb3240',
    messagingSenderId: '449311767233',
    projectId: 'note-2o24',
    storageBucket: 'note-2o24.appspot.com',
    iosBundleId: 'com.example.note',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAsHDhG0-GRjD9fAwLfEi_fBusdzQB0zeE',
    appId: '1:449311767233:web:a44758ca86e329fbeb3240',
    messagingSenderId: '449311767233',
    projectId: 'note-2o24',
    authDomain: 'note-2o24.firebaseapp.com',
    storageBucket: 'note-2o24.appspot.com',
    measurementId: 'G-FH2FX142SL',
  );

}