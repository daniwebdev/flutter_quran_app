import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/screens/read_quran/read_quran_widgets.dart';
import 'package:flutter_quran_app/utils/general_util.dart';
import 'package:flutter_quran_app/utils/quran_util.dart';

class ReadQuranScreen extends StatefulWidget {
  final QuranSurah surah;

  ReadQuranScreen({this.surah});
  @override
  _ReadQuranScreenState createState() => _ReadQuranScreenState(this.surah);
}

class _ReadQuranScreenState extends State<ReadQuranScreen> {
  QuranSurah surah;
  _ReadQuranScreenState(this.surah);

  List<QuranText> _quranText = [];

  _getQuranText() async {
    var db = new QuranDbHelper();

    await db.init();
    List<QuranText> qT = await db.getSurahByIndex(surah.index);

    setState(() {
      _quranText = qT;
    });
  }

  @override
  void initState() {
    super.initState();
    _getQuranText();
  }

  @override
  Widget build(BuildContext context) {
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
                      child: Text(
                        'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 25,
                          fontFamily: 'FontArab',
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              /* End Header */
              /* Read Quran */
              // ReadInlineQuranWidget(
              //   data: _quranText,
              // ),
              Container(
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    /* Per Ayat */
                    QuranPerAyatWidget(),
                    QuranPerAyatWidget(),
                    QuranPerAyatWidget(),
                    QuranPerAyatWidget(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
