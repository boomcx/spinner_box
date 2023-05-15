
import 'package:flutter/material.dart';

class Assets {
  static Widget name(String name, {double width = 16}) {
    return Image.asset(
      'assets/images/$name.png',
      width: width,
      fit: BoxFit.contain,
      package: 'spinner_box',
    );
  }
}
