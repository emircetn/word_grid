import 'package:flutter/material.dart';
import 'package:game/extensions/sizer_extensions.dart';

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  final double? iconSize;
  final Color? color;

  const CustomIconButton(
    this.icon, {
    super.key,
    required this.onPressed,
    this.iconSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final iconSize_ = iconSize ?? 16.sp;
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        icon,
        size: iconSize_,
        color: color,
      ),
      iconSize: iconSize_,
      splashRadius: iconSize_,
    );
  }
}
