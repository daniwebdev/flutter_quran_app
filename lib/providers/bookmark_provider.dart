import 'package:flutter/foundation.dart';
import 'package:flutter_quran_app/models/bookmark_model.dart';

class LastReadProvider with ChangeNotifier, DiagnosticableTreeMixin {
  BookmarkModel _lastRead;

  BookmarkModel get data => _lastRead;

  void setLastRead(BookmarkModel lastRead) {
    this._lastRead = lastRead;
    notifyListeners();
  }

  /// Makes `Counter` readable inside the devtools by listing all of its properties
  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(IntProperty('count', data));
  // }
}