import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/screens/read_quran/read_quran_screen.dart';
import 'package:flutter_quran_app/utils/navigation_util.dart';

class SurahItemWidget extends StatelessWidget {
  final QuranSurah data;
  SurahItemWidget({this.data});
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
            to: ReadQuranScreen(
              surah: data,
            ),
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
                    image: CachedNetworkImageProvider(
                        'https://www.kindpng.com/picc/m/174-1743291_floral-pattern-border-png-bintang-segi-delapan-png.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Text(
                  data.index.toString(),
                  style: TextStyle(fontSize: 18, fontFamily: 'FontAyat'),
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
                    Text(data.artinya + " · ${data.ayat} Ayat"),
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
