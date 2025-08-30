import 'package:flutter/material.dart';

Widget expandedHorizontal({
  required Widget child,
  MainAxisAlignment verticalAlignment = MainAxisAlignment.start,
  EdgeInsets padding = EdgeInsets.zero,
}) {
  return Column(
    mainAxisAlignment: verticalAlignment,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [Padding(padding: padding, child: child)],
  );
}

Widget expandedVertical({
  required Widget child,
  MainAxisAlignment horizontalAlignment = MainAxisAlignment.start,
  EdgeInsets padding = EdgeInsets.zero,
}) {
  return Row(
    mainAxisAlignment: horizontalAlignment,
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [Padding(padding: padding, child: child)],
  );
}
