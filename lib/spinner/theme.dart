import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SpinnerScope {
  /// 控制可显示内容高度比例，1.0完全占满
  final double scale;

  /// 弹框视图
  final Widget child;

  /// 视图是否包含焦点获取组件
  final bool isMaybeFocus;

  SpinnerScope({
    this.scale = 0.7,
    required this.child,
    this.isMaybeFocus = true,
  });
}

extension SpinnerBoxExt on Widget {
  /// 快速构建 `PopupBtns` builder 数组集
  SpinnerScope height([double scale = 0.7]) {
    return SpinnerScope(child: this, scale: scale);
  }

  /// 显示占据部分高度
  SpinnerScope get heightPart => SpinnerScope(child: this, scale: 0.7);

  /// 显示占满全部空间
  SpinnerScope get heightFull => SpinnerScope(child: this, scale: 1);
}

class SpinnerBoxTheme {
  /// 高度
  final double height;

  // 边距，额外高度
  final EdgeInsets padding;

  /// 默认字体
  final TextStyle style;

  /// 选中后的字体
  final TextStyle selectedStyle;

  /// 背景颜色
  final Color bgColor;

  /// 三角标颜色
  final Color arrowColor;

  /// 标题改变后 是否标记选中状态
  final bool selectedMark;

  // 是否显示边框
  final bool isShowBorder;

  /// 页面其他部位是佛含有焦点获取的组件（如视图顶部搜索输入框）
  final bool outsideFocus;

  const SpinnerBoxTheme({
    this.height = kMinInteractiveDimensionCupertino,
    this.style = const TextStyle(
      color: Color(0xff20263A),
      fontSize: 14,
    ),
    this.selectedStyle = const TextStyle(
      color: Color(0xffE72410),
      fontSize: 14,
    ),
    this.selectedMark = true,
    this.isShowBorder = true,
    this.bgColor = Colors.white,
    this.arrowColor = const Color(0xff9B9EAC),
    this.padding = EdgeInsets.zero,
    this.outsideFocus = false,
  });

  SpinnerBoxTheme copyWith({
    double? height,
    TextStyle? style,
    TextStyle? selectedStyle,
    Color? bgColor,
    Color? arrowColor,
    bool? selectedMark,
    bool? isShowBorder,
    EdgeInsets? padding,
    bool? outsideFocus,
  }) {
    return SpinnerBoxTheme(
      height: height ?? this.height,
      style: style ?? this.style,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      bgColor: bgColor ?? this.bgColor,
      arrowColor: arrowColor ?? this.arrowColor,
      selectedMark: selectedMark ?? this.selectedMark,
      isShowBorder: isShowBorder ?? this.isShowBorder,
      padding: padding ?? this.padding,
      outsideFocus: outsideFocus ?? this.outsideFocus,
    );
  }
}

extension SpinnerThemeExt on SpinnerBoxTheme {
  double get totalHeight => height + padding.top + padding.bottom;
}

/// 默认配置
const SpinnerBoxTheme defaultPinnerTheme = SpinnerBoxTheme();
