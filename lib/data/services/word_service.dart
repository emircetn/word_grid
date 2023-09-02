import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:game/constants/asset_constants.dart';

class WordService {
  static WordService? _instance;
  static WordService get instance {
    _instance ??= WordService._init();
    return _instance!;
  }

  WordService._init();
  List<String> allWords = [];

  Future<bool> init() async {
    try {
      final String strWordList =
          await rootBundle.loadString(AssetConstants.wordsTr);
      final lines = LineSplitter.split(strWordList).toList();
      allWords.addAll(lines);
      return true;
    } catch (e) {
      debugPrint("ERROR! WordServices/init $e");
      return false;
    }
  }
}
