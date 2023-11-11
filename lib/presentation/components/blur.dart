import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  const Blur({
    required this.child,
    super.key,
    this.sigmaX = 4,
    this.sigmaY = 4,
  });
  final Widget child;
  final double sigmaX;
  final double sigmaY;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: child,
    );
  }
}
