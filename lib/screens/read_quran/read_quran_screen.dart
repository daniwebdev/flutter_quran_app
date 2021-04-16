import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/models/bookmark_model.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/providers/bookmark_provider.dart';
import 'package:flutter_quran_app/providers/player_provider.dart';
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

class _ReadQuranScreenState extends State<ReadQuranScreen> with TickerProviderStateMixin {
  QuranSurah surah;
  List<QuranText> quranText;
  List<QuranTranslation> quranTranslate;

  _ReadQuranScreenState(this.surah, this.quranText, this.quranTranslate);
  AudioPlayer audioPlayer = AudioPlayer();
  AnimationController _colorAnimationController;
  Animation _headerColor;

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

  AudioUtil audio = new AudioUtil();

  _play(int surahIndex, int surahAya) async {
    this.audio.audioPlayer.stop();

    String surah = surahIndex.toString().padLeft(3, '0');
    String aya = surahAya.toString().padLeft(3, '0');
    String url = "http://www.everyayah.com/data/Abdullah_Basfar_32kbps/${surah}${aya}.mp3";

    await audio.playAndSave(url);

    this.audio.audioPlayer.onPlayerCompletion.listen((event) {
      context.read<PlayerProvider>().setPlayer(null);
    });
    this.audio.audioPlayer.onPlayerCommand.listen((event) {
      context.read<PlayerProvider>().setPlayer(null);
    });
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(scrollInfo.metrics.pixels / 50);

      return true;
    }

    return false;
  }

  @override
  void initState() {
    _colorAnimationController = AnimationController(vsync: this, duration: Duration(seconds: 0));
    _headerColor = ColorTween(begin: Color(0x00FFFFFF), end: ColorCustoms.primary).animate(_colorAnimationController);

    super.initState();
    this._getBookmark();
  }

  @override
  void dispose() {
    this.audio.audioPlayer.stop();
    this.audio.audioPlayer.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    BookmarkModel lastRead = context.watch<LastReadProvider>().data;
    QuranText player = context.watch<PlayerProvider>().data;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(color: ColorCustoms.gray),
        title: AnimatedBuilder(
          animation: _colorAnimationController,
          builder: (context, child) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  surah.namaSurah,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: _headerColor.value,
                  ),
                ),
                Text(
                  surah.artinya,
                  style: TextStyle(
                    fontSize: 15,
                    height: 1,
                    color: _headerColor.value,
                  ),
                ),
              ],
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.download_rounded),
            color: ColorCustoms.gray,
            iconSize: 30,
            onPressed: () {},
          ),
        ],
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: NotificationListener<ScrollNotification>(
        onNotification: _scrollListener,
        child: SingleChildScrollView(
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
                      bool _isPlaying = player != null && (player.aya == qText.aya && player.sura == qText.sura);

                      return QuranPerAyatWidget(
                        data: qText,
                        isBookmarked: _isBookmarked,
                        isPlayingAya: _isPlaying,
                        transalte: this.quranTranslate[index],
                        onPlay: (QuranText data) {
                          context.read<PlayerProvider>().setPlayer(data);

                          if (!_isPlaying) this._play(data.sura, data.aya);
                          if (_isPlaying) {
                            this.audio.audioPlayer.stop();
                            context.read<PlayerProvider>().setPlayer(null);
                          }
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
      ),
    );
  }
}
