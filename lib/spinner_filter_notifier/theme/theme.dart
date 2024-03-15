import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

/// 筛选框按钮组的样式主题构建
class SpinnerBoxTheme extends InheritedWidget {
  const SpinnerBoxTheme({
    super.key,
    required this.theme,
    required super.child,
  });

  final SpinnerBoxThemeData theme;

  // 子树中的widget获取共享数据
  static SpinnerBoxThemeData of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<SpinnerBoxTheme>();
    return scope!.theme;
  }

  @override
  bool updateShouldNotify(covariant SpinnerBoxTheme oldWidget) {
    TextTheme;
    return oldWidget.theme != theme;
  }
}

/// 主题配置
/// 筛选框按钮组的样式主题
class SpinnerBoxThemeData {
  /// 弹窗背景颜色
  final Color backgroundColor;

  /// 标题样式配置
  final SHeaderThemeData header;

  /// `MoreContentType.wrap` 样式配置
  final SWrapThemeData wrap;

  /// `MoreContentType.column` 样式配置
  final SColumnThemeData column;

  /// 栅栏样式配置
  final SFenceThemeData fence;

  /// 底部按钮样式
  final SBoxBotBtnData buttons;

  const SpinnerBoxThemeData({
    this.backgroundColor = Colors.white,
    this.header = const SHeaderThemeData(),
    this.wrap = const SWrapThemeData(),
    this.column = const SColumnThemeData(),
    this.fence = const SFenceThemeData(),
    this.buttons = const SBoxBotBtnData(),
  });
}

/// 栅栏样式
class SFenceThemeData {
  /// 每一列的背景颜色
  /// 数据不足默认为`Colors.white`且最后一列没有颜色
  final List<Color> backgroundColors;

  /// 每一列的高亮颜色
  /// 数据不足默认为`Color(0xfff7f7f7)`且最后一列没有颜色
  final List<Color> hightlightedColors;

  /// 每行高度
  final double height;

  const SFenceThemeData({
    this.backgroundColors = const [Color(0xfff5f5f5)],
    this.hightlightedColors = const [Colors.white],
    this.height = 42,
  });

  SFenceThemeData copyWith({
    List<Color>? backgroundColors,
    List<Color>? hightlightedColors,
    double? height,
  }) {
    return SFenceThemeData(
      backgroundColors: backgroundColors ?? this.backgroundColors,
      hightlightedColors: hightlightedColors ?? this.hightlightedColors,
      height: height ?? this.height,
    );
  }

  @override
  bool operator ==(covariant SFenceThemeData other) {
    if (identical(this, other)) return true;

    return listEquals(other.backgroundColors, backgroundColors) &&
        listEquals(other.hightlightedColors, hightlightedColors) &&
        other.height == height;
  }

  @override
  int get hashCode =>
      backgroundColors.hashCode ^ hightlightedColors.hashCode ^ height.hashCode;
}

/// 弹窗底部按钮样式
class SBoxBotBtnData {
  /// 背景颜色
  final Color backgroundColor;

  /// 左侧按钮是否为重置（点击逻辑）
  final bool isRest;

  /// 左侧文字
  final String leftTxt;

  /// 右侧文字
  final String rightTxt;

  /// 左侧样式
  final TextStyle leftStyle;

  /// 右侧样式
  final TextStyle rightStyle;

  /// 按钮装饰
  final BoxDecoration leftDecoration;

  /// 按钮装饰
  final BoxDecoration rightDecoration;

