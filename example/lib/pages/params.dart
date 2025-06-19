import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';

import '../data.dart';

class SelectParamsPage extends StatefulWidget {
  const SelectParamsPage({super.key});

  @override
  State<SelectParamsPage> createState() => _SelectParamsPageState();
}

class _SelectParamsPageState extends State<SelectParamsPage> {
  final data = text(key: 'text1', type: MoreContentType.wrap, count: 15);
  var _condition = <SpinnerEntity>[];

  @override
  void initState() {
    super.initState();
    data.items.first.selected = false;
    data.items[2].selected = true;
    // var items = <SpinnerItemData>[];
    // for (var element in data.items) {
    //   items.add(element.copyWith(selected: true));
    // }

    _condition.add(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('默认选中参数')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('''
通过参数`SpinnerItemData`中`select`值设置，来默认显示已选中条件
'''),
            const SizedBox(height: 10),
            SpinnerBox.builder(
                titles: const ['默认选中参数'].toSpinnerData,
                builder: (notifier) => [
                      SpinnerFilter(
                        data: _condition,
                        onCompleted: (result, name, data, onlyClosed) {
                          notifier.updateName(name);
                          _condition = data;
                        },
                      ).heightPart,
                    ]),
          ],
        ),
      ),
    );
  }
}
