The drop-down criteria filter box supports single selection, multiple selection, and user-defined filtering content.

[![pub package](https://img.shields.io/pub/v/spinner_box.svg?label=spinner_box&color=blue)](https://pub.dev/packages/spinner_box)

[稀土掘金](https://juejin.cn/post/7227012644506435642)

# Spinner Box

## Features

- Quickly builds conditional filters in the form of lists or button sets;
- Support additional components (input boxes, selectors, etc.) after button sets;
- Supports the customization of the content of the pop-up;

## To do

- ~~Extend the custom theme configuration, including but not limited to buttons, check;~~
- Optimize the use of some types;

## images

<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ec9815f3261041488a556f65f3b06308~tplv-k3u1fbpfcp-watermark.image?" width="230px">  
<img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/cbfaa7bf262947ecaa3276c906a9d514~tplv-k3u1fbpfcp-watermark.image?" width="230px"> 
<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/a3233a2b7d504feca89536d20d5c8e76~tplv-k3u1fbpfcp-watermark.image?" width="230px">  
<img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b823adbfb4c248f989fc3673846b0cf0~tplv-k3u1fbpfcp-watermark.image" width="230px"> 
 <img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c6ccd765eab641df80582713a4aeb3e5~tplv-k3u1fbpfcp-watermark.image?" width="230px">

 <img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9c92e404c2b44d18b43d4f2eab619318~tplv-k3u1fbpfcp-watermark.image?" width="230px">
 
## Installation
See the [installation instructions on pub](https://pub.dev/packages/spinner_box/install).

## More details are available ./example

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
