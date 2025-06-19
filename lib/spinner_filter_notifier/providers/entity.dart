import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const double kBotBtnHeight = 64;

/// 内容显示类型
enum MoreContentType {
  /// 按钮样式，默认样式
  wrap,

  /// 列表样式
  column;

  static MoreContentType fromIndex(int? type) {
    switch (type) {
      case 0:
        return MoreContentType.wrap;
      case 1:
        return MoreContentType.column;
      default:
        return MoreContentType.wrap;
    }
  }
}

/// 弹框显示配置
///
/// ``` [items] 选项
/// [title] 标题
/// [desc] 描述
/// [isRadio] 是否单选
/// [extraData] 额外数据
/// [titleRichText] 富文本标题外部自定义
/// [titleSuffix] 标题后面的额外图片（本地图片）
/// [type] 每组内容的显示风格，通过网络数据 fromJson 可以定义成 int 类型
/// ```
///
class SpinnerEntity {
  /// 服务器字段
  final String key;

  /// 是否单选
  final bool isRadio;

  /// 标题，空不显示
  final String title;

  /// 富文本标题外部自定义
  final RichText? titleRichText;

  /// 额外视图的选择结构（eg: picker，input...）
  final dynamic extraData;

  /// 每组内容的显示风格
  final MoreContentType type;

  /// 问号描述，点击显示内容。默认为空不显示解释图标
  final String desc;

  /// 标题后面的额外图片（本地图片）
  // final String titleSuffix;

  /// 选项集
  final List<SpinnerItemData> items;

  const SpinnerEntity({
    required this.key,
    this.isRadio = true,
    this.title = '',
    this.type = MoreContentType.wrap,
    this.desc = '',
    this.titleRichText,
    this.extraData,
    this.items = const [],
  });

  factory SpinnerEntity.fromJson(Map<String, dynamic> json) {
    var entity = SpinnerEntity(key: '${json["key"] ?? 'keyName'}');
    // if (json["key"] is String) {
    //   key = json["key"];
    // }

    entity = entity.copyWith(extraData: json["extraData"]);

    if (json["isRadio"] is bool) {
      entity = entity.copyWith(isRadio: json["isRadio"]);
    }
    if (json["title"] is String) {
      entity = entity.copyWith(title: json["title"]);
    }
    if (json["type"] is MoreContentType) {
      entity = entity.copyWith(type: json["type"]);
    } else if (json["type"] is int) {
      entity = entity.copyWith(type: MoreContentType.fromIndex(json["type"]));
    }
    if (json["desc"] is String) {
      entity = entity.copyWith(desc: json["desc"]);
    }
    if (json["titleRichText"] is RichText) {
      entity = entity.copyWith(titleRichText: json["titleRichText"]);
    }
    if (json["items"] is List) {
      entity = entity.copyWith(
          items: json["items"] == null
              ? []
              : (json["items"] as List)
                  .map((e) => SpinnerItemData.fromJson(e))
                  .toList());
    }
    return entity;
  }

  static List<SpinnerEntity> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => SpinnerEntity.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["key"] = key;
    data["isRadio"] = isRadio;
    data["title"] = title;
    data["type"] = type;
    data["desc"] = desc;
    data["titleRichText"] = titleRichText;
    data["items"] = items.map((e) => e.toJson()).toList();
    return data;
  }

  SpinnerEntity copyWith({
    String? key,
    bool? isRadio,
    String? title,
    MoreContentType? type,
    String? desc,
    RichText? titleRichText,
    dynamic extraData,
    List<SpinnerItemData>? items,
  }) =>
      SpinnerEntity(
        key: key ?? this.key,
        isRadio: isRadio ?? this.isRadio,
        title: title ?? this.title,
        type: type ?? this.type,
        desc: desc ?? this.desc,
        titleRichText: titleRichText ?? this.titleRichText,
        items: items ?? this.items,
        extraData: extraData,
      );
}



/// 继承 `ChangeNotifier` `ValueListenable`
/// 写入自变量 `selected`，方便监听点击选中状态
class SpinnerItemData extends ChangeNotifier implements ValueListenable<bool> {
  /// 显示名称
  final String name;

  /// 选中项的数据值 (原样输入输出)
  /// 如果数据类型与实际类型不匹配时，可将实际数据放入`result`中
  /// 以保证选中时输出实际类容的集合
  final dynamic result;

  /// 是否选中互斥（选中时清空当前其他选中项，一般用于 `全部` `不限` 等合并条件项）
  final bool isMutex;

  /// 当前按钮是否支持点击拦截都可以点击，只是不触发选中
  /// 
  /// ！注意被设置为可拦截按钮后，将不会被选中，也不会触发`SpinnerFilter.onItemIntercept`  
  ///
  /// `isItemIntercept` 为 `true` 时，额外响应`SpinnerFilter.onItemIntercept`的拦截方法
  /// 用来配置自定义的支持拦截逻辑的按钮样式
  final bool isItemIntercept;

