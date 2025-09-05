import 'package:flutter/material.dart';

Widget unfinishedMessage(String identifier) {
  return Center(
    child: Text(
      "$identifier is Unfinished",
      style: TextStyle(color: Colors.red),
    ),
  );
}
