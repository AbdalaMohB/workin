import 'package:flutter/material.dart';
import 'package:workin/core/services/firebase_auth_service.dart';
import 'package:workin/modules/home/components/avatar.dart';
import 'package:workin/shared/resources/app_colors.dart';

class CustomNavbar extends StatefulWidget {
  final void Function(int idx) onTabChange;

  const CustomNavbar({super.key, required this.onTabChange});

  @override
  State<StatefulWidget> createState() {
    return _CustomNavbarState();
  }
}

class _CustomNavbarState extends State<CustomNavbar> {
  final List<BottomNavigationBarItem> _items = const [
    BottomNavigationBarItem(label: '', icon: Icon(Icons.home)),
    BottomNavigationBarItem(label: '', icon: Icon(Icons.task)),
  ];

  int currentIdx = 0;
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: _items,
      currentIndex: currentIdx,
      backgroundColor: AppColors.primaryBg,
      selectedItemColor: AppColors.primaryFg,
      unselectedItemColor: AppColors.secondaryFg,
      onTap: (idx) {
        setState(() {
          currentIdx = idx;
          widget.onTabChange(idx);
        });
      },
    );
  }
}

AppBar getCustomAppBar() {
  return AppBar(
    leading: InkWell(
      splashColor: AppColors.secondaryFg,
      onTap: () {
        FirebaseAuthService.signOut();
      },
      child: getAvatar(),
    ),
    backgroundColor: AppColors.primaryBg,
  );
}
