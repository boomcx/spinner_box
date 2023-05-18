// ignore_for_file: must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';
import 'package:spinner_box_example/data.dart';

class CustomPage extends StatefulWidget {
  const CustomPage({super.key});

  @override
  State<CustomPage> createState() => _CustomPageState();
}

class _CustomPageState extends State<CustomPage> {
  var _condition3 = [
    text(key: 'text1', type: MoreContentType.wrap, count: 15),
    text(key: 'text2', type: MoreContentType.wrap, isRadio: false, count: 8),
    text(key: 'text3', type: MoreContentType.wrap, isRadio: false, count: 20),
  ];

  Map<String, List<dynamic>> _result = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('多选操作')),
      body: Column(
        children: [
          SpinnerBox.rebuilder(
            titles: const ['自定义弹窗', '自定义弹窗', '拼接自定义'],
            builder: (notifier) {
              return [
                Material(
                  color: Colors.red,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    alignment: Alignment.center,
                    child: const Text('占满屏幕剩余高度'),
                  ),
                ).heightFull,
                Material(
                  color: Colors.blueAccent,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 44,
                        child: Text('有高度限制，但是可以滚动 $index'),
                      );
                    },
                    itemCount: 100,
                  ),
                ).heightPart,
                SpinnerFilter(
                  data: _condition3,
                  attachment: [
                    _InputAttach(data: _condition3),
                    _PickerAttach(data: _condition3)
                  ],
                  onItemIntercept: (p0, p1) {
                    if (p0.key == 'text2' && p1 == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('欸~ 拦截了就是选不了~')),
                      );
                      return true;
                    }
                    return false;
                  },
                  onCompleted: (result, name, data, onlyClosed) {
                    notifier.updateName(name);
                    setState(() {
                      _condition3 = data;
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
}

/// 通过自有数据刷新控件
class _InputAttach extends AttachmentView {
  _InputAttach({required super.data});

  final textEditing = TextEditingController();

  @override
  String get groupKey => 'text1';

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

/// 通过 `ValueListenableBuilder` 监听 `extraNotifier` 刷新视图
class _PickerAttach extends AttachmentView {
  _PickerAttach({required super.data});

  @override
  String get groupKey => 'text2';

  @override
  String get extraName => '时间选择';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      color: Colors.black12,
      child: ValueListenableBuilder(
        valueListenable: extraNotifier,
        builder: (context, value, child) {
          return ElevatedButton(
            child: Text(value ?? '点击选择'),
            onPressed: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime(2023),
                firstDate: DateTime(2023),
                lastDate: DateTime(2333),
              );
              updateExtra(date.toString());
            },
          );
        },
      ),
    );
  }
}
