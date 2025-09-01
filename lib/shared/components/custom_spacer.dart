import 'package:flutter/material.dart';

Widget customSpacer({double? verticalSpace, double? horizontalSpace}) {
  return Padding(
    padding: EdgeInsets.symmetric(
      vertical: (verticalSpace ?? 0) / 2,
      horizontal: (horizontalSpace ?? 0) / 2,
    ),
  );
}
