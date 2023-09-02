import 'dart:ui';

import 'package:flutter/material.dart';

class Blur extends StatelessWidget {
  final Widget child;
  final double sigmaX;
  final double sigmaY;

  const Blur({
    super.key,
    required this.child,
    this.sigmaX = 4,
    this.sigmaY = 4,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
      child: child,
    );
  }
}
