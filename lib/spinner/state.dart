import 'package:flutter/material.dart';

class PopupState {
  /// 渲染数据
  List<String> items;

  /// 原始数据
  final List<String> orginItems;

  /// 当前选中的选项卡
  int selected;

  /// 缓存额外需要显示选项卡高亮的情况
  Map<String, bool> highlightSpec;

  PopupState({
    required this.items,
    required this.orginItems,
    this.highlightSpec = const {},
    this.selected = -1,
  });
}

class PopupValueNotifier extends ValueNotifier<PopupState> {
  PopupValueNotifier(PopupState state)
      : status = state.orginItems.map((e) => false).toList(),
        super(state);

  factory PopupValueNotifier.titles(List<String> titles) => PopupValueNotifier(
        PopupState(items: List.of(titles), orginItems: List.of(titles)),
      );

  final link = LayerLink();
  final GlobalKey targetKey = GlobalKey();

  List<String> get items => value.items;
  List<String> get orginItems => value.orginItems;

  /// 保存每个选项卡对应的视图是否打开
  final List<bool> status;

  /// 获取当前筛选框头部的坐标信息
  Rect spinnerRect() {
    final render = targetKey.currentContext!.findRenderObject() as RenderBox;
    final topLeft = render.localToGlobal(Offset.zero);
    return Rect.fromPoints(
      topLeft,
      Offset(
        topLeft.dx + render.size.width,
        topLeft.dy + render.size.height,
      ),
    );
  }

  /// 关闭弹窗
  void closed() {
    updateSelected(-1);
  }

  /// 设置选中
  void updateSelected(int index) {
    if (value.selected == index) {
      value.selected = -1;
    } else {
      value.selected = index;
    }
    notifyListeners();
  }

  /// 外部设置某一个高亮（优先级最高）
  /// 用户标题不修改，但允许高亮的情况
  /// `index` 高亮下标，默认为当前点击的下标
  void setHighlight(bool state, [int? index]) {
    int current = index ?? value.selected;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var data = Map.of(value.highlightSpec);
      data['high_$current'] = state;
      value.highlightSpec = data;
      notifyListeners();
    });
  }

  /// 更新选项卡标题名称
  void updateName(String name, {bool needClose = true, int? index}) {
    int current = index ?? value.selected;

    if (current < 0) {
      return;
    }
    if (name.isEmpty || name == '不限' || name == '全部') {
      value.items[current] = value.orginItems[current];
    } else if (value.orginItems.isNotEmpty && current > -1) {
      value.items[current] = name;
    }
    if (needClose) {
      closed();
    } else {
      notifyListeners();
    }
  }

  /// 清空已选择项
  void reset({bool needClose = true}) {
    value.items[value.selected] = value.orginItems[value.selected];
    if (needClose) {
      closed();
    } else {
      notifyListeners();
    }
  }
}
