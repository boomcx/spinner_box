import 'dart:async';

import 'package:flutter/material.dart';
import '../spinner_filter.dart';
import 'state.dart';
import 'package:tuple/tuple.dart';

// part 'provider.g.dart';

const double kBotBtnHeight = 56.0;

class SpinnerFilterNotifier extends ValueNotifier<SpinnerFilterState> {
  SpinnerFilterNotifier(
    SpinnerFilterState state,
    this.onReseted,
    this.onItemIntercept,
  ) : super(state);

  /// 构造方法
  factory SpinnerFilterNotifier.init(
    List<SpinnerFilterEntity> data,
    List<AttachmentView> attachList,
    VoidCallback? onReseted,
    SpinnerItemIntercept? onItemIntercept,
  ) {
    if (data.isEmpty) {
      return SpinnerFilterNotifier(
          const SpinnerFilterState(), onReseted, onItemIntercept);
    }
    final instance =
        SpinnerFilterNotifier(_getState(data), onReseted, onItemIntercept);
    instance.updateAttach(attachList);
    return instance;
  }

  /// 件传递
  final VoidCallback? onReseted;

  /// 事件传递
  final SpinnerItemIntercept? onItemIntercept;

  /// 外部传入自定义视图
  List<AttachmentView> attachment = [];

  /// 需要返回至外部得数据，与传入数据一致，同步状态筛选状态
  List<SpinnerFilterEntity> get outside => value.items.map((e) {
        final entity = e.entity;
        final changeList = e.changeList;
        var tempList = List.of(entity.items);
        for (var i = 0; i < changeList.length; i++) {
          tempList[i] = tempList[i].copyWith(selected: changeList[i].selected);
        }
        return entity.copyWith(items: tempList);
      }).toList();

  updateState(List<SpinnerFilterEntity> data, List<AttachmentView> attachList) {
    value = _getState(data);
    updateAttach(attachList);
    notifyListeners();
  }

  static SpinnerFilterState _getState(
    List<SpinnerFilterEntity> data,
  ) {
    final singleCondition = data.length == 1;
    final singleSelect = data.first.isRadio == true;
    // final notExtra = items.first['extra'] == null;
    return SpinnerFilterState(
      singleConditionAndSingleSelect: singleCondition && singleSelect,
      items: data.map((e) => EntityNotifier(e)).toList(),
      isInit: true,
    );
  }

  /// 外部视图排序
  updateAttach(List<AttachmentView> attachList) {
    attachment = List.of(attachList);
    addAttachListener();
  }

  /// 设置自定组件的监听数据变化
  addAttachListener() {
    for (var e in attachment) {
      e.isChanged.addListener(() {
        reset(e.entity.key);
      });
    }
  }

  /// 移除监听
  removeAttachListener() {
    for (var e in attachment) {
      e.isChanged.dispose();
    }
  }

  @override
  void dispose() {
    removeAttachListener();
    super.dispose();
  }

  /// 完成筛选
  void completed() {
    value = value.copyWith(isCompleted: true);
  }

  /// 重置自定义外部输入
  /// `key` 当前组的字段
  void resetAttachment([String? key]) {
    if (attachment.isEmpty) {
      return;
    }
    for (var element in attachment) {
      if (key != null) {
        if (element.entity.key == key) {
          element.reset();
          break;
        }
      } else {
        element.reset();
      }
    }
  }

  /// 重置
  /// `key` 当前组的字段
  void reset([String? key]) {
    // 按钮重置
    var groups = value.items;
    for (var i = 0; i < groups.length; i++) {
      var tempGroup = groups[i];
      if (key != null) {
        if (tempGroup.entity.key == key) {
          // 修改按钮选中状态
          var items = tempGroup.changeList;
          for (var k = 0; k < items.length; k++) {
            items[k].selected = false;
          }
          break;
        }
      } else {
        // 修改按钮选中状态
        var items = tempGroup.changeList;
        for (var k = 0; k < items.length; k++) {
          items[k].selected = false;
        }
      }
    }
    onReseted?.call();
  }

  /// 获取选择的结果
  Tuple2<Map<String, List<dynamic>>, String> getResult() {
    final items = value.items;
    final reslut = <String, List>{};
    final reslutNames = [];

    for (var group in items) {
      final key = group.entity.key;
      var resGroup = {key: []};

      // r如果有拼接组件，则先从自定义组件中寻找是否选定结果
      if (attachment.isNotEmpty) {
        for (var element in attachment) {
          if (element.entity.key == key && element.entity.extraData != null) {
            final res = element.gerResult();
            resGroup = res.item1;
            if (res.item2.isNotEmpty) {
              reslutNames.add(res.item2);
            }
            break;
          }
        }
      }
      // 如果自定义组件没有选择，则检索筛选项是否选中
      if (resGroup[key]?.isEmpty == true) {
        final list = group.changeList;
        for (var item in list) {
          if (item.selected) {
            resGroup[key]!.add(item.value);
            reslutNames.add(item.data.name);
          }
        }
        reslut.addAll(resGroup);
      }
    }

    return Tuple2(reslut, reslutNames.join('/'));
  }

  /// 点击按钮选项
  /// `tuple` 包含当前点击的分组数据 和 分组下标
  /// `index` 按钮下标
  void itemOnClick(Tuple2<EntityNotifier, int> tuple, int index) async {
    if (onItemIntercept != null) {
      final isIntercept =
          await onItemIntercept!.call(tuple.item1.entity, index);
      if (isIntercept == true) {
        return;
      }
    }

    // 重置额外输入（可添加互斥，额外输入与筛选按钮可合并返回）
    resetAttachment(tuple.item1.entity.key);

    final group = tuple.item1;
    final single = group.entity.isRadio;

    var groups = value.items;
    for (var i = 0; i < groups.length; i++) {
      var tempGroup = groups[i];
      // 当前操做的数据组
      if (i == tuple.item2) {
        // 修改按钮选中状态
        var items = tempGroup.changeList;
        for (var k = 0; k < items.length; k++) {
          // 单选
          if (single) {
            items[k].selected = false;
          } else {
            if (items[index].data.isMutex) {
              items[k].selected = false;
            } else {
              if (items[k].data.isMutex) {
                items[k].selected = false;
              }
            }
          }
          // 多选
          if (index == k) {
            items[k].selected = !items[k].selected;
          }
        }
      }
    }

    if (value.singleConditionAndSingleSelect) {
      // 完成条件
      completed();
    }
  }
}

extension MFMapExt on Map {
  /// 将数组类型的value 修改为字符串类型
  Map<String, String> get listValue2Str => map(
        (key, value) =>
            MapEntry(key, value is List ? value.join(',') : '$value'),
      );
}
