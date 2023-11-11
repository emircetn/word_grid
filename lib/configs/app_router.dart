import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:game/presentation/pages/page_game.dart';
import 'package:game/presentation/pages/page_settings.dart';

class AppRouter {
  static final router = FluroRouter();

  static void init() {
    router.notFoundHandler =
        Handler(handlerFunc: (_, params) => const SizedBox());

    router
      ..define(
        PageGame.path,
        handler: Handler(handlerFunc: (_, params) => const PageGame()),
      )
      ..define(
        PageSettings.path,
        handler: Handler(handlerFunc: (_, params) => const PageSettings()),
      );
  }
}
