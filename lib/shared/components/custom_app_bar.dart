import 'package:flutter/material.dart';
import 'package:workin/shared/resources/app_colors.dart';

AppBar getCustomAppBar({Color color = AppColors.primaryBg}) {
  return AppBar(backgroundColor: color, surfaceTintColor: color, elevation: 0);
}

AppBar getCustomAppBarLocalization({Color color = AppColors.primaryBg}) {
  return AppBar(
    backgroundColor: color,
    surfaceTintColor: color,
    elevation: 0,
    actions: [IconButton(onPressed: () {}, icon: Icon(Icons.translate))],
  );
}
