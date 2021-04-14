

import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_quran_app/models/quran_model.dart';

class QuranDB {

  Future<List<QuranSurah>> getSurahName() async {

    String loadAsset = await rootBundle.loadString('assets/db/surah.json');
    var surah = json.decode(loadAsset);

    return surah['RECORDS'].map((e) => QuranSurah.fromJson(Map<String, dynamic>.from(e))).toList().cast<QuranSurah>();
  }

  Future<List<QuranText>> getQuranText() async {

    String loadAsset = await rootBundle.loadString('assets/db/quran_text.json');
    var surah = json.decode(loadAsset);

    return surah['RECORDS'].map((e) => QuranText.fromJson(Map<String, dynamic>.from(e))).toList().cast<QuranText>();
  }

  Future<List<QuranTranslation>> getQuranId() async {

    String loadAsset = await rootBundle.loadString('assets/db/id_indonesian.json');
    var surah = json.decode(loadAsset);

    return surah['RECORDS'].map((e) => QuranTranslation.fromJson(Map<String, dynamic>.from(e))).toList().cast<QuranTranslation>();
  }

}