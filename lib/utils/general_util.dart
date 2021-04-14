import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';

globalAppBar({String title}) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: ColorCustoms.gray),
    backgroundColor: Colors.white,
    title: Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: ColorCustoms.primary,
        ),
      ),
    ),
    actions: [IconButton(icon: Icon(Icons.search), color: ColorCustoms.gray, onPressed: () {})],
  );
}
