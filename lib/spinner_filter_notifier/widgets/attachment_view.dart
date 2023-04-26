part of '../spinner_filter.dart';

/// !!! 不推荐使用，特殊选择框请自定义组件
/// !!! 仅支持 `SpinnerFilterEntity-items`不满足需求，追加局部视图时使用
/// 定义外部视图的结构
/// 设置通用方法返回筛选条件结果
// ignore: must_be_immutable
abstract class AttachmentView extends StatelessWidget {
  AttachmentView({super.key});

  abstract SpinnerFilterEntity _entity;

  SpinnerFilterEntity get entity => _entity;

  set entity(SpinnerFilterEntity data) {
    if (data.extraData != entity.extraData) {
      isChanged.value += 1;
    }
  }

  /// 监听是否完成赋值的改变
  var isChanged = ValueNotifier(0);

  /// 清空当前选择数据
  void reset() {
    entity = entity.copyWith(extraData: null);
  }

  @override
  Widget build(BuildContext context);

  /// 获取选中返回值
  Tuple2<Map<String, List<dynamic>>, String> gerResult() {
    final key = entity.key;
    final resGroup = {key: []};
    final reslutNames = [];

    final isNotNull = !_isNull(entity.extraData);
    // 检测是否有额外的输入数据
    if (isNotNull) {
      resGroup[key]!.add(entity.extraData);
      reslutNames.add(entity.extraData is String ? entity.extraData : '');
    }

    // final list = entity.items;
    // for (var item in list) {
    //   if (item.selected) {
    //     resGroup[key]!.add(item.value);
    //     reslutNames.add(item.name);
    //   }
    // }

    return Tuple2(resGroup, reslutNames.join('/'));
  }

  bool _isNull(dynamic data) {
    if (data == null) {
      return true;
    } else if (data is String) {
      return data.isEmpty;
    }

    return false;
  }
}
