import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../popup_message.dart';
import 'providers/entity.dart';
import 'providers/provider.dart';
import 'widgets/asset.dart';
import 'widgets/buttons.dart';

part './widgets/inherited.dart';
part './widgets/group.dart';
part './widgets/check_list_item.dart';
part './widgets/explain_icon.dart';
part './widgets/attachment_view.dart';

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
  final List<SpinnerEntity> data;

  /// 重置回调
  final VoidCallback? onReseted;

  /// 选中项目的时候，拦截处理（用于交互前的特殊判断）
  /// 返回值 `true`，表示拦截选中事件
  /// `false` 则可以选中
  final SpinnerFilterIntercept? onItemIntercept;

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
                  _SpinnerContent(),
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

/// 区分内容显示
/// `type.fence`和其他显示内容布局有所有差异
// class _ContentView extends StatelessWidget {
//   const _ContentView();

//   @override
//   Widget build(BuildContext context) {
//     final notifier = _FilterNotiferScope.of(context);
//     final items = notifier.value.items;

//     if (items.length == 1 && items.first.type == MoreContentType.fence) {
//       return const _SpinnerFence();
//     }
//     return const _SpinnerContent();
//   }
// }

/// 栅栏显示
// class _SpinnerFence extends StatelessWidget {
//   const _SpinnerFence();

//   @override
//   Widget build(BuildContext context) {
//     final notifier = _FilterNotiferScope.of(context);
//     final items = notifier.value.items;
//     final single = notifier.value.singleConditionAndSingleSelect;

//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: single ? 0 : kBotBtnHeight + 10,
//       ),
//       child: _FilterGroupScope(
//         data: Tuple2(items.first, 0),
//         child: const _FenceCnt(),
//       ),
//     );
//   }
// }

class _SpinnerContent extends StatelessWidget {
  const _SpinnerContent();

  @override
  Widget build(BuildContext context) {
    final notifier = _FilterNotiferScope.of(context);
    final items = notifier.value.items;
    final single = notifier.value.singleConditionAndSingleSelect;

    return ListView.separated(
      physics: const BouncingScrollPhysics(),
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
          PopBotButton(
            isReset: true,
            name: '重置',
            onPressed: () {
              notifier.reset();
              notifier.resetAttachment();
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
