import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game/blocs/game/game_bloc.dart';
import 'package:game/configs/app_config.dart';
import 'package:game/configs/app_router.dart';
import 'package:game/configs/game_config.dart';
import 'package:game/constants/size_constants.dart';
import 'package:game/data/theme/app_colors.dart';
import 'package:game/presentation/pages/page_splash.dart';

//Dil desteği
//Tema desteği
//eklenebilir
void main() {
  AppRouter.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameBloc>(
          create: (_) =>
              GameBloc()..add(GameStartEvent(GameConfig.gridOptions)),
        ),
      ],
      child: MaterialApp(
        title: AppConfig.appName,
        theme: ThemeData(
          primarySwatch: AppColors.primaryColor,
        ),
        debugShowCheckedModeBanner: false,
        home: Builder(
          builder: (context) {
            SizeConstants.deviceSize = MediaQuery.of(context).size;
            return const PageSplash();
          },
        ),
      ),
    );
  }
}
