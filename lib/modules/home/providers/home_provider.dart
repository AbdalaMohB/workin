import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/core/services/firestore_service.dart';

class HomeProvider extends ChangeNotifier {
  late int currentTab;
  late bool isLoading;

  Future<void> _getUser() async {
    FirebaseAuthService.currentUser = await FirestoreService.getUserById(
      FirebaseAuthService.user?.uid ?? "",
    );
  }

  Future<void> init() async {
    currentTab = 0;
    isLoading = true;
    await Future.wait([_getUser()]);
    isLoading = false;
    notifyListeners();
  }

  void onTabChange(int newTab) {
    currentTab = newTab;
    notifyListeners();
  }
}
