import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/screens/home/home_screen.dart';
import 'package:flutter_quran_app/utils/navigation_util.dart';
import 'package:permission_handler/permission_handler.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  _initQuran() async {
   Directory path= Directory("/storage/emulated/0/muslim-app/al-quran/per-ayat");

    if(!await path.exists()) {

      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if(status.isGranted) {
        await path.create();
        print("Directory dibuat.");
      }
    } else {
      print("Directory sudah ada.");
    }
    
  }

  @override
  void initState() {
    super.initState();
    _initQuran();
  }

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
              "Qur'an App",
              style: TextStyle(
                color: Color(0xFF6B59BC),
                fontWeight: FontWeight.w700,
                fontSize: 28,
                fontFamily: 'Poppins',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                "\"Bacalah Al-Qur'an. Sebab, ia akan datang memberikan syafaat pada hari Kiamat kepada pemilik (pembaca, pengamal)-nya.\"\n(HR. Ahmad)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF8789A3),
                  fontSize: 16,
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
                      image: DecorationImage(fit: BoxFit.contain, image: AssetImage('assets/images/quran-splash.png')),
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
                          color: ColorCustoms.warning,
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          "Baca Al-Quran",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
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
