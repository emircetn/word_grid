import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/blocs/game/game_bloc.dart';
import 'package:game/configs/game_config.dart';
import 'package:game/data/theme/app_colors.dart';
import 'package:game/extensions/context_extensions.dart';
import 'package:game/extensions/sizer_extensions.dart';
import 'package:game/data/models/grid_options.dart';
import 'package:game/presentation/components/blur.dart';
import 'package:game/presentation/components/custom_icon_button.dart';
import 'package:delayed_display/delayed_display.dart';

class PageSettings extends StatefulWidget {
  static const String path = "/settings";

  const PageSettings({super.key});

  @override
  State<PageSettings> createState() => _PageSettingsState();
}

class _PageSettingsState extends State<PageSettings> {
  GridOptions get gridOptions => GameConfig.gridOptions;

  @override
  Widget build(BuildContext context) {
    return Blur(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: buildAppBar(),
        body: Container(
          color: AppColors.backgroundColor.withOpacity(0.7),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.sp),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.sp),
                buildHeader(title: "GAME"),
                SizedBox(height: 8.sp),
                buildGameOption(
                  title: "MAIN AXIS COUNT",
                  count: gridOptions.xAxisSize,
                  onIncrease: () => GameConfig.gridOptions.xAxisSize++,
                  onDecrease: () => GameConfig.gridOptions.xAxisSize--,
                ),
                buildGameOption(
                  title: "CROSS AXIS COUNT",
                  count: gridOptions.yAxisSize,
                  onIncrease: () => GameConfig.gridOptions.yAxisSize++,
                  onDecrease: () => GameConfig.gridOptions.yAxisSize--,
                ),
                buildGameOption(
                  title: "INACTIVE INDEX COUNT",
                  count: gridOptions.inactiveItemCount,
                  onIncrease: () => GameConfig.gridOptions.inactiveItemCount++,
                  onDecrease: () => GameConfig.gridOptions.inactiveItemCount--,
                ),
                SizedBox(height: 16.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text(
        "SETTINGS",
        style: context.textTheme.titleM.copyWith(color: Colors.white),
      ),
    );
  }

  Text buildHeader({required String title}) {
    return Text(
      title,
      style: context.textTheme.titleL,
    );
  }

  DelayedDisplay buildGameOption({
    required String title,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
    required int count,
    Color? backgroundColor,
  }) {
    void decreaseTapped() {
      if (count > 1) {
        onDecrease();
        context.read<GameBloc>().add(GameStartEvent(GameConfig.gridOptions));
        setState(() {});
      }
    }

    void increaseTapped() {
      onIncrease();
      context.read<GameBloc>().add(GameStartEvent(GameConfig.gridOptions));
      setState(() {});
    }

    return DelayedDisplay(
      child: Container(
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.only(left: 16.sp),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.titleS,
                ),
              ),
              SizedBox(width: 16.sp),
              CustomIconButton(
                Icons.remove,
                onPressed: decreaseTapped,
              ),
              Text(
                "$count",
                style: context.textTheme.titleM,
              ),
              CustomIconButton(
                Icons.add,
                color: AppColors.labelColor,
                onPressed: increaseTapped,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
