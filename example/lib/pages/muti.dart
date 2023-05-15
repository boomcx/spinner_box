import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';
import 'package:spinner_box_example/data.dart';

class MultiPage extends StatefulWidget {
  const MultiPage({super.key});

  @override
  State<MultiPage> createState() => _MultiPageState();
}

class _MultiPageState extends State<MultiPage> {
  var _condition1 = [
    years(key: 'year1', isRadio: false),
  ];

  var _condition2 = [
    years(
        key: 'year2',
        type: MoreContentType.groupBtn,
        isRadio: false,
        count: 15),
  ];

  var _condition3 = [
    years(key: 'year3', isRadio: true, count: 3),
    text(key: 'text1', type: MoreContentType.groupBtn, count: 15),
    text(
        key: 'text2', type: MoreContentType.groupBtn, isRadio: false, count: 8),
  ];

  Map<String, List<dynamic>> _result = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('多选操作')),
      body: Column(
        children: [
          SpinnerBox.rebuilder(
            titles: const ['多选条件', '多选条件', '混合条件+拦截'],
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
                SpinnerFilter(
                  data: _condition2,
                  onCompleted: (result, name, data) {
                    notifier.updateName(name);
                    setState(() {
                      _condition2 = data;
                      _result = result;
                    });
                  },
                ).heightPart,
                SpinnerFilter(
                  data: _condition3,
                  onItemIntercept: (p0, p1) {
                    if (p0.key == 'text2' && p1 == 2) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('欸~ 就是选不了~')),
                      );
                      return true;
                    }
                    return false;
                  },
                  onCompleted: (result, name, data) {
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