  /// 下级选项
  final List<SpinnerItemData> items;

  /// 高亮（栅栏选中时，需要切换数据）
  // bool get highlighted => _value.highlighted;
  // set highlighted(bool newValue) {
  //   value = value.copyWith(highlighted: newValue);
  // }

  /// 选中状态
  bool get selected => _value;
  set selected(bool newValue) {
    value = newValue;
  }

  /// 带有子集选项时，判断当前选项的子选项是否全部选中
  bool get isSelectedAll {
    /// 设置子集选中
    bool chidrenSelected(List<SpinnerItemData> list) {
      for (var element in list) {
        if (!element.selected) {
          return false;
        } else if (element.items.isNotEmpty) {
          if (!chidrenSelected(element.items)) {
            return false;
          }
        }
      }
      return true;
    }

    return chidrenSelected(items);
  }

  /// 不对外使用
  /// 外部使用 `selected` `isHighlight` 替代
  @override
  bool get value => _value;
  late bool _value;
  set value(bool newValue) {
    if (_value == newValue) {
      return;
    }
    _value = newValue;
    notifyListeners();
  }

  SpinnerItemData({
    this.name = '-',
    this.result,
    this.isMutex = false,
    this.items = const [],
    this.isItemIntercept = false,
    bool selected = false,
  }) : _value = selected;

  factory SpinnerItemData.fromJson(Map<String, dynamic> json) {
    var entity = SpinnerItemData();
    if (json["name"] is String) {
      entity = entity.copyWith(name: json["name"]);
    }
    entity = entity.copyWith(result: json["result"]);
    if (json["selected"] is bool) {
      entity = entity.copyWith(selected: json["selected"]);
    }
    if (json["isItemIntercept"] is bool) {
      entity = entity.copyWith(isItemIntercept: json["isItemIntercept"]);
    }
    // if (json["highlighted"] is bool) {
    //   entity = entity.copyWith(highlighted: json["highlighted"]);
    // }
    if (json["isMutex"] is bool) {
      entity = entity.copyWith(isMutex: json["isMutex"]);
    }
    if (json["items"] is List) {
      entity = entity.copyWith(items: SpinnerItemData.fromList(json["items"]));
    }

    return entity;
  }

  static List<SpinnerItemData> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => SpinnerItemData.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["result"] = result;
    data["selected"] = selected;
    // data["highlighted"] = highlighted;
    data["isItemIntercept"] = isItemIntercept;
    data["isMutex"] = isMutex;
    data["items"] = items.map((e) => e.toJson()).toList();
    return data;
  }

  SpinnerItemData copyWith({
    String? name,
    dynamic result,
    bool? selected,
    // bool? highlighted,
    bool? isItemIntercept,
    bool? isMutex,
    List<SpinnerItemData>? items,
  }) =>
      SpinnerItemData(
        name: name ?? this.name,
        result: result ?? this.result,
        selected: selected ?? this.selected,
        // highlighted: highlighted ?? this.highlighted,
        isItemIntercept: isItemIntercept ?? this.isItemIntercept,
        isMutex: isMutex ?? this.isMutex,
        items: items ?? this.items,
      );
}

extension ListFormatX on List<SpinnerItemData> {
  /// 获取层级
  int get tier {
    // int count = 0;
    // runLoop(List<SpinnerItem> list, int floor) {
    //   for (var e in list) {
    //     if (floor > count) {
    //       count = floor;
    //     }
    //     if (e.items.isNotEmpty) {
    //       runLoop(e.items, floor + 1);
    //     } else {
    //       continue;
    //     }
    //   }
    // }

    int getLevel(List<SpinnerItemData> items) {
      if (items.isEmpty) return 0;
      int maxLevel = 0;
      for (var item in items) {
        int level = getLevel(item.items) + 1; // 递归查询子项
        maxLevel = max(maxLevel, level);
      }
      return maxLevel;
    }

    // runLoop(this, 1);
    return getLevel(this);
  }
}

// class EntityNotifier {
//   EntityNotifier(this.entity) {
//     notifierList = entity.items.map((e) {
//       final option = OptionsNotifier(e);
//       option.selected = e.selected;
//       return option;
//     }).toList();
//   }
//   final SpinnerEntity entity;

//   /// 可监听选中变化的数据
//   late List<OptionsNotifier<SpinnerItem>> notifierList;
// }

// class OptionsNotifier<T> extends ValueNotifier {
//   OptionsNotifier(this.entity) : super(entity);
//   final T entity;

//   bool _selected = false;
//   bool get selected => _selected;
//   set selected(bool value) {
//     if (_selected != value) {
//       _selected = value;
//       notifyListeners();
//     }
//   }
// }
