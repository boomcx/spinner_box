The drop-down criteria filter box supports single selection, multiple selection, and user-defined filtering content.

[![pub package](https://img.shields.io/pub/v/spinner_box.svg?label=spinner_box&color=blue)](https://pub.dev/packages/spinner_box)

[demo link](https://boomcx.github.io/spinner_box/)：flutter web link。

[Example description](https://juejin.cn/post/7227012644506435642)

# Spinner Box

![snapshoot.jpg](https://github.com/boomcx/spinner_box/blob/main/example/assets/snapshoot.jpg?raw=true)


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
