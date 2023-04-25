import 'package:flutter/material.dart';
import 'entity.dart';
import 'state.dart';
import 'package:tuple/tuple.dart';

// part 'provider.g.dart';

const double kBotBtnHeight = 56.0;

typedef AttachmentEntity = Tuple2<int, Widget>;

class SpinnerFilterNotifier extends ValueNotifier<SpinnerFilterState> {
  SpinnerFilterNotifier(SpinnerFilterState state, this.onReseted)
      : super(state);

  /// 构造方法
  factory SpinnerFilterNotifier.init(
    List<SpinnerFilterEntity> data,
    List<AttachmentEntity> attachList,
    VoidCallback? onReseted,
  ) {
    if (data.isEmpty) {
      return SpinnerFilterNotifier(const SpinnerFilterState(), onReseted);
    }
    final instance = SpinnerFilterNotifier(_getState(data), onReseted);
    instance.updateAttach(attachList);
    return instance;
  }

  /// 重置事件传递
  final VoidCallback? onReseted;

  /// 外部传入自定义视图
  List<Tuple2<int, Widget>> attachment = [];

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

  updateState(
      List<SpinnerFilterEntity> data, List<AttachmentEntity> attachList) {
    value = _getState(data);
    updateAttach(attachList);
    notifyListeners();
  }

  /// 外部视图排序
  updateAttach(List<AttachmentEntity> attachList) {
    final foxList = [
      ...attachList,
      ...List.generate(value.items.length, (index) => index)
    ];

    foxList.sort((p0, p1) {
      int index0 = 0, index1 = 0;
      if (p0 is AttachmentEntity) {
        index0 = p0.item1;
      } else if (p0 is int) {
        index0 = p0;
      }
      if (p1 is AttachmentEntity) {
        index1 = p1.item1;
      } else if (p1 is int) {
        index1 = p1;
      }
      return index0.compareTo(index1);
    });

    final sortAttach = <AttachmentEntity>[];
    for (var i = 0; i < foxList.length; i++) {
      var item = foxList[i];
      if (item is AttachmentEntity) {
        sortAttach.add(Tuple2(i, item.item2));
      }
    }

    attachment = sortAttach;
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

  /// 完成筛选
  void completed() {
    value = value.copyWith(isCompleted: true);
  }

  /// 重置
  void reset() {
    var groups = value.items;
    for (var i = 0; i < groups.length; i++) {
      var tempGroup = groups[i];
      // 修改按钮选中状态
      var items = tempGroup.changeList;
      for (var k = 0; k < items.length; k++) {
        items[k].selected = false;
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
      final resGroup = {key: []};

      final list = group.changeList;
      for (var item in list) {
        if (item.selected) {
          resGroup[key]!.add(item.value);
          reslutNames.add(item.data.name);
        }
      }
      reslut.addAll(resGroup);
    }

    return Tuple2(reslut, reslutNames.join('/'));
  }

  /// 点击按钮选项
  /// `tuple` 包含当前点击的分组数据 和 分组下标
  /// `index` 按钮下标
  void itemOnClick(Tuple2<EntityNotifier, int> tuple, int index) {
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
