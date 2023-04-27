// ignore_for_file: must_be_immutable

part of '../spinner_filter.dart';

/// !!! 不推荐使用，特殊选择框可以自定义条件筛选组件
/// !!! 仅支持 `SpinnerFilterEntity-items`不满足需求，追加局部视图时使用
/// 定义外部视图的结构
/// 设置通用方法返回筛选条件结果
abstract class AttachmentView extends StatelessWidget with ChangeNotifier {
  AttachmentView({super.key});

  /// 仅需要`key`和`extraData`
  abstract SpinnerFilterEntity _entity;

  /// 仅需要`key`和`extraData`
  SpinnerFilterEntity get entity => _entity;
  set entity(SpinnerFilterEntity data) {}

  /// 更新数据
  updateExtra(dynamic data) {
    // if (data != entity.extraData) {
    entity = entity.copyWith(extraData: data);
    // 通知监听，清除已选择项
    notifyListeners();
    // }
  }

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
}

bool _isNull(dynamic data) {
  if (data == null) {
    return true;
  } else if (data is String) {
    return data.isEmpty;
  } else if (data is Iterable) {
    return data.isEmpty;
  } else if (data is Map) {
    return data.isEmpty;
  }
  return false;
}
