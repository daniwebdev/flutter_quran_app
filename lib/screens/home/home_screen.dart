import 'package:flutter/material.dart';
import 'package:flutter_quran_app/models/bookmark_model.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/providers/bookmark_provider.dart';
import 'package:flutter_quran_app/providers/darkmode_provider.dart';
import 'package:flutter_quran_app/screens/home/home_widgets.dart';
import 'package:flutter_quran_app/utils/general_util.dart';
import 'package:flutter_quran_app/utils/quran_asset_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QuranSurah> _surah = [];
  List<QuranText> _quranText = [];
  List<QuranTranslation> _quranId = [];

  String namaLengkap;

  _getSurah() async {
    var quranDB = new QuranDB();

    List<QuranSurah> result = await quranDB.getSurahName();

    setState(() {
      _surah = result;
    });

    List<QuranText> quranText = await quranDB.getQuranText();
    List<QuranTranslation> quranId = await quranDB.getQuranId();

    setState(() {
      _quranText = quranText;
      _quranId = quranId;
    });
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

  _getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      this.namaLengkap = prefs.getString('nama_lengkap');
    });
  }

  onThemeChange() async {
    ThemeMode _currentMode = context.watch<ThemeProvider>().mode;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (_currentMode == ThemeMode.dark) {
      prefs.setString('themeMode', 'light');
      context.read<ThemeProvider>().setMode(ThemeMode.light);
    } else {
      prefs.setString('themeMode', 'dark');
      context.read<ThemeProvider>().setMode(ThemeMode.dark);
    }
  }

  @override
  void initState() {
    super.initState();
    _getName();
    _getSurah();
    _getBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: globalAppBar(
        context,
        title: "Al-Quran",
        icon: (context.watch<ThemeProvider>().mode == ThemeMode.dark) ? Icons.wb_sunny : Icons.wb_sunny_outlined,
        onThemeChange: this.onThemeChange,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  /* Greeting */
                  Expanded(
                    child: HeaderGreetingNameWidget(
                      name: this.namaLengkap,
                    ),
                  ),
                  /* End Greeting */
                  /* Avatar */
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.contain,
                        image: NetworkImage('https://www.pngkey.com/png/full/114-1149878_setting-user-avatar-in-specific-size-without-breaking.png'),
                      ),
                    ),
                  ),
                  /* End Avatar */
                ],
              ),
              /* Home Header Widget */
              HomeHeaderWidget(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text("Pilih Surah", style: Theme.of(context).textTheme.headline5),
              ),
              Container(
                child: Column(
                  children: List.generate(
                    _surah.length,
                    (index) {
                      QuranSurah surah = _surah[index];

                      List<QuranText> quranText = this._quranText.where((q) => q.sura == surah.index).toList();

                      List<QuranTranslation> quranTranslate = this._quranId.where((q) => q.sura == surah.index).toList();

                      return SurahItemWidget(
                        data: surah,
                        quranText: quranText,
                        quranTranslate: quranTranslate,
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
