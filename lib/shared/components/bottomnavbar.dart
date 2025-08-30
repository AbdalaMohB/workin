import 'package:flutter/material.dart';

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      // onTap: (it) {
      //  setState(() {
      //  widget.selectedItem = it;
      //});
      //},
      onTap: widget.onTap,
      currentIndex: widget.selectedItem,
      unselectedItemColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
      backgroundColor: Color(0xff24252A),
      type: BottomNavigationBarType.fixed,
      items: widget.items,
    );
  }
}

class BottomNavBar extends StatefulWidget {
  BottomNavBar({
    required this.items,
    required this.onTap,
    this.selectedItem = 0,
    super.key,
  });
  int selectedItem;
  Function(int it) onTap;
  final List<BottomNavigationBarItem> items;
  @override
  State<StatefulWidget> createState() {
    return _BottomNavBarState();
  }
}
