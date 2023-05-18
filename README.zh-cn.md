
编写目的主要是想产出使用简单，代码量较低的组件。区别其他筛选组件（`Stack` `Overlay`），本项目采用路由跳转`Navigator.push`，可以在任意组件树位置使用，而不必关心筛选弹窗是如何工作的。

`Stack`: 需要页面最高层级树通过包裹来实现弹窗内容的显示，正常来讲代码编写量比较大，配置也较多；

`Overlay`: 该组件视图层级高，用来做顶层的内容显示（Toast）是非常棒的选择，但由于层级太高在弹出框显示后，如果想继续显示其他选中输入型内容会遮挡输入操作页的显示（例如键盘、或者其他`Navigator.push`）。

代码还有优化的地方，欢迎指出。

##### Spinner Box
[![pub package](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/19a06904e09646a79f388932c22d7aa0~tplv-k3u1fbpfcp-zoom-1.image)](https://pub.dev/packages/spinner_box) 

[Git地址](https://github.com/boomcx/spinner_box)

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

#### 2023-05-16 补充

添加栅栏选中样式

 <img src="https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/c6ccd765eab641df80582713a4aeb3e5~tplv-k3u1fbpfcp-watermark.image?" width="230px"> 

#### 2023-05-18 补充

添加主题配置

 <img src="https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/9c92e404c2b44d18b43d4f2eab619318~tplv-k3u1fbpfcp-watermark.image?" width="230px">

## 如何安装
请查看 [installation instructions on pub](https://pub.dev/packages/spinner_box/install).

### 更多使用细节请查看 ./example

### 简单使用

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

### 更新选中项的标题/设置高亮

```dart
  notifier.updateName(name);
or
  notifier.setHighlight(true)
```


### 设置弹框的宽度 

```dart
  SpinnerBox.builder(
              titles: const ['Builder', 'width-full'],
              builder: (notifier) {
                return [
                  SpinnerPopScope(
                    width: 150,  < ------- 固定宽度
                    offsetX: 30,  < ------- 偏移量
                    child: ValueListenableBuilder(
                        valueListenable: _condition2,
                        builder: (context, value, child) {
                             ...
                        }),
                  ),
                  SpinnerPopScope(
                    width: double.infinity,  < ------- 屏幕宽度
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

### 点击拦截
```dart
 SpinnerFilter(
                  data: _condition3,
                  onItemIntercept: (p0, p1) {   < ----- 按钮拦截
                    if (p0.key == 'text2' && p1 == 2) {
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

### 自定义的拼接选项
```dart
  SpinnerFilter(
                  data: _condition3,
                  attachment: [   < ----- 通过自定义组件传递
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
  String get groupKey => 'text1'; < --- 关联选项分组
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
