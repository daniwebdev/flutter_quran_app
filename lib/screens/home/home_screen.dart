import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/models/bookmark_model.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/providers/bookmark_provider.dart';
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

  @override
  void initState() {
    super.initState();
    _getSurah();
    _getBookmark();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(title: "Al-Quran"),
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Assalamu'alaikum",
                          style: TextStyle(fontSize: 16, color: ColorCustoms.gray),
                        ),
                        Text(
                          "Nama",
                          style: TextStyle(fontSize: 20, color: ColorCustoms.primary, fontWeight: FontWeight.bold),
                        ),
                      ],
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
              Container(
                height: 130,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    scale: 5,
                    alignment: Alignment.bottomRight,
                    image: AssetImage('assets/images/quran-transparent.png'),
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
                padding: EdgeInsets.all(15),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/last_read.png'),
                          width: 20,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          'Terakhir Baca',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: LastReadWidget(
                        data: context.watch<LastReadProvider>().data,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Pilih Surah",
                  style: TextStyle(fontSize: 18, color: ColorCustoms.primary, fontWeight: FontWeight.bold),
                ),
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

class LastReadWidget extends StatelessWidget {
  final BookmarkModel data;
  LastReadWidget({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            data?.bookmarkedSurahName ?? '...',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          Text(
            data != null ? 'Ayat No: ${data.bookmarkedSurahAyat}' : '',
            style: TextStyle(fontWeight: FontWeight.normal, color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
