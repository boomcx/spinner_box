// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

/// 保存当前筛选菜单的数据项，并配合`PopupValueNotifier`完成各项内容的监听
///
class PopupState {
  /// 渲染数据
  List<SpinnerData> items;

  /// 原始数据
  final List<SpinnerData> orginItems;

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

/// 监听控制器，关联视图和数据，并完成自定义方法的写入
class PopupValueNotifier extends ValueNotifier<PopupState> {
  PopupValueNotifier(super.state)
      : status = state.orginItems.map((e) => false).toList();

  /// 标题初始化
  factory PopupValueNotifier.titles(List<SpinnerData> titles) =>
      PopupValueNotifier(
        PopupState(items: List.of(titles), orginItems: List.of(titles)),
      );

  /// `CompositedTransformFollower` 的 `link`
  final link = LayerLink();

  /// 用于记录 `CompositedTransformFollower` 位置
  final GlobalKey targetKey = GlobalKey();

  List<SpinnerData> get items => value.items;
  List<SpinnerData> get orginItems => value.orginItems;

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

  /// 外部设置某一个选项卡仅高亮显示（优先级最高）
  /// `index` 高亮下标，默认为当前点击的下标
  void setHighlight(bool isHightlight, [int? index]) {
    int current = index ?? value.selected;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var data = Map.of(value.highlightSpec);
      data['high_$current'] = isHightlight;
      value.highlightSpec = data;
      notifyListeners();
    });
  }

  /// 更新选项卡标题名称
  /// `name` 选项卡名称（需要显示的名称，任意值）
  /// `index` 高亮下标，默认为当前点击选项卡的下标
  /// `needClose` 是否关闭弹窗
  void updateName(String name, {bool needClose = true, int? index}) {
    int current = index ?? value.selected;

    if (current < 0) {
      return;
    }
    if (name.isEmpty || name == '不限' || name == '全部') {
      value.items[current] = value.orginItems[current];
    } else if (value.orginItems.isNotEmpty && current > -1) {
      value.items[current] = value.items[current].copyWith(title: name);
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

/// 初始化传入的标题内容
class SpinnerData {
  /// 标题
  final String title;

  /// 图片路径
  final String? icon;
  final String? iconSelected;

  SpinnerData(
    this.title, {
    this.icon,
    this.iconSelected,
  });

  SpinnerData copyWith({
    String? title,
    String? icon,
    String? iconSelected,
  }) {
    return SpinnerData(
      title ?? this.title,
      icon: icon ?? this.icon,
      iconSelected: icon ?? this.iconSelected,
    );
  }
}

extension SpinnerDataExt on List<String> {
  List<SpinnerData> get toSpinnerData => map((e) => SpinnerData(e)).toList();
}
