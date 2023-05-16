import 'package:flutter/material.dart';

import 'providers/entity.dart';
import 'providers/provider_fence.dart';
import 'widgets/asset.dart';
import 'widgets/buttons.dart';

part './widgets/fence.dart';

class SpinnerFence extends StatefulWidget {
  const SpinnerFence({
    super.key,
    required this.data,
    required this.onCompleted,
    this.onReseted,
    this.onItemIntercept,
  });

  /// 渲染数据
  final SpinnerEntity data;

  /// 重置回调
  final VoidCallback? onReseted;

  /// 选中项目的时候，拦截处理（用于交互前的特殊判断）
  /// 返回值 `true`，表示拦截选中事件
  /// `false` 则可以选中
  final SpinnerFenceIntercept? onItemIntercept;

  /// 选择完成回调
  /// `result` 返回结果 key.values
  /// `name` 选中标题拼接
  /// `data` 更新重置的原始数据（同步选中状态）
  final SpinnerFenceResponse onCompleted;

  @override
  State<SpinnerFence> createState() => _SpinnerFenceState();
}

class _SpinnerFenceState extends State<SpinnerFence> {
  late SpinnerFenceNotifier notifier;

  @override
  void initState() {
    super.initState();

    notifier = SpinnerFenceNotifier.init(
      widget.data,
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
  void didUpdateWidget(covariant SpinnerFence oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.data != widget.data) {
      notifier.updateState(widget.data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        if (value.data.items.isEmpty) {
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

        return _FenceNotiferScope(
          notifier: notifier,
          child: Material(
            color: const Color(0xfff5f5f5),
            child: Stack(
              children: const [
                _SpinnerFence(),
                Positioned(
                  right: 0,
                  left: 0,
                  bottom: 0,
                  child: _BotButtons(),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}

/// 栅栏显示
class _SpinnerFence extends StatelessWidget {
  const _SpinnerFence();

  @override
  Widget build(BuildContext context) {
    final notifier = _FenceNotiferScope.of(context);
    final single = notifier.value.singleConditionAndSingleSelect;

    return Padding(
      padding: EdgeInsets.only(
        bottom: single ? 0 : kBotBtnHeight + 10,
      ),
      child: const _FenceCnt(),
    );
  }
}

class _BotButtons extends StatelessWidget {
  const _BotButtons();

  @override
  Widget build(BuildContext context) {
    final notifier = _FenceNotiferScope.of(context);
    final single = notifier.value.singleConditionAndSingleSelect;

    if (single) {
      return const SizedBox();
    }
    return Container(
      height: kBotBtnHeight + 12,
      padding: const EdgeInsets.only(top: kBotBtnHeight - 40, bottom: 12),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: Color(0xfff5f5f5)),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          PopBotButton(
            isReset: true,
            name: '重置',
            onPressed: () {
              notifier.reset();
            },
          ),
          PopBotButton(
            onPressed: notifier.completed,
          ),
        ],
      ),
    );
  }
}

class _FenceNotiferScope extends InheritedWidget {
  const _FenceNotiferScope({
    required this.notifier,
    required super.child,
  });

  final SpinnerFenceNotifier notifier;

  // 子树中的widget获取共享数据
  static SpinnerFenceNotifier of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_FenceNotiferScope>();
    return scope!.notifier;
  }

  @override
  bool updateShouldNotify(covariant _FenceNotiferScope oldWidget) {
    //如果返回true，则子树中依赖(build函数中有调用)本widget
    //的子widget的`state.didChangeDependencies`会被调用
    return false;
  }
}
