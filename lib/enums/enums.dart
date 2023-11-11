import 'package:flutter/material.dart';
import 'package:game/data/theme/app_colors.dart';

enum GridStatus {
  valid(color: AppColors.gridValidColor),
  invalid(color: AppColors.gridInvalidColor),
  pending(color: AppColors.gridPendingColor),
  empty(color: AppColors.gridEmptyColor),
  inactive(color: AppColors.gridInactiveColor);

  const GridStatus({
    required this.color,
  });

  GridStatus compare(GridStatus secondStatus) {
    if (this == GridStatus.valid && secondStatus == GridStatus.valid) {
      return GridStatus.valid;
    } else if (this == GridStatus.invalid ||
        secondStatus == GridStatus.invalid) {
      return GridStatus.invalid;
    } else if ((this == GridStatus.empty || secondStatus == GridStatus.empty) &&
        this != secondStatus) {
      return GridStatus.pending;
    } else if (this == GridStatus.empty || secondStatus == GridStatus.empty) {
      return GridStatus.empty;
    }
    return GridStatus.inactive;
  }

  final Color color;
}
