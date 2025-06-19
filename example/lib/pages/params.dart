import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';

import '../data.dart';

class SelectParamsPage extends StatefulWidget {
  const SelectParamsPage({super.key});

  @override
  State<SelectParamsPage> createState() => _SelectParamsPageState();
}

class _SelectParamsPageState extends State<SelectParamsPage> {
  final controller = PopupValueNotifier.titles(
    const ['默认选中参数'].toSpinnerData,
  );

  final data = text(key: 'text1', type: MoreContentType.wrap, count: 15);
  var _condition = <SpinnerEntity>[];

  @override
  void initState() {
    super.initState();
    data.items[0].selected = SCheckedStatus.unchecked;
    data.items[1].selected = SCheckedStatus.checked;
    data.items[2].selected = SCheckedStatus.checked;
    _condition.add(data);

    controller.updateName('手动设置的默认参数标题', index: 0);
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
                controller: controller,
                // titles: const ['默认选中参数'].toSpinnerData,
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