  const SBoxBotBtnData({
    this.isRest = true,
    this.leftTxt = '重置',
    this.rightTxt = '确定',
    this.backgroundColor = Colors.white,
    this.leftStyle = const TextStyle(color: Colors.black87, fontSize: 16),
    this.rightStyle = const TextStyle(color: Colors.white, fontSize: 16),
    this.leftDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      gradient: LinearGradient(
        colors: [Color(0xffeeeeee), Color(0xfff5f5f5)],
      ),
    ),
    this.rightDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      gradient: LinearGradient(
        colors: [Color(0xffF56E60), Color(0xffE72410)],
      ),
    ),
  });

  SBoxBotBtnData copyWith({
    Color? backgroundColor,
    bool? isRest,
    String? leftTxt,
    String? rightTxt,
    TextStyle? leftStyle,
    TextStyle? rightStyle,
    BoxDecoration? leftDecoration,
    BoxDecoration? rightDecoration,
  }) {
    return SBoxBotBtnData(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      isRest: isRest ?? this.isRest,
      leftTxt: leftTxt ?? this.leftTxt,
      rightTxt: rightTxt ?? this.rightTxt,
      leftStyle: leftStyle ?? this.leftStyle,
      rightStyle: rightStyle ?? this.rightStyle,
      leftDecoration: leftDecoration ?? this.leftDecoration,
      rightDecoration: rightDecoration ?? this.rightDecoration,
    );
  }

  @override
  bool operator ==(covariant SBoxBotBtnData other) {
    if (identical(this, other)) return true;

    return other.backgroundColor == backgroundColor &&
        other.isRest == isRest &&
        other.leftTxt == leftTxt &&
        other.rightTxt == rightTxt &&
        other.leftStyle == leftStyle &&
        other.rightStyle == rightStyle &&
        other.leftDecoration == leftDecoration &&
        other.rightDecoration == rightDecoration;
  }

  @override
  int get hashCode {
    return backgroundColor.hashCode ^
        isRest.hashCode ^
        leftTxt.hashCode ^
        rightTxt.hashCode ^
        leftStyle.hashCode ^
        rightStyle.hashCode ^
        leftDecoration.hashCode ^
        rightDecoration.hashCode;
  }
}

/// `MoreContentType.column` 样式配置
class SColumnThemeData {
  /// 文字内容字体
  final TextStyle selectedStyle;

  /// 文字内容字体
  final TextStyle unselectedStyle;

  /// 每行高度
  final double height;

  /// 单选选中图标
  final Widget? icon1;

  /// 单选未选中图标
  final Widget? icon2;

  /// 多选选中图标
  final Widget? iconMulti1;

  /// 多选未选中图标
  final Widget? iconMulti2;

  /// 多选子集未全选图标
  final Widget? iconMulti3;

  /// 最大显示行数
  final int? maxLine;

  const SColumnThemeData({
    this.maxLine = 1,
    this.height = 30,
    this.icon1,
    this.icon2,
    this.iconMulti1,
    this.iconMulti2,
    this.iconMulti3,
    this.selectedStyle = const TextStyle(
        color: Color(0xffE72410), fontSize: 14, fontWeight: FontWeight.w600),
    this.unselectedStyle = const TextStyle(
        color: Color(0xff20263A), fontSize: 14, fontWeight: FontWeight.normal),
  });

  @override
  bool operator ==(covariant SColumnThemeData other) {
    if (identical(this, other)) return true;

    return other.selectedStyle == selectedStyle &&
        other.unselectedStyle == unselectedStyle &&
        other.height == height &&
        other.icon1 == icon1 &&
        other.icon2 == icon2 &&
        other.iconMulti1 == iconMulti1 &&
        other.iconMulti2 == iconMulti2 &&
        other.iconMulti3 == iconMulti3 &&
        other.maxLine == maxLine;
  }

  @override
  int get hashCode {
    return selectedStyle.hashCode ^
        unselectedStyle.hashCode ^
        height.hashCode ^
        icon1.hashCode ^
        icon2.hashCode ^
        iconMulti1.hashCode ^
        iconMulti2.hashCode ^
        iconMulti3.hashCode ^
        maxLine.hashCode;
  }

  SColumnThemeData copyWith({
    TextStyle? selectedStyle,
    TextStyle? unselectedStyle,
    double? height,
    Widget? icon1,
    Widget? icon2,
    Widget? iconMulti1,
    Widget? iconMulti2,
    Widget? iconMulti3,
    int? maxLine,
  }) {
    return SColumnThemeData(
      selectedStyle: selectedStyle ?? this.selectedStyle,
      unselectedStyle: unselectedStyle ?? this.unselectedStyle,
      height: height ?? this.height,
      icon1: icon1 ?? this.icon1,
      icon2: icon2 ?? this.icon2,
      iconMulti1: iconMulti1 ?? this.iconMulti1,
      iconMulti2: iconMulti2 ?? this.iconMulti2,
      iconMulti3: iconMulti3 ?? this.iconMulti3,
      maxLine: maxLine ?? this.maxLine,
    );
  }
}

