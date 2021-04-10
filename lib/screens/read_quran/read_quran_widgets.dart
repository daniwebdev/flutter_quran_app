import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/models/quran_model.dart';

class ReadInlineQuranWidget extends StatelessWidget {
  final List<QuranText> data;
  ReadInlineQuranWidget({this.data});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 30),
      child: RichText(
        textAlign: TextAlign.right,
        text: TextSpan(
          text: "",
          style: TextStyle(
            fontFamily: 'FontArab',
            color: ColorCustoms.gray,
            height: 2,
            fontSize: 25,
          ),
          children: List.generate(
            data.length - 1,
            (index) {
              QuranText quran = data[index];
              return TextSpan(
                text: quran.text.replaceAll('بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ', ''),
                children: [
                  TextSpan(
                    text: " (${quran.aya.toString()}) ",
                    style: TextStyle(
                      fontFamily: 'FontAyat',
                      color: ColorCustoms.primary,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

class QuranPerAyatWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 20, top: 20),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: ColorCustoms.gray.withAlpha(50),
          width: 1,
        ),
      )),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: ColorCustoms.primary.withAlpha(50),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  margin: EdgeInsets.only(left: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorCustoms.primary,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.share_outlined,
                            size: 25,
                            color: ColorCustoms.primary,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.play_arrow_outlined,
                            size: 25,
                            color: ColorCustoms.primary,
                          ),
                          onPressed: () {},
                        ),
                        IconButton(
                          padding: EdgeInsets.all(0),
                          icon: Icon(
                            Icons.bookmark_border_outlined,
                            size: 25,
                            color: ColorCustoms.primary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'بِسْمِ ٱللَّهِ ٱلرَّحْمَـٰنِ ٱلرَّحِيمِ',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontFamily: 'FontArab', fontWeight: FontWeight.bold, fontSize: 25),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              'Dolor irure dolore qui culpa dolore cillum.',
              textDirection: TextDirection.ltr,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ),
        ],
      ),
    );
  }
}
