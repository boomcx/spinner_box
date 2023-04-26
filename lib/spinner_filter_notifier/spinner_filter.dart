import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

export './providers/entity.dart';
export './providers/provider.dart';

import '../popup_message.dart';
import 'providers/state.dart';
import 'spinner_filter.dart';

part './widgets/buttons.dart';
part './widgets/group.dart';
part './widgets/check_list_item.dart';
part './widgets/explain_icon.dart';
part './widgets/attachment_view.dart';

/// 点击拦截的回调
typedef SpinnerItemIntercept = FutureOr<bool> Function(
    SpinnerFilterEntity, int);

/// 完成筛选的回调
typedef SpinnerFilterResponse = Function(
  Map<String, List> result,
  String name,
  List<SpinnerFilterEntity> data,
);

class SpinnerFilter extends StatefulWidget {
  const SpinnerFilter({
    super.key,
    required this.data,
    required this.onCompleted,
    this.onReseted,
    this.onItemIntercept,
    this.attachment = const [],
  });

  /// 渲染数据
  final List<SpinnerFilterEntity> data;

  /// 重置回调
  final VoidCallback? onReseted;

  /// 选中项目的时候，拦截处理（用于交互前的特殊判断）
  /// 返回值 `true`，表示拦截选中事件
  /// `false` 则可以选中
  final SpinnerItemIntercept? onItemIntercept;

  /// 选择完成回调
  /// `result` 返回结果 key.values
  /// `name` 选中标题拼接
  /// `data` 更新重置的原始数据（同步选中状态）
  final SpinnerFilterResponse onCompleted;

  /// 外部出入的自定义组件
  /// `int` 期望跟随`Grop`的位置 由`data`排序 默认0开始
  /// `Widget` 组件
  final List<AttachmentView> attachment;

  @override
  State<SpinnerFilter> createState() => _SpinnerFilterState();
}

class _SpinnerFilterState extends State<SpinnerFilter> {
  late SpinnerFilterNotifier notifier;

  @override
  void initState() {
    super.initState();

    notifier = SpinnerFilterNotifier.init(
      widget.data,
      widget.attachment,
      widget.onReseted,
      widget.onItemIntercept,
    );

    notifier.addListener(() {
      if (notifier.value.isCompleted) {
        final result = notifier.getResult();
        final data = notifier.outside;
        // 筛选出全部选中的结果
        widget.onCompleted(result.item1, result.item2, data);
      }
    });
  }

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant SpinnerFilter oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      notifier.updateState(widget.data, widget.attachment);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        if (value.items.isEmpty) {
          return Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: 80,
            padding: const EdgeInsets.all(8),
            child: const CircularProgressIndicator(
              strokeWidth: 2,
            ),
          );
        }

        return _FilterNotiferScope(
          notifier: notifier,
          child: Material(
            color: Colors.white,
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              child: Stack(
                // mainAxisSize: MainAxisSize.min,
                children: const [
                  SingleChildScrollView(
                    child: _MoreFilterContent(),
                  ),
                  Positioned(
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: _BotButtons(),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _MoreFilterContent extends StatelessWidget {
  const _MoreFilterContent();

  @override
  Widget build(BuildContext context) {
    final notifier = _FilterNotiferScope.of(context);
    final items = notifier.value.items;
    final single = notifier.value.singleConditionAndSingleSelect;
    var attachment = List.of(notifier.attachment);

    return ListView.separated(
      physics: const ClampingScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.only(
        left: 12,
        right: 12,
        top: 12,
        bottom: single ? 0 : kBotBtnHeight + 10,
      ),
      itemBuilder: (context, index) {
        return _FilterGroupScope(
          data: Tuple2(items[index], index),
          child: const _GroupContent(),
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Divider(height: 1, color: Color(0xffEEEEEE)),
        );
      },
      itemCount: items.length,
    );
  }
}

class _BotButtons extends StatelessWidget {
  const _BotButtons();

  @override
  Widget build(BuildContext context) {
    final notifier = _FilterNotiferScope.of(context);
    final single = notifier.value.singleConditionAndSingleSelect;

    if (single) {
      return const SizedBox();
    }
    return Container(
      height: kBotBtnHeight,
      padding: const EdgeInsets.only(top: kBotBtnHeight - 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: Color(0xfff5f5f5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _PopBotButton(
            isReset: true,
            name: '重置',
            onPressed: () {
              notifier.reset();
              notifier.resetAttachment();
            },
          ),
          _PopBotButton(
            onPressed: notifier.completed,
          ),
        ],
      ),
    );
  }
}

/// 树形结构中得全局数据传递
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

  final Tuple2<EntityNotifier, int> data;

  // 子树中的widget获取共享数据
  static Tuple2<EntityNotifier, int> of(BuildContext context) {
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
