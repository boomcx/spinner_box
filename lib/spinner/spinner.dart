import 'dart:math';

import 'package:flutter/material.dart';
import 'package:spinner_box/asset.dart';
import './state.dart';
import 'route/trans_dialog.dart';
import 'theme.dart';

typedef SpinnerBoxBuilder = List<SpinnerPopScope> Function(
    PopupValueNotifier spinner);

/// 自定义下拉菜单弹框
///
// ignore: must_be_immutable
class SpinnerBox extends StatefulWidget {
  /// 普通构建方式，必须对数据源进行监听，否则下次弹窗不会保存历史选中数据
  ///
  /// 使用示例：
  ///
  ///  ```
  ///  final controller = PopupValueNotifier.titles(const ['title1', 'tilte2']);
  ///  ...
  ///  SpinnerBox(
  ///   controller: controller,
  ///   children: [
  ///     CustomWidget().heightPart,
  ///     ...
  ///   ],
  ///  ),
  /// ```
  ///
  ///  控制器方法:
  /// ```
  ///   notifier.updateName('update-title1');
  ///  'or' notifier.close();
  ///  'or' notifier.reset();
  /// ```
  SpinnerBox({
    super.key,
    required PopupValueNotifier controller,
    // required this.titles,
    required List<SpinnerPopScope> children,
    this.prefix,
    this.isExpandPrefix = false,
    this.suffix,
    this.isExpandSuffix = false,
    this.theme = defaultPinnerTheme,
    this.barrierColor,
    this.transitionsBuilder,
  }) {
    isRebuilder = false;
    spinnerController = controller;
    widgets = children;
  }

  /// 每次唤起弹框，都会重新构建内部视图，可以减少对数据源的监听修改
  ///
  /// 使用示例：
  ///
  /// ```
  /// SpinnerBox.builder(
  ///    prefix: prefix,
  ///    suffix: suffix,
  ///    titles: const ['title1', 'tilte2'],
  ///    builder: (notifier) => [
  ///      CustomWidget().heightFll,
  ///      CustomWidget().heightPart,
  ///    ],
  ///  )
  /// ```
  ///  控制器方法:
  /// ```
  ///   notifier.updateName('update-title1');
  ///  'or' notifier.close();
  ///  'or' notifier.reset();
  /// ```
  SpinnerBox.builder({
    super.key,
    List<SpinnerHeaderData>? titles,
    PopupValueNotifier? controller,
    required SpinnerBoxBuilder builder,
    this.prefix,
    this.isExpandPrefix = false,
    this.suffix,
    this.isExpandSuffix = false,
    this.theme = defaultPinnerTheme,
    this.barrierColor,
    this.transitionsBuilder,
  }) {
    assert(titles != null || controller != null,
        '`SpinnerBox.builder` 构造方法 `titles` 或者 `controller` 参数不能同时为空！');
    isRebuilder = true;
    if (titles?.isNotEmpty == true) {
      spinnerController = PopupValueNotifier.titles(titles!);
    } else if (controller != null) {
      spinnerController = controller;
    }
    // widgets = builder.call(controller);
    widgetsBuilder = builder;
  }

  /// 每次唤起弹框，都会重新构建内部视图，可以减少对数据源的监听修改
  ///
  @Deprecated('合并迁移到`builder`方法中,请使用`SpinnerBox.builder`')
  SpinnerBox.rebuilder({
    super.key,
    required List<SpinnerHeaderData> titles,
    required SpinnerBoxBuilder builder,
    this.prefix,
    this.isExpandPrefix = false,
    this.suffix,
    this.isExpandSuffix = false,
    this.theme = defaultPinnerTheme,
    this.barrierColor,
    this.transitionsBuilder,
  }) {
    isRebuilder = true;
    spinnerController = PopupValueNotifier.titles(titles);
    widgetsBuilder = builder;
  }

  /// 前置视图
  final Widget? prefix;
  final bool isExpandPrefix;

  /// 后置视图
  final Widget? suffix;
  final bool isExpandSuffix;

  /// 是否重复构建builder
  late final bool isRebuilder;

  /// 标题
  // final List<String> titles;

  /// 弹框内容构建
  late List<SpinnerPopScope> widgets;

  /// 弹框内容构建
  late SpinnerBoxBuilder widgetsBuilder;

  /// 逻辑控制器
  late PopupValueNotifier spinnerController;

  /// 顶部按钮视图配置
  final SpinnerHeaderTheme theme;

  /// 弹窗遮罩背景色
  final Color? barrierColor;

  /// 弹出内容显示动画
  final SpinnerViewTransitionsBuilder? transitionsBuilder;

  @override
  State<SpinnerBox> createState() => _SpinnerBoxState();
}

