// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// 重定义为0的宽度，方便阅读
// ignore: constant_identifier_names
const double AutoLength = 0;

/// `SpinnerBox`中 `builder` 中所需要的参数，
/// 控制单个筛选内容弹框的一些显示配置
class SpinnerPopScope {
  /// 控制可显示内容高度比例，1.0完全占满
  final double scale;

  /// 指定弹框内容的宽度，默认屏幕宽度
  /// `0/AutoLength` 跟随顶部导航一致
  /// `double.infinity` 屏幕宽度
  /// `0 < width < screen.width` 给定固定宽度
  final double width;

  /// 弹框视图偏移量，默认不偏移
  /// 弹框视图与导航按钮两者`position.x`的偏移量
  final double offsetX;

  /// 弹框视图
  final Widget child;

  /// 视图是否包含焦点获取组件，解决弹框内部焦点与页面焦点冲突
  /// 默认为 `true`
  final bool isMaybeFocus;

  SpinnerPopScope({
    required this.child,
    this.scale = 0.7,
    this.width = AutoLength,
    this.offsetX = 0,
    this.isMaybeFocus = true,
  });
}

/// 增加扩展，方式来快速构建
extension SpinnerPopScopeExt on Widget {
  /// 快速构建 `PopupBtns` builder 数组集
  SpinnerPopScope height([double scale = 0.7]) {
    return SpinnerPopScope(child: this, scale: scale);
  }

  /// 显示占据部分高度
  SpinnerPopScope get heightPart => SpinnerPopScope(child: this, scale: 0.7);

  /// 显示占满全部空间
  SpinnerPopScope get heightFull => SpinnerPopScope(child: this, scale: 1);
}

/// 弹框视图的基本显示配置，如果完全自定义显示内容（非`SpinnerEntity`常规配置）
class SpinnerHeaderTheme {
  /// 组件按钮高度
  final double height;

  // header边距，额外高度
  final EdgeInsets padding;

  /// 默认字体
  final TextStyle style;

  /// 选中后的字体
  final TextStyle selectedStyle;

  /// 背景颜色
  final Color bgColor;

  /// 三角标颜色
  final Color arrowColor;

  /// 标题改变后 是否标记选中状态（切换字体颜色）
  final bool selectedMark;

  // 是否显示边框
  final bool isShowBorder;

  /// 页面其他部位是否含有焦点获取的组件（例如 页面顶部搜索输入框）
  final bool outsideFocus;

  /// 之前样式太过固定
  /// 以下针对`SpinnerHeader`的`item`配置
  /// 标题icon的大小，默认25
  /// 如果是自定义输入图片，折限制为高度显示
  final double iconSize;

  /// icon的位置，默认居右
  final TextDirection? textDirection;

  /// 标题和icon之间的距离，默认4
  final EdgeInsets iconPading;

  /// 是否开启旋转动画
  final bool isIconAnimate;

  const SpinnerHeaderTheme({
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
    this.iconSize = 25,
    this.iconPading = const EdgeInsets.symmetric(horizontal: 4),
    this.textDirection,
    this.isIconAnimate = true,
  });

  SpinnerHeaderTheme copyWith({
    double? height,
    EdgeInsets? padding,
    TextStyle? style,
    TextStyle? selectedStyle,
    Color? bgColor,
    Color? arrowColor,
    bool? selectedMark,
    bool? isShowBorder,
    bool? outsideFocus,
    double? iconSize,
    TextDirection? textDirection,
    EdgeInsets? iconPading,
    bool? isIconAnimate,
  }) {
    return SpinnerHeaderTheme(
      height: height ?? this.height,
      padding: padding ?? this.padding,
      style: style ?? this.style,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      bgColor: bgColor ?? this.bgColor,
      arrowColor: arrowColor ?? this.arrowColor,
      selectedMark: selectedMark ?? this.selectedMark,
      isShowBorder: isShowBorder ?? this.isShowBorder,
      outsideFocus: outsideFocus ?? this.outsideFocus,
      iconSize: iconSize ?? this.iconSize,
      textDirection: textDirection ?? this.textDirection,
      iconPading: iconPading ?? this.iconPading,
      isIconAnimate: isIconAnimate ?? this.isIconAnimate,
    );
  }
}

extension SpinnerThemeExt on SpinnerHeaderTheme {
  double get totalHeight => height + padding.top + padding.bottom;
}

/// 默认配置
const SpinnerHeaderTheme defaultPinnerTheme = SpinnerHeaderTheme();
