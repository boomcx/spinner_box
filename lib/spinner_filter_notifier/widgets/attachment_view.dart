// ignore_for_file: must_be_immutable

part of '../spinner_filter.dart';


/// 追加特殊内容筛选框可以自定义组件，使用通用方法返回筛选条件结果
/// 
/// 仅支持 `SpinnerFilterEntity-items`满足按钮需求时，追加局部视图时使用。
/// 子类更新数据时使用 `updateExtra`，而不是 `entity-setter`
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
  final List<SpinnerEntity> data;

  /// 跟随筛选列表的 `key`, 匹配和筛值使用
  abstract String _groupKey;
  String get groupKey => _groupKey;
  set groupKey(String data) {}

  /// 通过自定义组件完成选择，显示在导航上的标题
  final extraName = '';

  /// 自定义组件输入值监听
  var extraNotifier = ValueNotifier<dynamic>(null);

  /// 获取当前输入值
  dynamic get extraData => extraNotifier.value;

  /// 更新数据并刷新UI
  updateExtra(dynamic data) {
    extraNotifier.value = data;
  }

  /// 清空当前选择数据
  void reset() {
    extraNotifier.value = null;
  }

  /// 获取选中返回值
   (Map<String, List<dynamic>>, String) getResult() {
    final resGroup = {groupKey: []};
    // final reslutNames = [];

    final isNotNull = !_isNull(extraData);
    // 检测是否有额外的输入数据
    if (isNotNull) {
      resGroup[groupKey]!.add(extraData);
      // reslutNames.add(extraName);
    }

    return  (resGroup, extraName);
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
