import 'package:complete/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'app.dart';

// TODO(codelab user): Get API key
const clientId =
    '1043694505574-i265jt3v2mb7kpujv74ig13f8d297v6j.apps.googleusercontent.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

/*
This code does two things.

WidgetsFlutterBinding.ensureInitialized() tells Flutter not to start running 
the application widget code until the Flutter framework is completely booted. 
Firebase uses native platform channels, which require the framework to be 
running.

Firebase.initializeApp sets up a connection between your Flutter app and 
your Firebase project. The DefaultFirebaseOptions.currentPlatform is imported 
from our generated firebase_options.dart file. This static value detects which 
platform you're running on, and passes in the corresponding Firebase keys.
*/