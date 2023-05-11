import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

import '../spinner_filter.dart';
import 'entity.dart';
import 'state.dart';

const double kBotBtnHeight = 56.0;

class SpinnerFilterNotifier extends ValueNotifier<SpinnerFilterState> {
  SpinnerFilterNotifier(
    SpinnerFilterState state,
    this.onReseted,
    this.onItemIntercept,
  ) : super(state);

  /// 构造方法
  factory SpinnerFilterNotifier.init(
    List<SpinnerEntity> data,
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

  /// 事件传递
  final VoidCallback? onReseted;

  /// 事件传递
  final SpinnerItemIntercept? onItemIntercept;

  /// 外部传入自定义视图
  List<AttachmentView> attachment = [];

  /// 需要返回至外部得数据，同步原数据筛选状态
  List<SpinnerEntity> get outside => value.items;

  /// `didUpdateWidget` 时触发
  /// 更新当前state，用于异步显示筛选条件
  updateState(List<SpinnerEntity> data, List<AttachmentView> attachList) {
    value = _getState(data);
    updateAttach(attachList);
    notifyListeners();
  }

  /// 构建状态类型
  static SpinnerFilterState _getState(List<SpinnerEntity> data) {
    final singleCondition = data.length == 1;
    final singleSelect = data.first.isRadio == true;
    return SpinnerFilterState(
      singleConditionAndSingleSelect: singleCondition && singleSelect,
      // items: data.map((e) => EntityNotifier(e)).toList(),
      //  解决 `List.of(data)` - `ChangeNotifier` 无法重建的问题
      items: SpinnerEntity.fromList(data.map((e) => e.toJson()).toList()),
      isInit: true,
    );
  }

  /// 接收外部自定义粘连视图，并设置监听
  updateAttach(List<AttachmentView> attachList) {
    attachment = List.of(attachList);
    addAttachListener();
  }

  /// 设置自定组件的监听数据变化
  addAttachListener() {
    for (var e in attachment) {
      e.extraNotifier.addListener(() {
        if (e.extraData != null) {
          reset(e.groupKey);
        }
      });
    }
  }

  /// 移除监听
  // removeAttachListener() {
  //   // for (var e in attachment) {
  //   //   e.isChanged.dispose();
  //   // }
  // }

  @override
  void dispose() {
    // removeAttachListener();
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
        if (element.groupKey == key) {
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
        if (tempGroup.key == key) {
          // 修改按钮选中状态
          var items = tempGroup.items;
          for (var k = 0; k < items.length; k++) {
            items[k].selected = false;
          }
          break;
        }
      } else {
        // 修改按钮选中状态
        var items = tempGroup.items;
        for (var k = 0; k < items.length; k++) {
          items[k].selected = items[k].isMutex;
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
      final key = group.key;
      var resGroup = {key: []};

      // 如果有拼接组件，则先从自定义组件中寻找是否选定结果
      if (attachment.isNotEmpty) {
        for (var element in attachment) {
          if (element.groupKey == key && element.extraData != null) {
            final res = element.getResult();
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
        final list = group.items;
        for (var item in list) {
          if (item.selected) {
            resGroup[key]!.add(item.result);
            reslutNames.add(item.name);
          }
        }
      }

      reslut.addAll(resGroup);
    }

    return Tuple2(reslut, reslutNames.join('/'));
  }

  /// 点击按钮选项
  /// `tuple` 包含当前点击的分组数据 和 分组下标
  /// `index` 按钮下标
  void itemOnSelected(Tuple2<SpinnerEntity, int> tuple, int index) async {
    if (onItemIntercept != null) {
      final isIntercept = await onItemIntercept!.call(tuple.item1, index);
      if (isIntercept == true) {
        return;
      }
    }

    // 重置额外输入（可添加互斥，额外输入与筛选按钮可合并返回）
    resetAttachment(tuple.item1.key);

    final group = tuple.item1;
    final single = group.isRadio;

    var groups = value.items;
    for (var i = 0; i < groups.length; i++) {
      var tempGroup = groups[i];
      // 当前操做的数据组
      if (i == tuple.item2) {
        // 修改按钮选中状态
        var items = tempGroup.items;
        for (var k = 0; k < items.length; k++) {
          // 单选
          if (single) {
            items[k].selected = false;
          } else {
            if (items[index].isMutex) {
              items[k].selected = false;
            } else {
              if (items[k].isMutex) {
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
