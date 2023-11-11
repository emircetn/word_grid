import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/blocs/game/game_bloc.dart';
import 'package:game/configs/app_config.dart';
import 'package:game/configs/game_config.dart';
import 'package:game/constants/grid_constants.dart';
import 'package:game/data/models/drag_payload.dart';
import 'package:game/data/models/grid_options.dart';
import 'package:game/data/theme/app_colors.dart';
import 'package:game/extensions/context_extensions.dart';
import 'package:game/extensions/sizer_extensions.dart';
import 'package:game/presentation/components/custom_icon_button.dart';
import 'package:game/presentation/components/letter_drag.dart';
import 'package:game/presentation/components/letter_grid_view.dart';
import 'package:game/presentation/pages/page_settings.dart';
import 'package:game/utils/dialog_utils.dart';
import 'package:game/utils/router_utils.dart';

class PageGame extends StatefulWidget {
  const PageGame({super.key});
  static const String path = '/game';

  @override
  State<PageGame> createState() => _PageGameState();
}

class _PageGameState extends State<PageGame> {
  GridOptions get gridOptions => GameConfig.gridOptions;

  void onUpdateSelectedIndex(int index) =>
      context.read<GameBloc>().add(GameUpdateSelectedIndexEvent(index));

  void onKeyPressed(DragPayload dragPayload) =>
      context.read<GameBloc>().add(GameKeyPressedEvent(dragPayload));

  void resetTheGame() =>
      context.read<GameBloc>().add(GameStartEvent(GameConfig.gridOptions));

  void settingsTapped() =>
      RouterUtils.navigateTransparent(context, const PageSettings());

  Future<void> onListenGameStates(BuildContext context, GameState state) async {
    if (state is GamePlayState && state.isGameOver) {
      final action = await DialogUtils.showAlertDialog(
        context,
        titleText: 'OYUN BİTTİ',
        okActionText: 'Sıfırla',
        cancelActionText: 'Geri',
      );
      if (action ?? false) resetTheGame();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: buildAppBar(),
      body: BlocConsumer<GameBloc, GameState>(
        listener: onListenGameStates,
        builder: (context, state) {
          if (state is GameLoadingState) {
            return buildLoading();
          } else if (state is GamePlayState) {
            return ListView(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              children: [
                SizedBox(height: 16.sp),
                buildGridView(state),
                SizedBox(height: 32.sp),
                buildKeyboard(state),
                SizedBox(height: 16.sp),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        AppConfig.appName,
        style: context.textTheme.titleM.copyWith(
          color: Colors.white,
        ),
      ),
      actions: [
        CustomIconButton(
          Icons.settings,
          onPressed: settingsTapped,
        ),
      ],
    );
  }

  Center buildLoading() => const Center(child: CupertinoActivityIndicator());

  LetterGridView buildGridView(GamePlayState state) {
    return LetterGridView(
      padding: EdgeInsets.symmetric(horizontal: 16.sp),
      gridMatrix: state.gridMatrix,
      itemTapped: onUpdateSelectedIndex,
      onKeyDragged: onKeyPressed,
      selectedIndex: state.selectedIndex,
      mainAxisCount: gridOptions.xAxisSize,
      crossAxisCount: gridOptions.yAxisSize,
    );
  }

  LetterDrag buildKeyboard(GamePlayState state) {
    return LetterDrag(
      padding: EdgeInsets.symmetric(horizontal: 12.sp),
      onKeyPressed: (letter) => onKeyPressed(
        DragPayload(
          currentIndex: state.selectedIndex,
          letter: letter,
        ),
      ),
      onBackSpacePressed: () => onKeyPressed(
        DragPayload(
          currentIndex: state.selectedIndex,
          letter: GridConstants.emptyCharacter,
        ),
      ),
    );
  }
}
