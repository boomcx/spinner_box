## Spinner_box
[![pub package](https://img.shields.io/pub/v/spinner_box.svg)](https://pub.dev/packages/spinner_box)


- 快速构建列表或按钮集形式的条件筛选项；
- 支持按钮集后追加额外的组件（输入框，选择器等）；
- 支持弹框内容自定义；

##### 待办
- 扩展自定义主题配置，包括不限于按钮、勾选；

##### 图例

|   |  |
| ------------- | ------------- |
|  <img src="https://github.com/boomcx/spinner_box/blob/main/assets/builder.gif" width="230px">  | <img src="https://github.com/boomcx/spinner_box/blob/main/assets/custom.gif" width="230px"> |
|  <img src="https://github.com/boomcx/spinner_box/blob/main/assets/single_select.gif" width="230px">  | <img src="https://github.com/boomcx/spinner_box/blob/main/assets/muti_select.gif" width="230px"> | 

 
## 如何使用
在插件引用文件`pubspec.yaml`中添加 `spinner_box: any`

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

