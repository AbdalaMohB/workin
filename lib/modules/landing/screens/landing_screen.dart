import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/core/services/network_service.dart';
import 'package:workin/modules/home/screens/home_screen_base.dart';
import 'package:workin/modules/login/screens/login_screen.dart';
import 'package:workin/modules/offline/screens/offline_screen.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuthService.getAuthStream(),
      builder: (c, snapshot) {
        if (!NetworkService.instance.isConnected) {
          return OfflineScreen();
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          FirebaseAuthService.user = snapshot.data;
          return HomeScreenBase();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
