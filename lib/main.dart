import 'package:complete/activity_provider.dart';
import 'package:complete/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app.dart';

//(codelab user): Get API key
const clientId =
    '1043694505574-i265jt3v2mb7kpujv74ig13f8d297v6j.apps.googleusercontent.com';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Obtain an instance of ActivityProvider
  ActivityProvider activityProvider = ActivityProvider();

  //Fetch activities only once during app startup
  await activityProvider.fetchActivities();

  runApp(
    ChangeNotifierProvider.value(
      value: activityProvider,
      child: const MyApp(),
    ),
  );
}
