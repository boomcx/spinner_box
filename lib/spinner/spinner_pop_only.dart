// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:spinner_box/asset.dart';
// import './state.dart';
// import 'route/trans_dialog.dart';
// import 'theme.dart';

// /// 自用同款展开筛选弹框（自定义头部样式，自定义弹窗内容）
// ///
// // ignore: must_be_immutable
// class SpinnerPopupBox extends StatefulWidget {
//   SpinnerPopupBox.custom({
//     super.key,
//     required this.header,
//     required PopupValueNotifier controller,
//     required List<SpinnerPopScope> children,
//     this.theme = defaultPinnerTheme,
//     this.barrierColor,
//     this.transitionsBuilder,
//   }) {
//     spinnerController = controller;
//     widgets = children;
//   }

//   /// 标题
//   final Widget header;

//   /// 弹框内容构建
//   late List<SpinnerPopScope> widgets;

//   /// 逻辑控制器
//   late PopupValueNotifier spinnerController;

//   /// 顶部按钮视图配置
//   final SpinnerHeaderTheme theme;

//   /// 弹窗遮罩背景色
//   final Color? barrierColor;

//   /// 弹出内容显示动画
//   final SpinnerViewTransitionsBuilder? transitionsBuilder;

//   @override
//   State<SpinnerPopupBox> createState() => _SpinnerPopupBoxState();
// }

// class _SpinnerPopupBoxState extends State<SpinnerPopupBox> {
//   late PopupValueNotifier _notifier;

//   /// 当前的显示的页面路由（指定关闭当前弹框，解决焦点失活跳转页面异常）
//   TransPopupRouter? _router;

//   @override
//   void initState() {
//     _notifier = widget.spinnerController;
//     super.initState();

//     _notifier.addListener(() {
//       _closeWidget();
//       if (_notifier.value.selected > -1) {
//         _showFilterView();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _notifier.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return _CompsitedTarget(
//       notifier: _notifier,
//       widget: widget,
//       config: widget.theme,
//     );
//   }

//   _showFilterView() {
//     final selected = _notifier.value.selected;

//     final children = widget.widgets;

//     if (children.length - 1 < selected) {
//       return;
//     }

//     final content = _CompositedFollower(
//       ctx: context,
//       notifier: _notifier,
//       widget: widget,
//       // scope: widget.builder.call(_notifier)[selected],
//       scope: children[selected],
//     );

//     _router = TransPopupRouter(
//       offsetY: _notifier.spinnerRect().bottom,
//       barrierColor: widget.barrierColor ?? Colors.black12,
//       pageBuilder: (context, animation, secondaryAnimation) => content,
//       transitionsBuilder: widget.transitionsBuilder,
//     );

//     content.show(_router);
//   }

//   _closeWidget() {
//     for (var i = 0; i < _notifier.status.length; i++) {
//       if (_notifier.status[i]) {
//         if (_router == null) {
//           Navigator.pop(context);
//         } else {
//           Navigator.removeRoute(context, _router!);
//         }
//       }
//       _notifier.status[i] = false;
//     }
//   }
// }

// class _CompositedFollower extends StatelessWidget {
//   _CompositedFollower({
//     required this.ctx,
//     required PopupValueNotifier notifier,
//     required this.widget,
//     required this.scope,
//   }) : _notifier = notifier {
//     _spinnerRect = _notifier.spinnerRect();

//     _maxHeight = MediaQuery.of(ctx).size.height -
//         _spinnerRect.bottom -
//         MediaQuery.of(ctx).padding.bottom;
//   }

//   final BuildContext ctx;
//   final SpinnerPopupBox widget;
//   final PopupValueNotifier _notifier;
//   final SpinnerPopScope scope;
//   late final double _maxHeight;
//   late final Rect _spinnerRect;

//   final FocusScopeNode _node = FocusScopeNode();

//   /// 显示内容
//   Future show(router) {
//     final selected = _notifier.value.selected;

//     _notifier.status[selected] = true;

//     return Navigator.of(ctx).push(router).then((value) {
//       if (_notifier.status[selected]) {
//         _notifier.status[selected] = false;
//         _notifier.closed();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double offset = 0;
//     double width = double.infinity;
//     if (scope.width == AutoLength) {
//       width = _spinnerRect.width;
//     } else if (scope.width == double.infinity) {
//       offset = -_spinnerRect.left;
//     } else {
//       offset = scope.offsetX;
//       width = scope.width;
//     }

//     return CompositedTransformFollower(
//       link: _notifier.link,
//       showWhenUnlinked: false,
//       offset: Offset(offset, widget.theme.totalHeight),
//       child: FocusScope(
//         autofocus: true,
//         node: _node,
//         onFocusChange: (value) {
//           if (!value && widget.theme.outsideFocus) {
//             _notifier.closed();
//           }
//         },
//         child: Material(
//           color: Colors.transparent,
//           type: MaterialType.transparency,
//           child: Stack(
//             children: [
//               Container(),
//               GestureDetector(
//                 onTap: () {
//                   _hideKeyboard(context);
//                   _node.requestFocus();
//                 },
//                 child: Container(
//                   clipBehavior: Clip.antiAlias,
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     borderRadius:
//                         BorderRadius.vertical(bottom: Radius.circular(8)),
//                   ),
//                   constraints: BoxConstraints(
//                     maxHeight: _maxHeight * scope.scale,
//                     maxWidth: width,
//                   ),
//                   child: scope.child,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class _CompsitedTarget extends StatelessWidget {
//   const _CompsitedTarget({
//     required PopupValueNotifier notifier,
//     required this.widget,
//     required this.config,
//   }) : _notifier = notifier;

//   final PopupValueNotifier _notifier;
//   final SpinnerPopupBox widget;

//   /// 视图配置
//   final SpinnerHeaderTheme config;

//   @override
//   Widget build(BuildContext context) {
//     return CompositedTransformTarget(
//       link: _notifier.link,
//       child: Container(
//         key: _notifier.targetKey,
//         // height: config.height,
//         height: config.totalHeight,
//         padding: config.padding,
//         decoration: BoxDecoration(
//           color: config.bgColor,
//           border: config.headerBorder,
//         ),
//         child: Row(children: [
//           Expanded(child: widget.header),
//           AnimatedRotation(
//             turns: _notifier.value.selected > -1 ? 0.5 : 0,
//             duration: const Duration(milliseconds: 250),
//             alignment: Alignment.center,
//             child: Assets.icArrDown(
//               height: min(config.height, config.iconSize),
//               color: _notifier.value.selected > -1
//                   ? config.selectedStyle.color
//                   : config.arrowColor,
//             ),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// extension HideKeyboardX on Widget {
//   /// 添加键盘关闭事件
//   Widget hideKeyboard(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         _hideKeyboard(context);
//       },
//       child: this,
//     );
//   }
// }

// _hideKeyboard(BuildContext context) {
//   FocusScopeNode currentFocus = FocusScope.of(context);
//   if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
//     FocusManager.instance.primaryFocus!.unfocus();
//   }
// }
