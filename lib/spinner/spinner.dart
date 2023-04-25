export './state.dart';
export './theme.dart';

import 'package:flutter/material.dart';
import './state.dart';
import 'route/trans_dialog.dart';
import 'theme.dart';

/// The drop dwon popout header buttons with custom popout content view
// ignore: must_be_immutable
class SpinnerBox extends StatefulWidget {
  /// How to use
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
  ///  methods:
  /// ```
  ///   notifier.updateName('update-title1');
  ///  'or' notifier.close();
  ///  'or' notifier.reset();
  /// ```
  SpinnerBox({
    super.key,
    required this.controller,
    // required this.titles,
    required List<SpinnerScope> children,
    this.prefix,
    this.suffix,
    this.theme = defaultPinnerTheme,
  }) {
    widgets = children;
  }

  /// 前置视图
  final Widget? prefix;

  /// 后置视图
  final Widget? suffix;

  /// 标题
  // final List<String> titles;

  /// 弹框内容构建
  late List<SpinnerScope> widgets;

  /// 逻辑操作
  late PopupValueNotifier controller;

  /// 视图配置
  final SpinnerBoxTheme theme;

  /// How to use
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
  ///  methods:
  /// ```
  ///   notifier.updateName('update-title1');
  ///  'or' notifier.close();
  ///  'or' notifier.reset();
  /// ```
  SpinnerBox.builder({
    super.key,
    required List<String> titles,
    required List<SpinnerScope> Function(PopupValueNotifier) builder,
    this.prefix,
    this.suffix,
    this.theme = defaultPinnerTheme,
  }) {
    controller = PopupValueNotifier.titles(titles);
    widgets = builder.call(controller);
  }

  @override
  State<SpinnerBox> createState() => _SpinnerBoxState();
}

class _SpinnerBoxState extends State<SpinnerBox> {
  late PopupValueNotifier _notifier;

  /// 当前的显示的页面路由（指定关闭当前弹框，解决焦点失活跳转页面异常）
  TransPopupRouter? _router;

  // final Map<String, Popupscope> childReposity = {};

  @override
  void initState() {
    _notifier = widget.controller;
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

    // if (childReposity[selected.toString()] == null) {
    //   final scope = widget.builder.call(_notifier)[selected];
    //   childReposity[selected.toString()] = scope;
    // }

    final content = _CompositedFollower(
      ctx: context,
      notifier: _notifier,
      widget: widget,
      // scope: widget.builder.call(_notifier)[selected],
      scope: widget.widgets[selected],
    );

    _router = TransPopupRouter(
      targetCtx: _notifier.targetKey.currentContext,
      barrierColor: Colors.black12,
      pageBuilder: (context, animation, secondaryAnimation) => content,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return Align(
          alignment: Alignment.topCenter,
          child: SizeTransition(
            sizeFactor: CurvedAnimation(
              parent: animation,
              curve: Curves.easeOut,
            ),
            child: FadeTransition(
              opacity: CurvedAnimation(
                parent: animation,
                curve: Curves.easeOut,
              ),
              child: child,
            ),
          ),
        );
      },
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
    Key? key,
    required this.ctx,
    required PopupValueNotifier notifier,
    required this.widget,
    required this.scope,
  })  : _notifier = notifier,
        super(key: key) {
    final render =
        _notifier.targetKey.currentContext!.findRenderObject() as RenderBox;
    final position = render.localToGlobal(Offset.zero);
    _contentHeight = MediaQuery.of(ctx).size.height -
        position.dy -
        MediaQuery.of(ctx).padding.bottom -
        widget.theme.totalHeight;
  }

  final BuildContext ctx;
  final SpinnerBox widget;
  final PopupValueNotifier _notifier;
  late final double _contentHeight;
  final SpinnerScope scope;

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
    return CompositedTransformFollower(
      link: _notifier.link,
      showWhenUnlinked: false,
      offset: Offset(0, widget.theme.totalHeight),
      child: FocusScope(
        autofocus: true,
        onFocusChange: (value) {
          if (!value && widget.theme.outsideFocus) {
            _notifier.closed();
          }
        },
        child: Stack(
          children: [
            Container(),
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(8)),
              ),
              constraints: BoxConstraints(
                maxHeight: _contentHeight * scope.scale,
              ),
              child: scope.child,
            )
          ],
        ).hideKeyboard(context),
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
  final SpinnerBoxTheme config;

  @override
  Widget build(BuildContext context) {
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
                  bottom: BorderSide(width: 1, color: Color(0xffeeeeee)),
                )
              : null,
        ),
        child: Row(children: [
          if (widget.prefix != null)
            FocusScope(
              child: widget.prefix!,
              onFocusChange: (value) {
                if (value) {
                  _notifier.closed();
                }
              },
            ),
          ...List.generate(
            _notifier.orginItems.length,
            (index) => Expanded(
              child: LayoutBuilder(builder: (_, constraints) {
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
                          isChanged: config.changedMark
                              ? value.items[index] != value.orginItems[index]
                              : false,
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
          if (widget.suffix != null)
            FocusScope(
              child: widget.suffix!,
              onFocusChange: (value) {
                if (value) {
                  _notifier.closed();
                }
              },
            ),
        ]),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button(
    this.name,
    this.isSelected,
    this.config, {
    this.maxWidth = 20,
    this.isChanged = false,
  });

  final double maxWidth;
  final String name;
  final bool isSelected;
  final bool isChanged;

  /// 视图配置
  final SpinnerBoxTheme config;

  @override
  Widget build(BuildContext context) {
    final flag = isSelected || isChanged;
    const double iconSize = 25;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: maxWidth - iconSize - 20,
            ),
            child: Text(
              name,
              style: flag ? config.changedStyle : config.textStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 4),
          AnimatedRotation(
            turns: isSelected ? -0.5 : 0,
            duration: const Duration(milliseconds: 250),
            child: Icon(
              Icons.arrow_drop_up_rounded,
              size: iconSize,
              color: flag ? config.changedStyle.color : config.arrowColor,
            ),
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
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: this,
    );
  }
}
