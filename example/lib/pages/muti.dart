import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';
import '/data.dart';

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
    years(key: 'year2', type: MoreContentType.wrap, isRadio: false, count: 15),
  ];

  var _condition3 = [
    text(key: 'text1', type: MoreContentType.column, count: 8, isRadio: false),
    text(key: 'text1', type: MoreContentType.wrap, count: 15),
    text(key: 'text2', type: MoreContentType.wrap, isRadio: false, count: 8),
  ];

  Map<String, List<dynamic>> _result = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('多选操作')),
      body: Column(
        children: [
          SpinnerBox.rebuilder(
            titles: const ['多选条件', '多选条件', '混合条件+拦截'].toSpinnerData,
            builder: (notifier) {
              return [
                SpinnerFilter(
                  data: _condition1,
                  onCompleted: (result, name, data, onlyClosed) {
                    _condition1 = data;
                    notifier.updateName(name);
                    setState(() {
                      _result = result;
                    });
                  },
                ).heightPart,
                SpinnerFilter(
                  data: _condition2,
                  onCompleted: (result, name, data, onlyClosed) {
                    _condition2 = data;
                    notifier.updateName(name);
                    setState(() {
                      _result = result;
                    });
                  },
                ).heightPart,
                SpinnerFilter(
                  data: _condition3,
                  onItemIntercept: (entity, item, index) async {
                    // 可以从数据源来确定拦截按钮，也可以从点击时通过额外逻辑来判定
                    // 但按钮置灰样式只能通过数据源配置处理
                    if (item.isItemIntercept ||
                        (entity.key == 'text2' && index == 2)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('欸~ 就是选不了~')),
                      );
                      return true;
                    }
                    return false;
                  },
                  onCompleted: (result, name, data, onlyClosed) {
                    _condition3 = data;
                    notifier.updateName(name);
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
