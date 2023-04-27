// ignore_for_file: must_be_immutable

part of '../spinner_filter.dart';

/// !!! 不太推荐使用，特殊内容筛选框可以自定义组件
/// !!! 仅支持 `SpinnerFilterEntity-items`不满足需求，追加局部视图时使用
/// 子类更新数据时使用 `updateExtra`，而不是 `entity-setter`
/// 设置通用方法返回筛选条件结果  
abstract class AttachmentView extends StatelessWidget {
  AttachmentView({super.key, required this.data}) {
    for (var element in data) {
      if (element.key == groupKey) {
        if (_isNull(element.extraData)) {
          return;
        }
        extraNotifier.value = element.extraData;
        break;
      }
    }
  }

  /// 筛选配置参数
  final List<SpinnerFilterEntity> data;

  /// 跟随筛选列表的 `key`, 匹配和筛值使用
  abstract String _groupKey;
  String get groupKey => _groupKey;
  set groupKey(String data) {}

  /// 自定义视图的输入值
  var extraNotifier = ValueNotifier<dynamic>(null);

  /// 输入值
  dynamic get extraData => extraNotifier.value;

  /// 更新数据
  updateExtra(dynamic data) {
    extraNotifier.value = data;
  }

  /// 清空当前选择数据
  void reset() {
    extraNotifier.value = null;
  }

  /// 获取选中返回值
  Tuple2<Map<String, List<dynamic>>, String> gerResult() {
    final resGroup = {groupKey: []};
    final reslutNames = [];

    final isNotNull = !_isNull(extraData);
    // 检测是否有额外的输入数据
    if (isNotNull) {
      resGroup[groupKey]!.add(extraData);
      reslutNames.add(extraData is String ? extraData : '');
    }

    return Tuple2(resGroup, reslutNames.join('/'));
  }

  @override
  Widget build(BuildContext context);
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
