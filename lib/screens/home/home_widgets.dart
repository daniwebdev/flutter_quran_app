import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran_app/models/bookmark_model.dart';
import 'package:flutter_quran_app/models/quran_model.dart';
import 'package:flutter_quran_app/providers/bookmark_provider.dart';
import 'package:flutter_quran_app/screens/read_quran/read_quran_screen.dart';
import 'package:flutter_quran_app/utils/navigation_util.dart';
import 'package:provider/provider.dart';

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
    TextTheme _textTheme = Theme.of(context).textTheme;

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
                  style: _textTheme.headline3,
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
                      style: _textTheme.headline1,
                    ),
                    Text(
                      data.tempatTurun + " · ${data.ayat} Ayat",
                      style: _textTheme.headline2,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: EdgeInsets.only(right: ([].indexOf(data.index) > -1 ? 10 : 0)),
                    child: Text(data.arab.trim(), textAlign: TextAlign.right, style: _textTheme.headline4),
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

/* Header Username */
class HeaderGreetingNameWidget extends StatelessWidget {
  final String name;
  HeaderGreetingNameWidget({this.name});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Assalamu'alaikum", style: Theme.of(context).textTheme.headline2),
        Text(
          this.name ?? '',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColorLight,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

//-----------------------------------------------------
/* Home Header */
//-----------------------------------------------------
class HomeHeaderWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
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
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 16),
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
