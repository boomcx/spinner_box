超简单的下拉条件筛选器，框支持单选、多选和自定义筛选内容。

##### Spinner Box

[![pub package](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/19a06904e09646a79f388932c22d7aa0~tplv-k3u1fbpfcp-zoom-1.image)](https://pub.dev/packages/spinner_box)

[Git 地址](https://github.com/boomcx/spinner_box)

[掘金](https://juejin.cn/post/7227012644506435642)

- 快速构建列表或按钮集形式的条件筛选项；
- 支持按钮集后追加额外的组件（输入框，选择器等）；
- 支持弹框内容自定义；

##### 待办

- ~~扩展自定义主题配置，包括不限于按钮、勾选；~~
- 优化部分类型使用；

##### 图例

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
