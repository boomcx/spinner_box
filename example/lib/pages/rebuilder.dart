import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';

import '../data.dart';

class RebuilderPage extends StatefulWidget {
  const RebuilderPage({super.key});

  @override
  State<RebuilderPage> createState() => _RebuilderPageState();
}

class _RebuilderPageState extends State<RebuilderPage> {
  var _condition1 = [
    text(key: 'text1', type: MoreContentType.wrap, count: 15),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Rebuilder')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('''
每一次打开筛选弹框都会重新构建筛选视图，所以当筛选条件改变时并不需要通知视图刷新
'''),
            const SizedBox(height: 10),
            SpinnerBox.rebuilder(
                titles: const ['Rebuilder'].toSpinnerData,
                builder: (notifier) => [
                      SpinnerFilter(
                        data: _condition1,
                        onCompleted: (result, name, data, onlyClosed) {
                          notifier.updateName(name);
                          _condition1 = data;
                        },
                      ).heightPart,
                    ]),
          ],
        ),
      ),
    );
  }
}
