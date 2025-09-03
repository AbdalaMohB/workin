import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/core/services/firestore_service.dart';
import 'package:workin/models/developer_model.dart';
import 'package:workin/models/owner_model.dart';
import 'package:workin/models/user_model.dart';

class LoginProvider extends ChangeNotifier {
  late TextEditingController emailController;
  late TextEditingController nameController;
  late TextEditingController passwordController;
  late TextEditingController rate;
  late TextEditingController yearsOfExperience;
  late TextEditingController job;
  late TextEditingController cv;
  late TextEditingController companyName;
  late bool isPartTime;
  late bool isOwner;
  late GlobalKey<FormState> globalKey;
  late int currentRegistrationStep;
  SnackBar getErrorBar({required Widget content}) {
    return SnackBar(
      content: content,
      duration: Duration(seconds: 3),
      dismissDirection: DismissDirection.down,
    );
  }

  void init() {
    globalKey = GlobalKey();
    isOwner = false;
    currentRegistrationStep = 0;
    _initControllers();
  }

  void ownerCheck(bool? checked) {
    isOwner = checked ?? false;
    notifyListeners();
  }

  void _initControllers() {
    emailController = TextEditingController();
    nameController = TextEditingController();
    passwordController = TextEditingController();
    rate = TextEditingController();
    cv = TextEditingController();
    job = TextEditingController();
    yearsOfExperience = TextEditingController();
    companyName = TextEditingController();
  }

  void disposeControllers() {
    emailController.dispose();
    nameController.dispose();
    passwordController.dispose();
    rate.dispose();
    cv.dispose();
    job.dispose();
    yearsOfExperience.dispose();
    companyName.dispose();
  }

  void toNextRegistrationStep(BuildContext context) {
    currentRegistrationStep = 1;
    Navigator.pop(context);
    notifyListeners();
  }

  Future<void> register(BuildContext context) async {
    if (formIsValid()) {
      try {
        Navigator.pop(context);
        await FirebaseAuthService.signUpViaEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );

        UserModel user;
        if (isOwner) {
          user = OwnerModel(
            companyName: companyName.text,
            name: nameController.text,
          );
        } else {
          if (isPartTime) {
            user = DeveloperModel.partTime(
              name: nameController.text,
              job: job.text,
              yearsOfExperience: int.parse(yearsOfExperience.text),
              hourlyRate: int.parse(rate.text),
            );
          } else {
            user = DeveloperModel(
              name: nameController.text,
              yearsOfExperience: int.parse(yearsOfExperience.text),
              job: job.text,
              monthlyRate: int.parse(rate.text),
              cv: cv.text,
            );
          }
        }

        await FirestoreService.setCurrentUser(user);
        if (isOwner) {
          await FirestoreService.createManagerProfile();
        }
      } catch (e) {
        rethrow;
      }
    }
  }

  Future<void> login() async {
    if (formIsValid()) {
      try {
        await FirebaseAuthService.signInViaEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        FirebaseAuthService.currentUser = await FirestoreService.getUserById(
          FirebaseAuthService.user?.uid ?? '',
        );
      } catch (e) {
        rethrow;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    disposeControllers();
  }

  bool formIsValid() {
    return globalKey.currentState!.validate();
  }

  Future<void> submitForm(BuildContext context) async {
    if (globalKey.currentState!.validate()) {
      try {
        //Get.offNamed(AppRouteNames.category);
      } catch (e) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(getErrorBar(content: Text("An Error Has Occured")));
      }
    }
  }
}
