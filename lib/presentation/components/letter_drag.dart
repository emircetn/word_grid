import 'package:flutter/material.dart';
import 'package:game/data/models/drag_payload.dart';
import 'package:game/data/theme/app_colors.dart';
import 'package:game/extensions/sizer_extensions.dart';

class LetterDrag extends StatelessWidget {
  LetterDrag({
    required this.onKeyPressed,
    required this.onBackSpacePressed,
    super.key,
    this.padding = EdgeInsets.zero,
  });
  final ValueChanged<String> onKeyPressed;
  final VoidCallback onBackSpacePressed;
  final EdgeInsets padding;

  final List<List<String>> keyboardRows = [
    ['E', 'A', 'Ö', 'I', 'İ', 'O', 'Ü'],
    ['C', 'V', 'B', 'N', 'M', 'Ç', 'S'],
    ['D', 'F', 'G', 'H', 'J', 'K', 'Ş'],
    ['R', 'T', 'Y', 'U', 'P', 'Z', 'L'],
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: keyboardRows.map(
          (row) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 4.sp),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.sp),
                child: Row(
                  children: [
                    ...row.map(
                      (letter) {
                        return Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 4.sp),
                            child: KeyButton(
                              letter: letter,
                              onPressed: onKeyPressed,
                            ),
                          ),
                        );
                      },
                    ),
                    if (keyboardRows.indexOf(row) == keyboardRows.length - 1)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.sp),
                        child: InkWell(
                          onTap: onBackSpacePressed,
                          child: Padding(
                            padding: EdgeInsets.all(8.sp),
                            child: Icon(
                              Icons.backspace,
                              size: 16.sp,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}

class KeyButton extends StatelessWidget {
  const KeyButton({required this.letter, required this.onPressed, super.key});
  final String letter;
  final ValueChanged<String> onPressed;

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: CircleAvatar(child: this),
      data: DragPayload(letter: letter),
      childWhenDragging: Container(),
      child: GestureDetector(
        onTap: () => onPressed(letter),
        child: Container(
          color: Colors.grey.shade100,
          padding: EdgeInsets.all(8.sp),
          child: Center(
            child: Text(
              letter,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.labelColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
