超简单的下拉条件筛选器，框支持单选、多选和自定义筛选内容。

##### Spinner Box

[![pub package](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/19a06904e09646a79f388932c22d7aa0~tplv-k3u1fbpfcp-zoom-1.image)](https://pub.dev/packages/spinner_box)

[Git 地址](https://github.com/boomcx/spinner_box)

[详细讲解 - 掘金](https://juejin.cn/post/7227012644506435642)


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
