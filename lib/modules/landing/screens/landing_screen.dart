import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/modules/login/screens/login_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthService.getAuthStream(),
      builder: (c, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: Text("unfinished"));
        } else if (snapshot.hasData) {
          FirebaseAuthService.user = snapshot.data;
          return Center(child: Text("unfinished"));
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
