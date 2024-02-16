import 'package:complete/page_1.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'auth_gate.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Directionality(
        textDirection: TextDirection
            .ltr, // Adjust this according to your app's text direction
        child: ChangeNotifierProvider(
          create: (context) =>
              ActivityProvider(), // Provide an instance of ActivityProvider
          child: const AuthGate(),
        ),
      ),
    );
  }
}
