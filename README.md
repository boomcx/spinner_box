#### 下拉筛选菜单框，支持单选、多选、栅栏样式及自定义显示内容

！！！由于分体式设计，给定默认选中值时，需要外部初始化`SpinnerController`后手动使用给菜单栏标题赋值

[![pub package](https://img.shields.io/pub/v/spinner_box.svg?label=spinner_box&color=blue)](https://pub.dev/packages/spinner_box)

[demo link](https://boomcx.github.io/spinner_box/)：flutter web link。

[Example description](https://juejin.cn/post/7227012644506435642)

# Spinner Box

![snapshoot.jpg](https://github.com/boomcx/images/blob/main/spinner_box/snapshoot.jpg?raw=true)

### 使用案例

```dart

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('多选操作')),
      body: Column(
        children: [
          SpinnerBox.builder(
            titles: const ['多选条件', '多选条件', '混合条件+拦截'].toSpinnerData,
            builder: (notifier) {
              return [
                SpinnerFilter(
                  data: _condition1,
                  onCompleted: (result, name, data, onlyClosed) {
                    _condition1 = data;
                    notifier.updateName(name);
                    setState(() {
                      _result = result;
                    });
                  },
                ).heightPart,
                SpinnerFilter(
                  data: _condition2,
                  onCompleted: (result, name, data, onlyClosed) {
                    _condition2 = data;
                    notifier.updateName(name);
                    setState(() {
                      _result = result;
                    });
                  },
                ).heightPart,
                SpinnerFilter(
                  data: _condition3,
                  onItemIntercept: (entity, item, index) async {
                    // 可以从数据源来确定拦截按钮，也可以从点击时通过额外逻辑来判定
                    // 但按钮置灰样式只能通过数据源配置处理
                    if (item.isItemIntercept ||
                        (entity.key == 'text2' && index == 2)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('欸~ 就是选不了~')),
                      );
                      return true;
                    }
                    return false;
                  },
                  onCompleted: (result, name, data, onlyClosed) {
                    _condition3 = data;
                    notifier.updateName(name);
                    setState(() {
                      _result = result;
                    });
                  },
                ).heightPart,
              ];
            },
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Text('筛选结果: $_result'),
          ),
        ],
      ),
    );
  }
```

### 外部初始化`SpinnerController`

```dart

   var spinnerController = PopupValueNotifier.titles(['全部'].toSpinnerData);

   ...

  SpinnerBox.builder(
    controller: spinnerController,
    builder: (spinner) {
      ...
  });


```

### 更新所选项的标题或设置高亮显示

```dart
  spinnerController.updateName(name);
or
  spinnerController.setHighlight(true)
```
