import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intro_proj/services/localization_service.dart';
import 'package:intro_proj/resources/app_colors.dart';

AppBar getCustomAppBar({Color color = AppColors.secondaryBg}) {
  return AppBar(backgroundColor: color, surfaceTintColor: color, elevation: 0);
}

AppBar getCustomAppBarLocalization({Color color = AppColors.secondaryBg}) {
  return AppBar(
    backgroundColor: color,
    surfaceTintColor: color,
    elevation: 0,
    actions: [
      IconButton(
        onPressed: () {
          Get.find<LocalizationService>().toggleLanguage();
        },
        icon: Icon(Icons.translate),
      ),
    ],
  );
}
