import 'package:flutter/material.dart';
import 'package:game/data/theme/text_themes.dart';

extension ContextDeviceExtensions on BuildContext {
  CustomTextTheme get textTheme => CustomTextTheme(this);

  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;
}
