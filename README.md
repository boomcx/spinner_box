The main purpose of writing is to produce components that are easy to use and have a low amount of code. Different from other filter components (' Stack 'Overlay'), this project uses the route jump 'Navigator.push', which can be used anywhere in the component tree, regardless of how the filter popover works.

'Stack' : The highest level tree of the page needs to be wrapped to realize the display of pop-up content. Normally speaking, the amount of code writing is relatively large, and the configuration is also more;

'Overlay' : This component view has a high level, which is a good choice for the top layer content display (Toast), but because of the high level, if you want to continue to display other selected input content after the pop-up box is displayed, it will block the display of input action page (such as keyboard, or other 'Navigator.push').

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

#### 2023-05-16 补充

add fence style

 <img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c6ccd765eab641df80582713a4aeb3e5~tplv-k3u1fbpfcp-watermark.image?" width="230px"> 

#### 2023-05-18 补充

add theme config

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


### Sets the width of the pop-up 

```dart
  SpinnerBox.builder(
              titles: const ['Builder', 'width-full'],
              builder: (notifier) {
                return [
                  SpinnerPopScope(
                    width: 150,  < ------- fixed width
                    offsetX: 30,  < ------- offset
                    child: ValueListenableBuilder(
                        valueListenable: _condition2,
                        builder: (context, value, child) {
                             ...
                        }),
                  ),
                  SpinnerPopScope(
                    width: double.infinity,  < ------- screen width
                    child: ValueListenableBuilder(
                        valueListenable: _condition2,
                        builder: (context, value, child) {
                          ...
                        }),
                  )
                ];
              },
            )
```

### Interception
```dart
 SpinnerFilter(
                  data: _condition3,
                  onItemIntercept: (group, index) {   < ----- click event interception
                    if (group.key == 'text2' && index == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('欸~ 就是选不了~')),
                      );
                      return true;
                    }
                    return false;
                  },
                  onCompleted: (result, name, data) {
                   ...
                  },
                ).heightPart,
```

### Custom splicing options
```dart
  SpinnerFilter(
                  data: _condition3,
                  attachment: [   < ----- custom components
                    _InputAttach(data: _condition3),
                    _PickerAttach(data: _condition3)
                  ],
                  onCompleted: (result, name, data) {
                   ...
                  },
                ).heightPart,
``` 
```dart

class _InputAttach extends AttachmentView {
  _InputAttach({required super.data});
  final textEditing = TextEditingController();
  
  @override
  String get groupKey => 'text1'; < --- association option grouping
  @override
  String get extraName => '输入标题';
  
  @override
  Widget build(BuildContext context) {
    textEditing.text = extraData ?? '';
    return Container(
      height: 38,
      color: Colors.black12,
      child: CupertinoTextField(
        controller: textEditing,
        placeholder: '输入框',
        onChanged: (value) {
          updateExtra(value);
        },
      ),
    );
  }

  @override
  void reset() {
    super.reset();
    textEditing.clear();
  }
}

```
