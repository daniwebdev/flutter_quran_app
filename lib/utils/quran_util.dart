// import 'package:flutter/services.dart';
// import 'package:flutter_quran_app/models/quran_model.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:io' as io;
// import 'package:path/path.dart' as path;

// class QuranDBSQL {
//   Database _db;
//   Future<void> init() async {
//     io.Directory applicationDirectory = await getApplicationDocumentsDirectory();

//     String dbPathEnglish = path.join(applicationDirectory.path, "quran.db");

//     bool dbExistsEnglish = await io.File(dbPathEnglish).exists();

//     if (!dbExistsEnglish) {
//       // Copy from asset
//       ByteData data = await rootBundle.load(path.join("assets", "db", "quran.db"));
//       List<int> bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

//       // Write and flush the bytes written
//       await io.File(dbPathEnglish).writeAsBytes(bytes, flush: true);
//     }

//     this._db = await openDatabase(dbPathEnglish);
//   }

//   Future<List<QuranSurah>> getSurahName() async {
//     if (_db == null) {
//       throw "bd is not initiated, initiate using [init(db)] function";
//     }
//     List<Map> surah;

//     await _db.transaction((txn) async {
//       surah = await txn.query(
//         "surah",
//         columns: [
//           "index",
//           "nama_surah",
//           "arab",
//           "artinya",
//           "ayat",
//           "tempat_turun",
//           "urutan_pewahyuan",
//         ],
//       );
//     });

//     return surah.map((e) => QuranSurah.fromJson(e)).toList();
//   }

//   Future<List<QuranText>> getSurahByIndex(int suraIndex) async {
//     if (_db == null) {
//       throw "bd is not initiated, initiate using [init(db)] function";
//     }
//     List<Map> surah;

//     await _db.transaction((txn) async {
//       surah = await txn.query(
//         "quran_text",
//         columns: [
//           "index",
//           "sura",
//           "aya",
//           "text",
//         ],
//         where: 'sura = ?',
//         whereArgs: [suraIndex]
//       );
//     });

//     return surah.map((e) => QuranText.fromJson(e)).toList();
//   }
// }


