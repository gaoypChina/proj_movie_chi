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
    apiKey: 'AIzaSyCKYP0eLsi7HJPrXx_zOdBXiQ6QpYenoE8',
    appId: '1:628256163112:web:43fe7ef60696e8f23bbc1d',
    messagingSenderId: '628256163112',
    projectId: 'movi-chi',
    authDomain: 'movi-chi.firebaseapp.com',
    storageBucket: 'movi-chi.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDxqhNIkBpmBUFOZh5WH0qB75zcY6Q2uL0',
    appId: '1:628256163112:android:9614086d6a106af83bbc1d',
    messagingSenderId: '628256163112',
    projectId: 'movi-chi',
    storageBucket: 'movi-chi.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANyNhBChI2r679AxNMJXRynwyieAcvTsM',
    appId: '1:628256163112:ios:2d57c357385c844a3bbc1d',
    messagingSenderId: '628256163112',
    projectId: 'movi-chi',
    storageBucket: 'movi-chi.appspot.com',
    androidClientId: '628256163112-1bvkadjk9ru9jj30b5g029f65n7qq9c3.apps.googleusercontent.com',
    iosClientId: '628256163112-dj6qgv0pdd9na1kkrkrbthnhidqqdb8b.apps.googleusercontent.com',
    iosBundleId: 'com.arianadeveloper.world.movie',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyANyNhBChI2r679AxNMJXRynwyieAcvTsM',
    appId: '1:628256163112:ios:2d57c357385c844a3bbc1d',
    messagingSenderId: '628256163112',
    projectId: 'movi-chi',
    storageBucket: 'movi-chi.appspot.com',
    androidClientId: '628256163112-1bvkadjk9ru9jj30b5g029f65n7qq9c3.apps.googleusercontent.com',
    iosClientId: '628256163112-dj6qgv0pdd9na1kkrkrbthnhidqqdb8b.apps.googleusercontent.com',
    iosBundleId: 'com.arianadeveloper.world.movie',
  );
}
