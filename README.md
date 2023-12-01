The drop-down criteria filter box supports single selection, multiple selection, and user-defined filtering content.

[![pub package](https://img.shields.io/pub/v/spinner_box.svg?label=spinner_box&color=blue)](https://pub.dev/packages/spinner_box)

[插件详细讲解 - 掘金](https://juejin.cn/post/7227012644506435642)

# Spinner Box

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
