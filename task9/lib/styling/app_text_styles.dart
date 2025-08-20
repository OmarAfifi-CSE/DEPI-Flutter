import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_fonts.dart';

class AppTextStyles {
  static const TextStyle primaryHeadlineStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subtitlesStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle hintTextStyle = TextStyle(
    color: AppColors.secondaryColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle buttonTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle whiteTextStyle = TextStyle(
    color: AppColors.whiteColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static const TextStyle blackTextStyle = TextStyle(
    color: AppColors.blackColor,
    fontFamily: AppFonts.mainFontName,
    fontSize: 20,
    fontWeight: FontWeight.w500,
  );
}
