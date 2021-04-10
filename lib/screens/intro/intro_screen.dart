import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/screens/home/home_screen.dart';
import 'package:flutter_quran_app/utils/navigation_util.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size _s = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Al-Quran",
              style: TextStyle(color: Color(0xFF6B59BC), fontSize: 50, fontFamily: 'QuickSand'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "Bacalah Al-Qur'an. Sebab, ia akan datang memberikan syafaat pada hari Kiamat kepada pemilik (pembaca, pengamal)-nya. (HR. Ahmad)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorCustoms.gray,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Stack(
                children: [
                  Container(
                    height: _s.height * .65,
                    width: _s.width - 40,
                    margin: EdgeInsets.only(bottom: 25),
                    decoration: BoxDecoration(
                      color: Color(0xFF6B59BC),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Positioned(
                    bottom: 5,
                    left: _s.width * .2,
                    child: GestureDetector(
                      onTap: () {
                        XNavigator.pushReplacement(context, to: HomeScreen());
                      },
                      child: Container(
                        width: _s.width * .5,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xFFF9B090),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Baca Al-Quran",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
