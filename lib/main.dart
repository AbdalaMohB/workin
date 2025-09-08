import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:workin/core/services/hive_service.dart';
import 'package:workin/core/services/network_service.dart';
import 'package:workin/firebase_options.dart';
import 'package:workin/modules/home/providers/employee_provider.dart';
import 'package:workin/modules/home/providers/home_provider.dart';
import 'package:workin/modules/landing/screens/landing_screen.dart';
import 'package:workin/modules/login/providers/login_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.instance.init();
  await NetworkService.instance.checkInternetConnection();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) {
            return LoginProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return HomeProvider();
          },
        ),
        ChangeNotifierProvider(
          create: (context) {
            return EmployeeProvider();
          },
        ),
      ],
      child: MaterialApp(home: LandingScreen()),
    );
  }
}
