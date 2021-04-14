import 'dart:convert';
import 'dart:io' as io;

import 'package:audioplayers/audioplayers.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';

class AudioUtil {
  AudioPlayer _audioPlayer = AudioPlayer();
  String path = '/storage/emulated/0/muslim-app/al-quran';

  playAndSave(url) async {
    String filename = '/per-ayat/' + this._generateMd5(url) + '.dat';
    String pathURL = this.path + filename;

    if (!await io.File(pathURL).exists()) {
      print('download');
      await this._save(url, pathURL);
    }

    int result = await _audioPlayer.playBytes(io.File(pathURL).readAsBytesSync(), volume: 100);

    if (result == 1) {
      print("Play Audio");
    }
  }

  _save(String url, String target) async {
    var httpClient = new io.HttpClient();
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();

    if (response.statusCode != 200) throw "Error getting db file";

    var bytes = await consolidateHttpClientResponseBytes(response);

    io.File file = new io.File(target);
    await file.writeAsBytes(bytes);
  }

  String _generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }
}
