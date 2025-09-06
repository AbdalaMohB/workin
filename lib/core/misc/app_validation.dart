import 'package:get/get.dart';

abstract class AppValidation {
  static String? validateEmail(String? email) {
    if (email == null || email.trim().isEmpty) {
      return "Email Field is Required";
    }
    RegExp regExp = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    bool matches = regExp.hasMatch(email);
    if (!matches) {
      return "Invalid Email";
    }
    return null;
  }

  static String? validatePassword(String? pass) {
    if (pass == null || pass.trim().isEmpty) {
      return "Password Field is Required";
    }
    if (pass.trim().length < 8) {
      return "Password is too Short";
    }
    return null;
  }

  static String? validateUsername(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "User Name is Required";
    }
    return null;
  }

  static String? validateDesc(String? name) {
    if (name != null && name.trim().length < 8) {
      return "Description too short";
    }
    return null;
  }

  static String? validateJobName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Job Title is Required";
    }
    return null;
  }

  static String? validateCompanyName(String? name) {
    if (name == null || name.trim().isEmpty) {
      return "Company Name is Required";
    }
    return null;
  }

  static String? validateNumber(String? number) {
    RegExp regExp = RegExp("^[0-9]*\$");
    bool matches = regExp.hasMatch(number ?? "");
    if (!matches) {
      return "Please Enter a Valid Number";
    }
    if (number == null || number.trim().isEmpty) {
      return "Please Provide a Number";
    }
    return null;
  }
}
