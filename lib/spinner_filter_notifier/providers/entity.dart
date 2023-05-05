/// 内容显示类型
enum MoreContentType {
  /// 按钮样式
  groupBtn,

  /// 列表样式
  checkList,

  /// 栅栏样式
  fence
}

class SpinnerEntity {
  /// 服务器字段
  final String key;

  /// 是否单选
  final bool isRadio;

  /// 标题，空不显示
  final String title;

  /// 额外视图的选择结构（eg: picker，input...）
  final dynamic extraData;

  /// 每组内容的显示风格
  final MoreContentType type;

  /// 问号描述，点击显示内容
  final String desc;

  /// 标题后面的标记视图
  final String suffixIcon;

  /// 选项集
  final List<SpinnerItem> items;

  const SpinnerEntity({
    required this.key,
    this.isRadio = true,
    this.title = '',
    this.type = MoreContentType.groupBtn,
    this.desc = '',
    this.suffixIcon = '',
    this.items = const [],
    this.extraData,
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
    }
    if (json["desc"] is String) {
      entity = entity.copyWith(desc: json["desc"]);
    }
    if (json["suffixIcon"] is String) {
      entity = entity.copyWith(suffixIcon: json["suffixIcon"]);
    }
    if (json["items"] is List) {
      entity = entity.copyWith(
          items: json["items"] == null
              ? []
              : (json["items"] as List)
                  .map((e) => SpinnerItem.fromJson(e))
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
    data["suffixIcon"] = suffixIcon;
    data["items"] = items.map((e) => e.toJson()).toList();
    return data;
  }

  SpinnerEntity copyWith({
    String? key,
    bool? isRadio,
    String? title,
    MoreContentType? type,
    String? desc,
    String? suffixIcon,
    dynamic extraData,
    List<SpinnerItem>? items,
  }) =>
      SpinnerEntity(
        key: key ?? this.key,
        isRadio: isRadio ?? this.isRadio,
        title: title ?? this.title,
        type: type ?? this.type,
        desc: desc ?? this.desc,
        suffixIcon: suffixIcon ?? this.suffixIcon,
        items: items ?? this.items,
        extraData: extraData,
      );
}



class SpinnerItem {
  /// 显示名称
  final String name;

  /// 是否选中
  final dynamic value;

  /// 选中项的数据值 (原样输入输出)
  final bool selected;

  /// 是否选互斥（选中时清空当前其他选中项，一般用于 `全部` `不限` 等合并条件项）
  final bool isMutex;

  /// 下级选项
  final List<SpinnerItem> items;

  const SpinnerItem({
    this.name = '-',
    this.value,
    this.selected = false,
    this.isMutex = false,
    this.items = const [],
  });

  factory SpinnerItem.fromJson(Map<String, dynamic> json) {
    var entity = const SpinnerItem();
    if (json["name"] is String) {
      entity = entity.copyWith(name: json["name"]);
    }
    entity = entity.copyWith(value: json["value"]);
    if (json["selected"] is bool) {
      entity = entity.copyWith(selected: json["selected"]);
    }
    if (json["isMutex"] is bool) {
      entity = entity.copyWith(isMutex: json["isMutex"]);
    }
    if (json["items"] is List) {
      entity = entity.copyWith(items: SpinnerItem.fromList(json["items"]));
    }

    return entity;
  }

  static List<SpinnerItem> fromList(List<Map<String, dynamic>> list) {
    return list.map((map) => SpinnerItem.fromJson(map)).toList();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["name"] = name;
    data["value"] = value;
    data["selected"] = selected;
    data["isMutex"] = isMutex;
    return data;
  }

  SpinnerItem copyWith({
    String? name,
    dynamic value,
    bool? selected,
    bool? isMutex,
    List<SpinnerItem>? items,
  }) =>
      SpinnerItem(
        name: name ?? this.name,
        value: value ?? this.value,
        selected: selected ?? this.selected,
        isMutex: isMutex ?? this.isMutex,
        items: items ?? this.items,
      );
}
