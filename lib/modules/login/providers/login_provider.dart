import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:workin/core/services/firebase_auth_service.dart';

class LoginProvider extends ChangeNotifier {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late bool isRegistered;
  late bool isSuccessful;
  late GlobalKey<FormState> globalKey;
  SnackBar getErrorBar({required Widget content}) {
    return SnackBar(
      content: content,
      duration: Duration(seconds: 3),
      dismissDirection: DismissDirection.down,
    );
  }

  void init() {
    isRegistered = true;
    isSuccessful = true;
    globalKey = GlobalKey();
    _initControllers();
  }

  void toggleRegistrationStatus() {
    isRegistered = !isRegistered;
    notifyListeners();
  }

  void _initControllers() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
  }

  void disposeControllers() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
  }

  Future<void> _register() async {
    try {
      await FirebaseAuthService.signUpViaEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      //await FirestoreService.setCurrentPlayer(
      //  PlayerModel(
      //    name: nameController.text,
      //    bestScore: 0,
      //    totalAnswered: 0,
      //    totalMistakes: 0,
      //    imagePath: "",
      //  ),
      //);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> _login() async {
    try {
      await FirebaseAuthService.signInViaEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //FirebaseAuthService.currentUser = await FirestoreService.getPlayerById(
      // FirebaseAuthService.user?.uid ?? '',
      //);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  Future<void> submitForm(BuildContext context) async {
    if (globalKey.currentState!.validate()) {
      try {
        if (isRegistered) {
          await _login();
        } else {
          await _register();
        }
        //Get.offNamed(AppRouteNames.category);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(getErrorBar(content: Text("An Error Has Occured")));
      }
    }
  }
}
