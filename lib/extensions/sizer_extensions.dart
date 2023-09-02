import 'dart:math';
import 'package:game/constants/size_constants.dart';

extension SizerExt on num {
  double get _scaleWidth =>
      SizeConstants.deviceSize.width / SizeConstants.designSize.width;
  double get _scaleHeight =>
      SizeConstants.deviceSize.height / SizeConstants.designSize.height;

  double get sp => this * min(_scaleWidth, _scaleHeight);

  double get scaleHeight => this * _scaleHeight;
}
