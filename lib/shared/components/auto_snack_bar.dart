import 'package:flutter/material.dart';
import 'package:workin/shared/resources/app_colors.dart';
import 'package:workin/shared/resources/app_text_styles.dart';

abstract class AutoSnackBar {
  static SnackBar _getSnackBar(String content) {
    return SnackBar(
      backgroundColor: AppColors.trietaryBg,
      content: Text(content, style: AppTextStyles.normal),
    );
  }

  static void showSnackBar(BuildContext context, String content) {
    SnackBar bar = _getSnackBar(content);
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }
}
