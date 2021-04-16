import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/screens/home/home_screen.dart';
import 'package:flutter_quran_app/utils/navigation_util.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  String jenisKelamin = '';
  TextEditingController namaLengkapController = TextEditingController();

  _initQuran() async {
    Directory path = Directory("/storage/emulated/0/muslim-app/al-quran/per-ayat");

    if (!await path.exists()) {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      if (status.isGranted) {
        await path.create();
        print("Directory dibuat.");
      }
    } else {
      print("Directory sudah ada.");
    }
  }

  onNext() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String nama = prefs.getString('nama_lengkap');
    if (nama != null) XNavigator.pushReplacement(context, to: HomeScreen());
    if (nama == null)
      showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(25.0),
          ),
        ),
        isScrollControlled: true,
        context: context,
        builder: (_) {
          return StatefulBuilder(builder: (
            BuildContext context,
            StateSetter setModalState /*You can rename this!*/,
          ) {
            return Container(
              constraints: BoxConstraints(maxHeight: 280),
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: namaLengkapController,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      hintText: "Siapa Nama Kamu?",
                      hintStyle: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold),
                      filled: true,
                      border: new OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(8.0),
                        ),
                      ),
                      fillColor: ColorCustoms.primary.withAlpha(100),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Radio(
                          value: 'Pria',
                          groupValue: jenisKelamin,
                          onChanged: (jk) {
                            setModalState(() {
                              jenisKelamin = jk;
                            });
                          },
                        ),
                      ),
                      Text('Pria'),
                    ],
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 50,
                        child: Radio(
                          value: 'Wanita',
                          groupValue: jenisKelamin,
                          onChanged: (jk) {
                            setModalState(() {
                              jenisKelamin = jk;
                            });
                          },
                        ),
                      ),
                      Text('Wanita'),
                    ],
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: ColorCustoms.primary),
                      onPressed: () async {
                        prefs.setString('jenis_kelamin', jenisKelamin);
                        prefs.setString('nama_lengkap', namaLengkapController.text);
                        XNavigator.pushReplacement(context, to: HomeScreen());
                      },
                      child: Container(
                        width: 100,
                        child: Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'SELESAI',
                              style: TextStyle(letterSpacing: 2),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      );
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
      backgroundColor: Theme.of(context).backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Qur'an App",
                style: TextStyle(
                  color: Color(0xFF6B59BC),
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
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
                        onTap: this.onNext,
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
      ),
    );
  }
}
