import 'package:flutter/material.dart';
import './trans_route_new.dart';

Widget _defaultTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return Align(
    alignment: Alignment.topCenter,
    child: SizeTransition(
      sizeFactor: CurvedAnimation(
        parent: animation,
        curve: Curves.linear,
      ),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: animation,
          curve: Curves.linear,
        ),
        child: child,
      ),
    ),
  );
}

typedef SpinnerViewTransitionsBuilder = Widget Function(
    BuildContext, Animation<double>, Animation<double>, Widget);

class TransPopupRouter extends TransModalRoute {
  TransPopupRouter({
    super.settings,
    this.offsetY,
    required this.pageBuilder,
    this.barrierColor,
    this.barrierDismissible = true,
    this.transitionsBuilder,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 100),
    this.maintainState = true,
  });

  /// {@template flutter.widgets.pageRouteBuilder.pageBuilder}
  /// Used build the route's primary contents.
  ///
  /// See [ModalRoute.buildPage] for complete definition of the parameters.
  /// {@endtemplate}
  final RoutePageBuilder pageBuilder;

  /// {@template flutter.widgets.pageRouteBuilder.transitionsBuilder}
  /// Used to build the route's transitions.
  ///
  /// See [ModalRoute.buildTransitions] for complete definition of the parameters.
  /// {@endtemplate}
  ///
  /// The default transition is a jump cut (i.e. no animation).
  final RouteTransitionsBuilder? transitionsBuilder;

  @override
  final Duration transitionDuration;

  @override
  final Duration reverseTransitionDuration;

  @override
  final bool opaque = false;

  @override
  final bool barrierDismissible;

  @override
  final Color? barrierColor;

  @override
  final String? barrierLabel = null;

  @override
  final bool maintainState;

  @override
  double? offsetY;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder(context, animation, secondaryAnimation);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return (transitionsBuilder ?? _defaultTransitionsBuilder)
        .call(context, animation, secondaryAnimation, child);
  }

  @override
  bool get popGestureEnabled => true;
}

/// 显示下拉展示筛选模态推送框
// Future showDropView({
//   required BuildContext context,
//   required Widget page,
//   required GlobalKey key,
// }) {
//   return Navigator.of(context).push(TransPopupRouter(
//     targetCtx: key.currentContext,
//     barrierColor: Colors.black12,
//     pageBuilder: (context, animation, secondaryAnimation) => page,
//     transitionsBuilder: (context, animation, secondaryAnimation, child) {
//       return Align(
//         alignment: Alignment.topCenter,
//         child: SizeTransition(
//           sizeFactor: CurvedAnimation(
//             parent: animation,
//             curve: Curves.easeOut,
//           ),
//           child: FadeTransition(
//             opacity: CurvedAnimation(
//               parent: animation,
//               curve: Curves.easeOut,
//             ),
//             child: child,
//           ),
//         ),
//       );
//     },
//   ));
// }
