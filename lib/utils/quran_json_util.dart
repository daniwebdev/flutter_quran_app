import 'dart:convert';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

class QuranJSON {

  String quranSurahJSON;
  String quranTextJSON;
  String quranTranslateJSON;

  String quranTextURL = 'https://firebasestorage.googleapis.com/v0/b/muslim-app-9c896.appspot.com/o/quran-json%2Fquran_text.json?alt=media&token=aa5071b0-a3c4-4ca0-b644-514e06544dd9';
  String quranSurahURL = 'https://firebasestorage.googleapis.com/v0/b/muslim-app-9c896.appspot.com/o/quran-json%2Fsurah.json?alt=media&token=75893aa0-ac66-4ff0-b0f9-b3ebceff2426';
  String quranTranslateIDURL = 'https://firebasestorage.googleapis.com/v0/b/muslim-app-9c896.appspot.com/o/quran-json%2Fid_indonesian.json?alt=media&token=7cce48b4-f1de-4426-83aa-e5e009e2d0d4';

  init() async {
    io.Directory applicationDirectory = await getApplicationDocumentsDirectory();

    /* Quran Surah */
    String pathQuranSurah = path.join(applicationDirectory.path, "surah.json");
    bool pathQuranSurahExists = await io.File(pathQuranSurah).exists();
    if (!pathQuranSurahExists) {
      await this._saveJSON(this.quranSurahURL, pathQuranSurah);
    }

    /* Quran Text */
    String pathQuranText = path.join(applicationDirectory.path, "surah.json");
    bool pathQuranTextExists = await io.File(pathQuranText).exists();
    if (!pathQuranTextExists) {
      await this._saveJSON(this.quranTextURL, pathQuranText);
    }

    /* Quran QuranTranslate */
    String pathQuranTranslateID = path.join(applicationDirectory.path, "surah.json");
    bool pathQuranTranslateIDExists = await io.File(pathQuranTranslateID).exists();
    if (!pathQuranTranslateIDExists) {
      await this._saveJSON(this.quranTranslateIDURL, pathQuranTranslateID);
    }

    /* GetURL */
    this.quranSurahJSON = pathQuranSurah;
    this.quranTextJSON = pathQuranText;
    this.quranTranslateJSON = pathQuranTranslateID;
  }

  _saveJSON(String url, String target) async {
      var httpClient = new io.HttpClient();
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
        
      if (response.statusCode != 200) throw "Error getting db file";
        
      var bytes = await consolidateHttpClientResponseBytes(response);

      io.File file = new io.File(target);
      await file.writeAsBytes(bytes);
  }

  
  Future<List<QuranSurah>> getSurahName() async {
    io.Directory applicationDirectory = await getApplicationDocumentsDirectory();

    String pathQuranSurah = path.join(applicationDirectory.path, "surah.json");
    io.File file = new io.File(pathQuranSurah);

    Map<String,dynamic> surah = jsonDecode(await file.readAsString());

    return surah['RECORDS'].map((e) => QuranSurah.fromJson(e)).toList().cast<QuranSurah>();
  }
}
