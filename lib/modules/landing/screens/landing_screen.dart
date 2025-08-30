import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthService.getAuthStream(),
      builder: (c, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SplashScreen();
        } else if (snapshot.hasData) {
          FirebaseAuthService.user = snapshot.data;
          return CategoryScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
