import 'package:flutter/material.dart';

class Assets {
  static Widget name(
    String name, {
    double width = 16,
    Color? color,
  }) {
    return Image.asset(
      'assets/images/$name.png',
      width: width,
      fit: BoxFit.contain,
      package: 'spinner_box',
      color: color,
    );
  }

  /// header 三角形 icon
  static Widget icArrDown({
    double height = 16,
    Color? color,
  }) {
    return Image.asset(
      'assets/images/ic_arr_down.png',
      height: height,
      fit: BoxFit.contain,
      color: color,
      package: 'spinner_box',
    );
  }

  /// 多选选中
  static Widget icMutiSelected = name('ic_muti_selected');

  /// 多选半选中
  static Widget icMutiSemiSelected = name('ic_muti_semi_selected');

  /// 多选未选中
  static Widget icMutiUnselected = name('ic_muti_unselected');

  /// 单选选中
  static Widget icSingleSelected = name('ic_single_selected');
}
