import 'package:flutter/material.dart';
import 'package:workin/modules/home/components/custom_navbar.dart';
import 'package:workin/shared/resources/app_colors.dart';

class HomeScreenBase extends StatelessWidget {
  const HomeScreenBase({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryBg,
      bottomNavigationBar: CustomNavbar(onTabChange: (idx) {}),
      appBar: getCustomAppBar(),
    );
  }
}