class _SpinnerBoxState extends State<SpinnerBox> {
  late PopupValueNotifier _notifier;

  /// 当前的显示的页面路由（指定关闭当前弹框，解决焦点失活跳转页面异常）
  TransPopupRouter? _router;

  @override
  void initState() {
    _notifier = widget.spinnerController;
    super.initState();

    _notifier.addListener(() {
      _closeWidget();
      if (_notifier.value.selected > -1) {
        _showWidget();
      }
    });
  }

  @override
  void dispose() {
    _notifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _CompsitedTarget(
      notifier: _notifier,
      widget: widget,
      config: widget.theme,
    );
  }

  _showWidget() {
    final selected = _notifier.value.selected;

    final children = widget.isRebuilder
        ? widget.widgetsBuilder.call(_notifier)
        : widget.widgets;

    if (children.length - 1 < selected) {
      return;
    }

    final content = _CompositedFollower(
      ctx: context,
      notifier: _notifier,
      widget: widget,
      // scope: widget.builder.call(_notifier)[selected],
      scope: children[selected],
    );

    _router = TransPopupRouter(
      offsetY: _notifier.spinnerRect().bottom,
      barrierColor: widget.barrierColor ?? Colors.black12,
      pageBuilder: (context, animation, secondaryAnimation) => content,
      transitionsBuilder: widget.transitionsBuilder,
    );

    content.show(_router);
  }

  _closeWidget() {
    for (var i = 0; i < _notifier.status.length; i++) {
      if (_notifier.status[i]) {
        if (_router == null) {
          Navigator.pop(context);
        } else {
          Navigator.removeRoute(context, _router!);
        }
      }
      _notifier.status[i] = false;
    }
  }
}

class _CompositedFollower extends StatelessWidget {
  _CompositedFollower({
    required this.ctx,
    required PopupValueNotifier notifier,
    required this.widget,
    required this.scope,
  }) : _notifier = notifier {
    // final render =
    //     _notifier.targetKey.currentContext!.findRenderObject() as RenderBox;
    // final position = render.localToGlobal(Offset.zero);

    _spinnerRect = _notifier.spinnerRect();

    _maxHeight = MediaQuery.of(ctx).size.height -
        _spinnerRect.bottom -
        MediaQuery.of(ctx).padding.bottom;
  }

  final BuildContext ctx;
  final SpinnerBox widget;
  final PopupValueNotifier _notifier;
  final SpinnerPopScope scope;
  late final double _maxHeight;
  late final Rect _spinnerRect;

  final FocusScopeNode _node = FocusScopeNode();

