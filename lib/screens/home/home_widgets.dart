import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/screens/read_quran/read_quran_screen.dart';
import 'package:flutter_quran_app/utils/navigation_util.dart';

class SurahItemWidget extends StatelessWidget {
  final QuranSurah data;
  final List<QuranText> quranText;
  final List<QuranTranslation> quranTranslate;


  SurahItemWidget({
    this.data,
    this.quranText,
    this.quranTranslate,
  });
  @override
  Widget build(BuildContext context) {
    /* SurahItem */
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        highlightColor: Colors.white,
        onTap: () {
          XNavigator.push(
            context,
            to: ReadQuranScreen(surah: data, quranText: this.quranText, quranTranslate: this.quranTranslate),
          );
        },
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(border: Border(bottom: BorderSide(width: .1))),
          child: Row(
            children: [
              /* No Surah */
              Container(
                width: 40,
                height: 40,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/ayat.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  data.index.toString(),
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    // fontFamily: 'FontAyat',
                  ),
                ),
              ),
              /* End - No Surah */
              /* Nama Surah (Latin) */
              Container(
                padding: EdgeInsets.only(left: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.namaSurah,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(data.tempatTurun + " · ${data.ayat} Ayat"),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: ([].indexOf(data.index) > -1 ? 10 : 0)),
                    child: Text(
                      data.arab.trim(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                        fontFamily: 'FontArab',
                        fontSize: 20,
                      ),
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
