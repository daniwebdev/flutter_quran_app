import 'package:flutter/material.dart';

class XNavigator {
  XNavigator.push(BuildContext context, {Widget to}) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => to),
    );
  }

  XNavigator.pushReplacement(BuildContext context, {Widget to}) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => to),
    );
  }
}
