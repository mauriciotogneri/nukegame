import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:nukegame/services/navigation.dart';
import 'package:nukegame/services/platform.dart';
import 'package:url_strategy/url_strategy.dart';

final GetIt getIt = GetIt.instance;

class Initializer {
  static Future load() async {
    WidgetsFlutterBinding.ensureInitialized();

    if (Platform.isWeb) {
      await Firebase.initializeApp(
        options: const FirebaseOptions(
          apiKey: 'AIzaSyBJNztg4PE-RDaE58kZTdSqeUKoXcNQdYM',
          authDomain: 'andstoreapps.firebaseapp.com',
          databaseURL: 'https://andstoreapps.firebaseio.com',
          projectId: 'andstoreapps',
          storageBucket: 'andstoreapps.appspot.com',
          messagingSenderId: '364551387093',
          appId: '1:364551387093:web:212061d62b3b24a36aaf5c',
          measurementId: 'G-K55S4NNH66',
        ),
      );
    } else {
      await Firebase.initializeApp();
    }

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    setPathUrlStrategy();
    getIt.registerSingleton<Navigation>(Navigation());
  }
}
