import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';
import 'package:spinner_box_example/data.dart';

class FencePage extends StatefulWidget {
  const FencePage({super.key});

  @override
  State<FencePage> createState() => _FencePageState();
}

class _FencePageState extends State<FencePage> {
  final _condition1 = ValueNotifier(
    fence(key: '', isRadio: false, count: 10),
  );
  final _condition2 = ValueNotifier(
    fence(key: '', isRadio: true, count: 10),
  );
  final _result = ValueNotifier<List<dynamic>>([]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('栅栏样式')),
      body: Column(
        children: [
          SpinnerBox.builder(
            titles: const ['栅栏选择', '单选条件'],
            builder: (notifier) {
              return [
                ValueListenableBuilder(
                  valueListenable: _condition1,
                  builder: (context, value, child) {
                    return SpinnerFence(
                      data: value,
                      onCompleted: (results, names, data, onlyClosed) {
                        notifier.updateName(names);
                        _result.value = results.map((e) => e.result).toList();
                        _condition1.value = data;
                      },
                    );
                  },
                ).heightPart,
                ValueListenableBuilder(
                  valueListenable: _condition2,
                  builder: (context, value, child) {
                    return SpinnerFence(
                      data: value,
                      onCompleted: (results, names, data, onlyClosed) {
                        notifier.updateName(names);
                        _result.value = results.map((e) => e.result).toList();
                        _condition2.value = data;
                      },
                    );
                  },
                ).heightPart,
              ];
            },
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: ValueListenableBuilder(
              valueListenable: _result,
              builder: (context, value, child) {
                return Text('筛选结果: $value');
              },
            ),
          ),
        ],
      ),
    );
  }
}
