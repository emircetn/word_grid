import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:game/configs/app_router.dart';
import 'package:game/data/services/word_service.dart';
import 'package:game/presentation/pages/page_game.dart';

class PageSplash extends StatefulWidget {
  const PageSplash({super.key});

  @override
  State<PageSplash> createState() => _PageSplashState();
}

class _PageSplashState extends State<PageSplash> {
  final wordServiceInitializeCompleter = Completer();

  @override
  void initState() {
    initWordService();
    checkCompleters();
    super.initState();
  }

  void checkCompleters() {
    Future.wait([wordServiceInitializeCompleter.future])
        .then((value) => navigateToMain());
  }

  void navigateToMain() {
    AppRouter.router.navigateTo(context, PageGame.path, clearStack: true);
  }

  void initWordService() async {
    final result = await WordService.instance.init();
    if (result) {
      wordServiceInitializeCompleter.complete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CupertinoActivityIndicator(),
      ),
    );
  }
}
