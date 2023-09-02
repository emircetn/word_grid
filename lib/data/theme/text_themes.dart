import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/extensions/sizer_extensions.dart';

import 'app_colors.dart';

class CustomTextTheme extends TextTheme {
  final BuildContext context;

  const CustomTextTheme(this.context);

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
