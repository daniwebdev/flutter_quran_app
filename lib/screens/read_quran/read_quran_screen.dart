import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_app/models/bookmark_model.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/providers/bookmark_provider.dart';
import 'package:flutter_quran_app/screens/read_quran/read_quran_widgets.dart';
import 'package:flutter_quran_app/utils/audio_util.dart';
import 'package:flutter_quran_app/utils/general_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

class ReadQuranScreen extends StatefulWidget {
  final QuranSurah surah;
  final List<QuranText> quranText;
  final List<QuranTranslation> quranTranslate;

  ReadQuranScreen({this.surah, this.quranText, this.quranTranslate});
  @override
  _ReadQuranScreenState createState() => _ReadQuranScreenState(this.surah, this.quranText, this.quranTranslate);
}

class _ReadQuranScreenState extends State<ReadQuranScreen> {
  QuranSurah surah;
  List<QuranText> quranText;
  List<QuranTranslation> quranTranslate;

  _ReadQuranScreenState(this.surah, this.quranText, this.quranTranslate);

  _setBookmark({
    int bookmarkSurahIndex,
    String bookmarkedSurahName,
    int bookmarkedSurahAyat,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('bookmarkSurahIndex', bookmarkSurahIndex);
    prefs.setString('bookmarkedSurahName', bookmarkedSurahName);
    prefs.setInt('bookmarkedSurahAyat', bookmarkedSurahAyat);

    context.read<LastReadProvider>().setLastRead(
          BookmarkModel(
            bookmarkSurahIndex: prefs.getInt('bookmarkSurahIndex') ?? 0,
            bookmarkedSurahAyat: prefs.getInt('bookmarkedSurahAyat') ?? 0,
            bookmarkedSurahName: prefs.getString('bookmarkedSurahName') ?? '...',
          ),
        );
    Toast.show(
      "Terakhir baca di perbarui.",
      context,
      duration: Toast.LENGTH_LONG,
      gravity: Toast.BOTTOM,
    );
  }

  _getBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    context.read<LastReadProvider>().setLastRead(
          BookmarkModel(
            bookmarkSurahIndex: prefs.getInt('bookmarkSurahIndex') ?? 0,
            bookmarkedSurahAyat: prefs.getInt('bookmarkedSurahAyat') ?? 0,
            bookmarkedSurahName: prefs.getString('bookmarkedSurahName') ?? '...',
          ),
        );
  }

  _play(int surahIndex, int surahAya) async {
    String surah = surahIndex.toString().padLeft(3, '0');
    String aya = surahAya.toString().padLeft(3, '0');
    String url = "http://www.everyayah.com/data/Abdullah_Basfar_32kbps/${surah}${aya}.mp3";

    AudioUtil audio = new AudioUtil();
    await audio.playAndSave(url);
  }

  @override
  void initState() {
    super.initState();

    this._getBookmark();
  }

  @override
  Widget build(BuildContext context) {
    BookmarkModel lastRead = context.watch<LastReadProvider>().data;

    return Scaffold(
      appBar: globalAppBar(title: surah.namaSurah),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              /* Header */
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.symmetric(vertical: 30),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    alignment: Alignment.bottomRight,
                    scale: 3,
                    colorFilter: new ColorFilter.mode(Color.fromRGBO(255, 255, 255, 0.2), BlendMode.modulate),
                    image: AssetImage(
                      'assets/images/quran-transparent.png',
                    ),
                  ),
                  borderRadius: BorderRadius.circular(15),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFC07CEB),
                      Color(0xFF7B5BDC),
                    ],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Column(
                  children: [
                    Text(
                      surah.namaSurah,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      surah.artinya,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Divider(
                        height: 30,
                        thickness: 1,
                        color: Colors.white54,
                      ),
                    ),
                    RichText(
                      text: TextSpan(
                        text: surah.tempatTurun.toUpperCase(),
                        style: TextStyle(letterSpacing: 3, fontSize: 14, fontWeight: FontWeight.bold),
                        children: [
                          TextSpan(text: " - "),
                          TextSpan(text: surah.ayat.toString() + " AYAT"),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 30),
                      child: Image(
                        width: 250,
                        image: AssetImage('assets/images/bissmillah.png'),
                      ),
                    ),
                  ],
                ),
              ),
              /* End Header */

              /* Read Quran */
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: List.generate(this.quranText.length, (index) {
                    QuranText qText = this.quranText[index];
                    bool _isBookmarked = (lastRead.bookmarkSurahIndex == qText.sura && lastRead.bookmarkedSurahAyat == qText.aya);
                    return QuranPerAyatWidget(
                      data: qText,
                      isBookmarked: _isBookmarked,
                      transalte: this.quranTranslate[index],
                      onPlay: (QuranText data) {
                        this._play(data.sura, data.aya);
                      },
                      onBookmark: (QuranText data) {
                        if (!_isBookmarked) {
                          this._setBookmark(
                            bookmarkSurahIndex: data.sura,
                            bookmarkedSurahAyat: data.aya,
                            bookmarkedSurahName: this.surah.namaSurah,
                          );
                        }
                      },
                    );
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
