import 'package:flutter/material.dart';
import 'package:game/constants/grid_constants.dart';
import 'package:game/enums/enums.dart';
import 'package:game/extensions/context_extensions.dart';
import 'package:game/extensions/sizer_extensions.dart';
import 'package:game/data/models/drag_payload.dart';
import 'package:game/data/models/grid.dart';
import 'package:game/data/models/matrix/matrix.dart';

class LetterGridView extends StatelessWidget {
  final Matrix<Grid> gridMatrix;
  final ValueChanged<int> itemTapped;
  final ValueChanged<DragPayload> onKeyDragged;
  final int selectedIndex;
  final int mainAxisCount;
  final int crossAxisCount;
  final EdgeInsets? padding;

  const LetterGridView({
    super.key,
    required this.gridMatrix,
    required this.itemTapped,
    required this.onKeyDragged,
    required this.selectedIndex,
    required this.crossAxisCount,
    required this.mainAxisCount,
    this.padding,
  });

  bool onWillAccept(bool isInactiveItem, int index) {
    if (!isInactiveItem) {
      itemTapped(index);
    }
    return !isInactiveItem;
  }

  void onAccept(bool isInactiveItem, DragPayload payload) {
    if (!isInactiveItem) {
      onKeyDragged(payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: padding,
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 2.sp,
        crossAxisSpacing: 2.sp,
      ),
      itemCount: crossAxisCount * mainAxisCount,
      itemBuilder: (context, index) {
        final x = (index ~/ crossAxisCount);
        final y = index - (x * crossAxisCount);

        final grid = gridMatrix.getValue(x, y);

        final isInactiveItem = grid.status == GridStatus.inactive;

        return DragTarget<DragPayload>(
          onWillAccept: (_) => onWillAccept(isInactiveItem, index),
          onAccept: (payload) => onAccept(isInactiveItem, payload),
          builder: (context, _, __) =>
              buildGridItem(grid, index, isInactiveItem),
        );
      },
    );
  }

  AnimatedContainer buildGridItem(
    Grid grid,
    int index,
    bool isInactiveItem,
  ) {
    final isSelectedItem = selectedIndex == index;

    final border =
        isSelectedItem ? Border.all(width: 3.sp, color: Colors.white) : null;

    void onTap() {
      if (isInactiveItem) return;
      itemTapped(index);
    }

    void onDoubleTap() {
      if (isInactiveItem) return;

      final payload = DragPayload(
        currentIndex: selectedIndex,
        letter: GridConstants.emptyCharacter,
        willReplace: false,
      );
      onKeyDragged(payload);
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(color: grid.status.color, border: border),
      child: Material(
        color: Colors.transparent,
        child: Builder(
          builder: (context) {
            if (isInactiveItem) return const SizedBox();
            return InkWell(
              onTap: onTap,
              onDoubleTap: onDoubleTap,
              child: Center(
                child: Text(
                  grid.letter,
                  style: context.textTheme.titleXL.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
