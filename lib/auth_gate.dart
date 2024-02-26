import 'package:complete/activity_provider.dart';
import 'package:firebase_auth/firebase_auth.dart' hide EmailAuthProvider;
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'home.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(
            providers: [
              //Main thing
              EmailAuthProvider(),
              //GoogleProvider(clientId:"1043694505574-i265jt3v2mb7kpujv74ig13f8d297v6j
              //.apps.googleusercontent.com"),
            ],
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('assets/flutterfire_300x.png'),
                ),
              );
            },
            //Subtitle Builder
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: action == AuthAction.signIn
                    ? const Text('Welcome to FlutterFire, Please sign in!')
                    : const Text('Welcome to FlutterFire, Please sign up!'),
              );
            },
            // Footer Builder
            footerBuilder: (context, action) {
              return const Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text(
                  'By signing in, you agree to our terms and conditions.',
                  style: TextStyle(color: Colors.grey),
                ),
              );
            },
            //Side Builder
            sideBuilder: (context, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(20),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset('flutterfire_300x.png'),
                ),
              );
            },
            //SignIn Screen
          );
        }

        // Clear activities when a new user logs in
        Provider.of<ActivityProvider>(context, listen: false).clearActivity();

        return const HomeScreen();
      },
    );
  }
}

/*
StreamBuilder.stream is being passed FirebaseAuth.instance.authStateChanged, 
the aforementioned stream, which will return a Firebase User object 
if the user has authenticated. (Otherwise it will return null.)

Next, the code is using snapshot.hasData to check if the value from the 
stream contains the User object.

If there isn't, it'll return a SignInScreen widget. 
Currently, that screen won't do anything. This will be updated in the next step.

Otherwise, it returns a HomeScreen, which is the main part of the application 
that only authenticated users can access.

The SignInScreen is a widget that comes from the FlutterFire UI package. 
This will be the focus of the next step of this codelab. When you run the app 
at this point, you should see a blank sign-in screen.
 */