import 'package:flutter/material.dart';
import 'package:game/data/theme/app_colors.dart';
import 'package:game/extensions/sizer_extensions.dart';
import 'package:game/data/models/drag_payload.dart';

class LetterDrag extends StatelessWidget {
  final ValueChanged<String> onKeyPressed;
  final VoidCallback onBackSpacePressed;
  final EdgeInsets padding;

  final List<List<String>> keyboardRows = [
    ['E', 'A', 'Ö', 'I', 'İ', 'O', 'Ü'],
    ['C', 'V', 'B', 'N', 'M', 'Ç', 'S'],
    ['D', 'F', 'G', 'H', 'J', 'K', 'Ş'],
    ['R', 'T', 'Y', 'U', 'P', 'Z', 'L'],
  ];

  LetterDrag({
    super.key,
    required this.onKeyPressed,
    required this.onBackSpacePressed,
    this.padding = EdgeInsets.zero,
  });

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
                    ).toList(),
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
                      )
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
  final String letter;
  final Function(String) onPressed;

  const KeyButton({super.key, required this.letter, required this.onPressed});

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