  /// 显示内容
  Future show(router) {
    final selected = _notifier.value.selected;

    _notifier.status[selected] = true;

    return Navigator.of(ctx).push(router).then((value) {
      if (_notifier.status[selected]) {
        _notifier.status[selected] = false;
        _notifier.closed();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double offset = 0;
    double width = double.infinity;
    if (scope.width == AutoLength) {
      width = _spinnerRect.width;
    } else if (scope.width == double.infinity) {
      offset = -_spinnerRect.left;
    } else {
      offset = scope.offsetX;
      width = scope.width;
    }

    return CompositedTransformFollower(
      link: _notifier.link,
      showWhenUnlinked: false,
      offset: Offset(offset, widget.theme.totalHeight),
      child: FocusScope(
        autofocus: true,
        node: _node,
        onFocusChange: (value) {
          if (!value && widget.theme.outsideFocus) {
            _notifier.closed();
          }
        },
        child: Material(
          color: Colors.transparent,
          type: MaterialType.transparency,
          child: Stack(
            children: [
              Container(),
              GestureDetector(
                onTap: () {
                  _hideKeyboard(context);
                  _node.requestFocus();
                },
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(bottom: Radius.circular(8)),
                  ),
                  constraints: BoxConstraints(
                    maxHeight: _maxHeight * scope.scale,
                    maxWidth: width,
                  ),
                  child: scope.child,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _CompsitedTarget extends StatelessWidget {
  const _CompsitedTarget({
    required PopupValueNotifier notifier,
    required this.widget,
    required this.config,
  }) : _notifier = notifier;

  final PopupValueNotifier _notifier;
  final SpinnerBox widget;

  /// 视图配置
  final SpinnerHeaderTheme config;

  @override
  Widget build(BuildContext context) {
    final prefix = widget.prefix == null
        ? null
        : Builder(builder: (context) {
            final child = FocusScope(
              child: widget.prefix!,
              onFocusChange: (value) {
                if (value) {
                  _notifier.closed();
                }
              },
            );
            if (widget.isExpandPrefix) {
              return Expanded(child: child);
            }
            return child;
          });
    final suffix = widget.suffix == null
        ? null
        : Builder(builder: (context) {
            final child = FocusScope(
              child: widget.suffix!,
              onFocusChange: (value) {
                if (value) {
                  _notifier.closed();
                }
              },
            );
            if (widget.isExpandSuffix) {
              return Expanded(child: child);
            }
            return child;
          });

    return CompositedTransformTarget(
      link: _notifier.link,
      child: Container(
        key: _notifier.targetKey,
        // height: config.height,
        height: config.totalHeight,
        padding: config.padding,
        decoration: BoxDecoration(
          color: config.bgColor,
          border: config.isShowBorder
              ? const Border(
                  top: BorderSide(width: 1, color: Color(0xffeeeeee)),
                  // bottom: BorderSide(width: 1, color: Color(0xffeeeeee)),
                )
              : null,
        ),
        child: Row(children: [
          if (prefix != null) prefix,
          ...List.generate(
            _notifier.orginItems.length,
            (index) {
              final item = LayoutBuilder(builder: (_, constraints) {
                return GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    _notifier.updateSelected(index);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    child: ValueListenableBuilder<PopupState>(
                      valueListenable: _notifier,
                      builder: (context, value, child) {
                        return _Button(
                          value.items[index],
                          value.selected == index,
                          config,
                          maxWidth: constraints.minWidth,
                          isHighlight: (config.selectedMark
                                  ? value.items[index] !=
                                      value.orginItems[index]
                                  : false) ||
                              value.highlightSpec['high_$index'] == true,
                        );
                      },
                    ),
                  ),
                );
              });

              return (widget.isExpandPrefix || widget.isExpandSuffix)
                  ? item
                  : Expanded(child: item);
            },
          ),
          if (suffix != null) suffix,
        ]),
      ),
    );
  }
}

class _Button extends StatefulWidget {
  const _Button(
    this.item,
    this.isSelected,
    this.config, {
    this.maxWidth = 20,
    this.isHighlight = false,
  });

  final double maxWidth;
  final SpinnerHeaderData item;
  final bool isSelected;
  final bool isHighlight;

  /// 视图配置
  final SpinnerHeaderTheme config;

  @override
  State<_Button> createState() => _ButtonState();
}

class _ButtonState extends State<_Button> {
  ///计算文本宽度
  static Size _boundingTextSize({
    required BuildContext context,
    required String text,
    required TextStyle style,
    int maxLines = 2 ^ 31,
    double maxWidth = double.infinity,
  }) {
    if (text.isEmpty) {
      return Size.zero;
    }
    final TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
        locale: Localizations.localeOf(context),
        text: TextSpan(text: text, style: style),
        maxLines: maxLines)
      ..layout(maxWidth: maxWidth);
    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    final flag = widget.isSelected || widget.isHighlight;
    final iconSize = widget.config.iconSize;

    final textSize = _boundingTextSize(
      context: context,
      text: widget.item.title,
      style: widget.config.style,
      maxLines: 1,
    );

    final constraintsWidth = widget.maxWidth > 50
        ? widget.maxWidth - iconSize - 20 - widget.config.iconPading.horizontal
        : textSize.width + iconSize + widget.config.iconPading.horizontal;

    Widget icon;
    if (widget.item.icon != null) {
      icon = AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        child: flag
            ? Image.asset(
                widget.item.iconSelected ?? widget.item.icon!,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
                // package: 'spinner_box',
              )
            : Image.asset(
                widget.item.icon!,
                width: iconSize,
                height: iconSize,
                fit: BoxFit.contain,
                // package: 'spinner_box',
              ),
      );
    } else {
      icon = AnimatedRotation(
        turns: widget.isSelected ? 0.5 : 0,
        duration: const Duration(milliseconds: 250),
        alignment: Alignment.center,
        child: Assets.icArrDown(
          height: min(widget.config.height, iconSize),
          color: flag
              ? widget.config.selectedStyle.color
              : widget.config.arrowColor,
        ),
        // icon 图片有过大的内边距
        // child: Icon(
        //   Icons.arrow_drop_up_rounded,
        //   size: min(config.height, iconSize),
        //   color: flag ? config.selectedStyle.color : config.arrowColor,
        // ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        textDirection: widget.config.textDirection,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: constraintsWidth),
            child: Text(
              widget.item.title,
              style: flag ? widget.config.selectedStyle : widget.config.style,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          Padding(
            padding: widget.config.iconPading,
            child: icon,
          ),
        ],
      ),
    );
  }
}

extension HideKeyboardX on Widget {
  /// 添加键盘关闭事件
  Widget hideKeyboard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _hideKeyboard(context);
      },
      child: this,
    );
  }
}

_hideKeyboard(BuildContext context) {
  FocusScopeNode currentFocus = FocusScope.of(context);
  if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
    FocusManager.instance.primaryFocus!.unfocus();
  }
}
