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

  FocusScopeNode targetNode = FocusScopeNode();
  FocusScopeNode followerNode = FocusScopeNode();

  List<String> get items => value.items;
  List<String> get orginItems => value.orginItems;

  /// 保存每个选项卡对应的视图是否打开
  final List<bool> status;

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
  void setHighlight(int index, bool state) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var data = Map.of(value.highlightSpec);
      data['high_$index'] = state;
      value.highlightSpec = data;
      notifyListeners();
    });
  }

  /// 更新选项卡标题名称
  void updateName(String name, {bool needClose = true}) {
    if (name.isEmpty || name == '不限' || name == '全部') {
      value.items[value.selected] = value.orginItems[value.selected];
    } else if (value.orginItems.isNotEmpty && value.selected > -1) {
      value.items[value.selected] = name;
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