/// `MoreContentType.wrap` 样式配置
class SWrapThemeData {
  /// 排列间距
  final double runSpacing;

  /// 排列间距
  final double spacing;

  /// 按钮内间距
  final EdgeInsets itemPadding;

  /// 文字内容字体
  final TextStyle selectedStyle;

  /// 文字内容字体
  final TextStyle unselectedStyle;

  /// 按钮装饰
  final BoxDecoration selectedDecoration;

  /// 按钮装饰
  final BoxDecoration unselectedDecoration;

  const SWrapThemeData({
    this.runSpacing = 10,
    this.spacing = 10,
    this.itemPadding = const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
    this.selectedStyle = const TextStyle(color: Colors.white, fontSize: 12),
    this.unselectedStyle = const TextStyle(color: Colors.black87, fontSize: 12),
    this.selectedDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      gradient: LinearGradient(colors: [Color(0xffF56E60), Color(0xffE72410)]),
    ),
    this.unselectedDecoration = const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      gradient: LinearGradient(colors: [Color(0xfff7f7f7), Color(0xfff7f7f7)]),
    ),
  });

  @override
  bool operator ==(covariant SWrapThemeData other) {
    if (identical(this, other)) return true;

    return other.runSpacing == runSpacing &&
        other.spacing == spacing &&
        other.itemPadding == itemPadding &&
        other.selectedStyle == selectedStyle &&
        other.unselectedStyle == unselectedStyle &&
        other.selectedDecoration == selectedDecoration &&
        other.unselectedDecoration == unselectedDecoration;
  }

  @override
  int get hashCode {
    return runSpacing.hashCode ^
        spacing.hashCode ^
        itemPadding.hashCode ^
        selectedStyle.hashCode ^
        unselectedStyle.hashCode ^
        selectedDecoration.hashCode ^
        unselectedDecoration.hashCode;
  }

  SWrapThemeData copyWith({
    double? runSpacing,
    double? spacing,
    EdgeInsets? itemPadding,
    TextStyle? selectedStyle,
    TextStyle? unselectedStyle,
    BoxDecoration? selectedDecoration,
    BoxDecoration? unselectedDecoration,
  }) {
    return SWrapThemeData(
      runSpacing: runSpacing ?? this.runSpacing,
      spacing: spacing ?? this.spacing,
      itemPadding: itemPadding ?? this.itemPadding,
      selectedStyle: selectedStyle ?? this.selectedStyle,
      unselectedStyle: unselectedStyle ?? this.unselectedStyle,
      selectedDecoration: selectedDecoration ?? this.selectedDecoration,
      unselectedDecoration: unselectedDecoration ?? this.unselectedDecoration,
    );
  }
}

/// 标题样式配置
class SHeaderThemeData {
  /// 标题文字样式
  final TextStyle style;

  /// 弹窗内容文字样式
  final TextStyle descStyle;

  /// 标题后符号大小
  final double iconSize;

  /// 间隔
  final double spacing;

  const SHeaderThemeData({
    this.style = const TextStyle(color: Colors.black54, fontSize: 12),
    this.descStyle =
        const TextStyle(color: Colors.white, height: 1, fontSize: 13),
    this.iconSize = 15,
    this.spacing = 8,
  });

  @override
  bool operator ==(covariant SHeaderThemeData other) {
    if (identical(this, other)) return true;

    return other.style == style &&
        other.descStyle == descStyle &&
        other.iconSize == iconSize &&
        other.spacing == spacing;
  }

  @override
  int get hashCode {
    return style.hashCode ^
        descStyle.hashCode ^
        iconSize.hashCode ^
        spacing.hashCode;
  }

  SHeaderThemeData copyWith({
    TextStyle? style,
    TextStyle? descStyle,
    double? iconSize,
    double? spacing,
  }) {
    return SHeaderThemeData(
      style: style ?? this.style,
      descStyle: descStyle ?? this.descStyle,
      iconSize: iconSize ?? this.iconSize,
      spacing: spacing ?? this.spacing,
    );
  }
}
