part of '../spinner_filter.dart';

/// 树形结构中的数据传递
class _FilterNotiferScope extends InheritedWidget {
  const _FilterNotiferScope({
    required this.notifier,
    required super.child,
  });

  final SpinnerFilterNotifier notifier;

  // 子树中的widget获取共享数据
  static SpinnerFilterNotifier of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_FilterNotiferScope>();
    return scope!.notifier;
  }

  @override
  bool updateShouldNotify(covariant _FilterNotiferScope oldWidget) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return false;
  }
}

class _FilterGroupScope extends InheritedWidget {
  const _FilterGroupScope({
    required this.data,
    required super.child,
  });

  final STabEntityAndIndexData data;

  // 子树中的widget获取共享数据
  static STabEntityAndIndexData of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_FilterGroupScope>();
    return scope!.data;
  }

  @override
  bool updateShouldNotify(covariant _FilterGroupScope oldWidget) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return false;
  }
}
