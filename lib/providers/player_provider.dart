import 'package:flutter/foundation.dart';
import 'package:flutter_quran_app/models/quran_model.dart';

class PlayerProvider with ChangeNotifier, DiagnosticableTreeMixin {
  QuranText _data;

  QuranText get data => _data;

  void setPlayer(QuranText quranText) {
    this._data= quranText;
    notifyListeners();
  }

}