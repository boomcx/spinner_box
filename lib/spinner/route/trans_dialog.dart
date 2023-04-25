import 'package:flutter/material.dart';
import './trans_route.dart';

Widget _defaultTransitionsBuilder(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return child;
}

class TransPopupRouter extends TransModalRoute {
  TransPopupRouter({
    super.settings,
    this.targetCtx,
    required this.pageBuilder,
    this.barrierColor,
    this.barrierDismissible = true,
    this.transitionsBuilder = _defaultTransitionsBuilder,
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
  final RouteTransitionsBuilder transitionsBuilder;

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
  BuildContext? targetCtx;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return pageBuilder(context, animation, secondaryAnimation);
  }

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return transitionsBuilder(context, animation, secondaryAnimation, child);
  }
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
 