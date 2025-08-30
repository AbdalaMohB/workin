import 'package:flutter/material.dart';

abstract class SizeService {
  static double getWidthPercentage(
    BuildContext context, {
    double percentage = 1,
  }) {
    return MediaQuery.of(context).size.width * percentage;
  }

  static double getHeightPercentage(
    BuildContext context, {
    double percentage = 1,
  }) {
    return MediaQuery.of(context).size.height * percentage;
  }
}
