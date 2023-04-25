import 'package:flutter/material.dart';

class PopupState {
  List<String> items;
  final List<String> orginItems;
  int selected;

  PopupState({
    required this.items,
    required this.orginItems,
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

  /// Close popout
  closed() {
    updateSelected(-1);
  }

  /// Update the current selected index
  updateSelected(int index) {
    if (value.selected == index) {
      value.selected = -1;
    } else {
      value.selected = index;
    }
    notifyListeners();
  }

  /// Update the title of the selected content text
  updateName(String name, {bool needClose = true}) {
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

  /// Clear the selected items
  reset({bool needClose = true}) {
    value.items[value.selected] = value.orginItems[value.selected];
    if (needClose) {
      closed();
    } else {
      notifyListeners();
    }
  }
}
