import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/data/theme/app_colors.dart';
import 'package:game/extensions/sizer_extensions.dart';

class CustomTextTheme extends TextTheme {
  const CustomTextTheme(this.context);
  final BuildContext context;

  TextStyle get titleS =>
      CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 10.sp,
            letterSpacing: 2,
            color: AppColors.labelColor,
          );

  TextStyle get titleM =>
      CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 12.sp,
            letterSpacing: 3,
            color: AppColors.labelColor,
          );

  TextStyle get titleL =>
      CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 18.sp,
            letterSpacing: 3,
            color: AppColors.labelColor,
          );

  TextStyle get titleXL =>
      CupertinoTheme.of(context).textTheme.textStyle.copyWith(
            fontSize: 24.sp,
            letterSpacing: 3,
            color: AppColors.labelColor,
          );
}
