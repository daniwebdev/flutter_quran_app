import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/providers/bookmark_provider.dart';
import 'package:flutter_quran_app/providers/darkmode_provider.dart';
import 'package:flutter_quran_app/providers/player_provider.dart';
import 'package:flutter_quran_app/screens/intro/intro_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LastReadProvider()),
        ChangeNotifierProvider(create: (_) => PlayerProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _primary = MaterialColor(
    ColorCustoms.primary.value,
    <int, Color>{
      50: Color(0xFFEDE6F7),
      100: Color(0xFFD1C0EB),
      200: Color(0xFFB396DE),
      300: Color(0xFF956BD0),
      400: Color(0xFF7E4CC6),
      500: Color(ColorCustoms.primary.value),
      600: Color(0xFF5F27B6),
      700: Color(0xFF5421AD),
      800: Color(0xFF4A1BA5),
      900: Color(0xFF391097),
    },
  );
  @override
  void initState() {
    super.initState();
    context.read<ThemeProvider>().getCurrentMode();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Qur\'an App',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: _primary,
        primaryColorLight: _primary,
        textTheme: TextTheme(
            bodyText1: const TextStyle(color: Color(0xFF240F4F)),
            /* Arab Quran */
            bodyText2: const TextStyle(color: Color(0xFF240F4F), fontSize: 16),
            /* Transalate Quran */
            headline1: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
            headline2: const TextStyle(fontSize: 14, color: Color(0xFF8789A3)),
            /* List Quran total Ayat */
            headline3: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
            headline4: const TextStyle(fontFamily: 'FontArab', fontSize: 20, color: Colors.black),
            headline5: TextStyle(fontSize: 18, color: _primary, fontWeight: FontWeight.bold)),
        appBarTheme: AppBarTheme(backgroundColor: Color(0xFFFFFFFF)),
        backgroundColor: Colors.white,
      ),
      themeMode: context.watch<ThemeProvider>().mode,
      darkTheme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: _primary,
        disabledColor: Colors.white38,
        primaryColorLight: Colors.white,
        textTheme: const TextTheme(
            bodyText1: const TextStyle(color: Color(0xFFFFFFFF)),
            bodyText2: const TextStyle(color: Color(0xFFABAFD7)),
            headline1: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
            /* List Quran total Ayat */
            headline2: const TextStyle(fontSize: 14, color: Color(0xFF8789A3)),
            headline3: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
            headline4: const TextStyle(fontFamily: 'FontArab', fontSize: 20, color: Colors.white),
            headline5: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)),
        appBarTheme: const AppBarTheme(
          backgroundColor: const Color(0xFF042030),
        ),
        backgroundColor: const Color(0xFF042030),
      ),
      home: IntroScreen(),
    );
  }
}
