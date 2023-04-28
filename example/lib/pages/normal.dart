import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';
import 'package:spinner_box_example/data.dart';

class SinglePage extends StatefulWidget {
  const SinglePage({super.key});

  @override
  State<SinglePage> createState() => _SinglePageState();
}

class _SinglePageState extends State<SinglePage> {
  var _condition1 = [
    years(key: 'year1'),
  ];

  var _condition2 = [
    years(key: 'year2', type: MoreContentType.groupBtn),
  ];

  Map<String, List<dynamic>> _result = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('单选操作')),
      body: Column(
        children: [
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
