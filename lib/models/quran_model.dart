class QuranText {
  int index;
  int sura;
  int aya;
  String text;

  QuranText.fromJson(Map<String, dynamic> json) {
    this.index = json['index'];
    this.sura = json['sura'];
    this.aya = json['aya'];
    this.text = json['text'];
  }
}

class QuranTranslation {
  int index;
  int sura;
  int aya;
  String text;

  QuranTranslation.fromJson(Map<String, dynamic> json) {
    this.index = json['index'];
    this.sura = json['sura'];
    this.aya = json['aya'];
    this.text = json['text'];
  }
}

class QuranSurah {
  int index;
  String namaSurah;
  String arab;
  String artinya;
  int ayat;
  String tempatTurun;
  int urutanPewahyuan;

  QuranSurah.fromJson(Map<String, dynamic> json) {
    this.index = json['index'];
    this.namaSurah = json['nama_surah'];
    this.arab = json['arab'];
    this.artinya = json['artinya'];
    this.ayat = json['ayat'];
    this.tempatTurun = json['tempat_turun'];
    this.urutanPewahyuan = json['urutan_pewahyuan'];
  }
}
