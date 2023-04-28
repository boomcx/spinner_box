import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';

import '../data.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  var _condition1 = [
    text(key: 'text1', type: MoreContentType.groupBtn, count: 15),
  ];
  final _condition2 = ValueNotifier([
    text(key: 'text1', type: MoreContentType.groupBtn, count: 9),
  ]);

  final _controler = PopupValueNotifier.titles(const ['Controller + children']);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Children')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('''
普通构建模式的选中记录只适用于状态更新赋值,这里使用`setState` ,
`Children`构建会额外创建`controller`用于在视图外的逻辑处理,
例：默认选中某一个选项卡 `_controler.setHighlight(true, 0)` `_controler.updateName(name,index: 0)`
'''),
            const SizedBox(height: 10),
            SpinnerBox(controller: _controler, children: [
              SpinnerFilter(
                data: _condition1,
                onCompleted: (result, name, data) {
                  _controler.updateName(name);
                  setState(() {
                    _condition1 = data;
                  });
                },
              ).heightPart,
            ]),
            const SizedBox(height: 10),
            const Text('''
`SpinnerBox.builder`如果需要更新子视图的选中信息，需要额外使用局部刷新来刷新当前pop的视图, 
而不是使用`setState`,原因是使用`setState`之后整个页面都会被重建，而通过`notifier`进行的逻辑处理，并不会按期望执行（notifier已经发生改变） 
'''),
            const SizedBox(height: 10),
            SpinnerBox.builder(
              titles: const ['Builder', 'width-full'],
              builder: (notifier) {
                return [
                  SpinnerPopScope(
                    width: 150,
                    offsetX: 30,
                    child: ValueListenableBuilder(
                        valueListenable: _condition2,
                        builder: (context, value, child) {
                          return SpinnerFilter(
                            data: value,
                            onCompleted: (result, name, data) {
                              notifier.updateName(name);
                              _condition2.value = data;
                            },
                          );
                        }),
                  ),
                  SpinnerPopScope(
                    width: double.infinity,
                    child: ValueListenableBuilder(
                        valueListenable: _condition2,
                        builder: (context, value, child) {
                          return SpinnerFilter(
                            data: value,
                            onCompleted: (result, name, data) {
                              notifier.updateName(name);
                              _condition2.value = data;
                            },
                          );
                        }),
                  )
                ];
              },
            )
          ],
        ),
      ),
    );
  }
}
