The drop-down criteria filter box supports single selection, multiple selection, and user-defined filtering content.

[![pub package](https://img.shields.io/pub/v/spinner_box.svg?label=spinner_box&color=blue)](https://pub.dev/packages/spinner_box)

[demo link](https://boomcx.github.io/spinner_box/)：flutter web link。

[Example description](https://juejin.cn/post/7227012644506435642)

# Spinner Box

![1.jpg](https://p0-xtjj-private.juejin.cn/tos-cn-i-73owjymdk6/36a6f0eb263348dea47b8922c3b6e616~tplv-73owjymdk6-jj-mark-v1:0:0:0:0:5o6Y6YeR5oqA5pyv56S-5Yy6IEAg5L2a5ZCN5ZWK:q75.awebp?policy=eyJ2bSI6MywidWlkIjoiMzUxODA2MTQxOTQzNjMwMiJ9&rk3s=e9ecf3d6&x-orig-authkey=f32326d3454f2ac7e96d3d06cdbb035152127018&x-orig-expires=1732002716&x-orig-sign=fUr8ObmY3JzMqFmwRpHayiZfOtM%3D)


### Simple use

```dart
  SpinnerBox.rebuilder(
            titles: const ['单选条件', '单选条件'],
            builder: (notifier) {
              return [
                SpinnerFilter(
                  data: _condition1,
                  onCompleted: (result, name, data) {
                    notifier.updateName(name);
                    setState(() {
                      _result = result;
                      _condition1 = data;
                    });
                  },
                ).heightPart,
                ...
              ];
            },
          ),
```

### Update the title or highlighting of the selected item

```dart
  notifier.updateName(name);
or
  notifier.setHighlight(true)
```
