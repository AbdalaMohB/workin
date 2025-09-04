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
    BottomNavigationBarItem(label: 'Job Posts', icon: Icon(Icons.work)),
    BottomNavigationBarItem(label: 'Tasks', icon: Icon(Icons.task)),
    BottomNavigationBarItem(label: 'Employees', icon: Icon(Icons.person)),
  ];

  int currentIdx = 0;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(splashColor: Colors.white24),
      child: BottomNavigationBar(
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
      ),
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
