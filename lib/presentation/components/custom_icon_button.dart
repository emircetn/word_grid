import 'package:flutter/material.dart';
import 'package:game/extensions/sizer_extensions.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
    this.icon, {
    required this.onPressed,
    super.key,
    this.iconSize,
    this.color,
  });
  final IconData icon;
  final VoidCallback onPressed;
  final double? iconSize;
  final Color? color;

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
