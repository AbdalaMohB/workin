import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:workin/shared/resources/app_colors.dart';

abstract class AppTextStyles {
  static final normal = GoogleFonts.roboto(
    textStyle: TextStyle(color: AppColors.secondaryFg, fontSize: 16),
  );
  static final highlighted = GoogleFonts.roboto(
    textStyle: TextStyle(color: AppColors.primaryFg, fontSize: 16),
  );

  static const header = TextStyle(color: AppColors.primaryFg, fontSize: 28);
  static const headerNoHighlight = TextStyle(
    color: AppColors.secondaryFg,
    fontSize: 28,
  );
}
