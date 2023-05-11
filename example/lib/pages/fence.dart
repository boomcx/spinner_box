import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';
import 'package:spinner_box_example/data.dart';

class FencePage extends StatefulWidget {
  const FencePage({super.key});

  @override
  State<FencePage> createState() => _FencePageState();
}

class _FencePageState extends State<FencePage> {
  final _condition1 = ValueNotifier([
    fence(key: 'fence1', isRadio: false),
  ]);

  final _result = ValueNotifier<Map<String, List<dynamic>>>({});

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
                    return SpinnerFilter(
                      data: value,
                      scrollable: false,
                      onCompleted: (result, name, data) {
                        notifier.updateName(name);
                        _result.value = result;
                        _condition1.value = data;
                      },
                    );
                  },
                ).heightPart,
              ];
            },
          ),
          ElevatedButton(
            onPressed: () {
              print(_condition1.value.first.items.tier);

              print(_condition1.value.first.toJson());
            },
            child: const Text('sss'),
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

extension _DataTierX on List<SpinnerItem> {
  int get tier {
    int count = 0;
    runLoop(List<SpinnerItem> list, int floor) {
      for (var e in list) {
        if (floor > count) {
          count = floor;
        }
        if (e.items.isNotEmpty) {
          runLoop(e.items, floor + 1);
        } else {
          continue;
        }
      }
    }

    runLoop(this, 1);

    return count;
  }
}
