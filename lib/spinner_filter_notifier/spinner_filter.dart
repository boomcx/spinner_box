import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_filter_notifier/theme/theme.dart';

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

/// 包含当前点击的分组数据 和 分组下标
typedef STabEntityAndIndexData = (SpinnerEntity entity, int index);

/// List / Wrap 形式的显示视图
class SpinnerFilter extends StatefulWidget {
  const SpinnerFilter({
    super.key,
    required this.data,
    required this.onCompleted,
    this.onReseted,
    this.onItemIntercept,
    this.attachment = const [],
    this.theme,
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

  /// 显示配置
  final SpinnerBoxThemeData? theme;

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
        widget.onCompleted(
          result.$1,
          result.$2,
          data,
          notifier.value.onlyClosed,
        );
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

        return SpinnerBoxTheme(
          theme: widget.theme ?? const SpinnerBoxThemeData(),
          child: _ContentView(notifier: notifier),
        );
      },
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    required this.notifier,
  });

  final SpinnerFilterNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final theme = SpinnerBoxTheme.of(context);

    return _FilterNotiferScope(
      notifier: notifier,
      child: Material(
        color: theme.backgroundColor,
        child: const Stack(
          children: [
            SingleChildScrollView(
              child: _SpinnerContent(),
            ),
            Positioned(
              right: 0,
              left: 0,
              bottom: 0,
              child: _BotButtons(),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Divider(
                height: 1,
                color: Color(0xffEEEEEE),
              ),
            )
          ],
        ),
      ),
    );
  }
}

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
        top: 0,
        bottom: single ? 0 : kBotBtnHeight,
      ),
      itemBuilder: (context, index) {
        return _FilterGroupScope(
          data: (items[index], index),
          child: const _GroupContent(),
        );
      },
      separatorBuilder: (context, index) {
        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
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
    final theme = SpinnerBoxTheme.of(context).buttons;

    if (single) return const SizedBox();

    return Container(
      height: kBotBtnHeight,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.backgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Color(0xfff7f7f7)),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TapScope(
              onPressed: () {
                if (theme.isRest) {
                  notifier.reset();
                  notifier.resetAttachment();
                } else {
                  // 仅关闭
                  notifier.completed(true);
                }
              },
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: theme.leftDecoration,
                child: Text(theme.leftTxt, style: theme.leftStyle),
              ),
            ),
          ),
          const SizedBox(width: 11),
          Expanded(
            child: TapScope(
              onPressed: notifier.completed,
              child: Container(
                alignment: Alignment.center,
                height: 40,
                decoration: theme.rightDecoration,
                child: Text(theme.rightTxt, style: theme.rightStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
