import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';
import 'package:spinner_box_example/data.dart';

class ThemeHeaderPage extends StatefulWidget {
  const ThemeHeaderPage({super.key});

  @override
  State<ThemeHeaderPage> createState() => _ThemeHeaderPageState();
}

class _ThemeHeaderPageState extends State<ThemeHeaderPage> {
  var _condition1 = [
    years(key: 'year1'),
  ];

  var _condition2 = [
    years(key: 'year2', type: MoreContentType.wrap),
  ];

  Map<String, List<dynamic>> _result = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('单选操作')),
      body: Column(
        children: [
          SpinnerBox.rebuilder(
            titles: [
              SpinnerData('单选条件', icon: 'assets/icon.png'),
              SpinnerData('单选条件'),
            ],
            theme: defaultPinnerTheme.copyWith(
              textDirection: TextDirection.rtl,
              iconSize: 50,
            ),
            builder: (notifier) {
              return [
                SpinnerFilter(
                  data: _condition1,
                  onCompleted: (result, name, data, onlyClosed) {
                    notifier.updateName(name);
                    _condition1 = data;
                    setState(() {
                      _result = result;
                    });
                  },
                ).heightPart,
                SpinnerFilter(
                  data: _condition2,
                  onCompleted: (result, name, data, onlyClosed) {
                    notifier.updateName(name);
                    _condition2 = data;
                    setState(() {
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
