import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Text styles for the whole application.
class TextStyles {
  TextStyles._();

  static const TextStyle textStyleBold = TextStyle(
    fontWeight: FontWeight.w600
  );

  static const TextStyle textStyle20PrimaryBlack = TextStyle(
    fontSize: 20.0,
    height: 1.6,
    color: AppColors.primaryBlackColor
  );

  static const TextStyle textStyle18PrimaryBlack = TextStyle(
    fontSize: 18.0,
    color: AppColors.primaryBlackColor,
    height: 1.5
  );

  static const TextStyle textStyle16 = TextStyle(
    fontSize: 16.0
  );

  static const TextStyle textStyle16PrimaryBlack = TextStyle(
    color: AppColors.primaryBlackColor,
    fontSize: 16.0,
    height: 1.5
  );

  static const TextStyle textStyle16PrimaryBlackBold = TextStyle(
    fontSize: 16.0,
    color: AppColors.primaryBlackColor,
    fontWeight: FontWeight.w600,
    height: 1.5
  );

  static const TextStyle textStyle16SecondaryBlackBold = TextStyle(
    fontSize: 16.0,
    color: AppColors.secondaryBlackColor,
    fontWeight: FontWeight.w600
  );

  static const TextStyle textStyle16PrimaryGrey = TextStyle(
    fontSize: 16.0,
    color: AppColors.primaryGreyColor
  );

  static const TextStyle textStyle14SecondaryGrey = TextStyle(
    fontSize: 14.0,
    color: AppColors.secondaryGreyColor
  );

  static const TextStyle textStyle14PrimaryBlack = TextStyle(
    fontSize: 14.0,
    letterSpacing: 0.23,
    color: AppColors.primaryBlackColor
  );

  static const TextStyle textStyle14PrimaryWhite = TextStyle(
    fontSize: 14.0,
    color: Colors.white,
    height: 1.57
  );

  static const TextStyle textStyle12SecondaryBlack = TextStyle(
    fontSize: 12.0,
    color: AppColors.secondaryBlackColor,
  );

  static const TextStyle textStyle11PrimaryBlack = TextStyle(
    fontSize: 11.0,
    color: AppColors.primaryBlackColor
  );


  static const TextStyle textStyle10PrimaryRed = TextStyle(
    fontSize: 10.0,
    color: AppColors.primaryRedColor,
    height: 1.33
  );
}

