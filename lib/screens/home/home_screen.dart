import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/screens/home/home_widgets.dart';
import 'package:flutter_quran_app/utils/general_util.dart';
import 'package:flutter_quran_app/utils/quran_util.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<QuranSurah> _surah = [];

  _getSurah() async {
    var db = new QuranDbHelper();
    await db.init();
    var s = await db.getSurahName();
    setState(() {
      _surah = s;
    });
  }

  @override
  void initState() {
    _getSurah();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: globalAppBar(title: "Al-Quran"),
      body: SingleChildScrollView(
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
                          "Hamdani Ganteng",
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
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Surah Pilihan",
                  style: TextStyle(fontSize: 18, color: ColorCustoms.primary, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                child: Column(
                  children: List.generate(
                    _surah.length,
                    (index) => SurahItemWidget(
                      data: _surah[index],
                    ),
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
