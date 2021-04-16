import 'package:flutter/material.dart';
import 'package:flutter_quran_app/colors.dart';
import 'package:flutter_quran_app/providers/darkmode_provider.dart';

globalAppBar(BuildContext context, {String title, IconData icon, Function onThemeChange}) {
  return AppBar(
    elevation: 0,
    iconTheme: IconThemeData(color: ColorCustoms.gray),
    title: Padding(
      padding: const EdgeInsets.only(left: 5),
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColorLight,
        ),
      ),
    ),
    actions: [
      IconButton(
        icon: Icon(icon),
        color: ColorCustoms.gray,
        onPressed: onThemeChange,
      ),
    ],
  );
}
