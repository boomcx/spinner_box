import 'package:flutter/material.dart';
import 'package:spinner_box/spinner_box.dart';
import 'package:spinner_box/spinner_filter_notifier/theme/theme.dart';

import '../data.dart';

class ThemePage extends StatefulWidget {
  const ThemePage({super.key});

  @override
  State<ThemePage> createState() => _ThemePageState();
}

class _ThemePageState extends State<ThemePage> {
  final _condition1 = ValueNotifier(
    fence(key: 'fence', isRadio: false, count: 10),
  );
  final _condition2 = ValueNotifier([
    text(key: 'wrap', type: MoreContentType.wrap, count: 15, isRadio: false),
  ]);
  final _condition3 = ValueNotifier([
    text(key: 'column', type: MoreContentType.column, count: 4),
    text(
        key: 'column1', type: MoreContentType.column, count: 6, isRadio: false),
  ]);

  final _controler =
      PopupValueNotifier.titles(const ['wrap', 'column', 'fence'].toSpinnerData);

  final SpinnerBoxThemeData themeData = SpinnerBoxThemeData(
    backgroundColor: Colors.lightBlueAccent,
    wrap: SWrapThemeData(
      spacing: 10,
      runSpacing: 20,
      selectedStyle: const TextStyle(fontSize: 17, color: Colors.red),
      selectedDecoration: BoxDecoration(
        color: Colors.green,
        borderRadius: BorderRadius.circular(100),
      ),
    ),
    column: const SColumnThemeData(
      unselectedStyle: TextStyle(color: Colors.black38, fontSize: 12),
      selectedStyle: TextStyle(color: Colors.black, fontSize: 14),
      icon1: Icon(Icons.close, size: 20, color: Colors.green),
      iconMulti1: Icon(Icons.dark_mode, size: 20, color: Colors.green),
      iconMulti2:
          Icon(Icons.dark_mode_outlined, size: 20, color: Colors.black54),
      iconMulti3: Icon(Icons.sunny_snowing, size: 20, color: Colors.yellow),
    ),
    buttons: SBoxBotBtnData(
      isRest: false,
      backgroundColor: Colors.grey,
      leftTxt: '取消',
      leftStyle: const TextStyle(color: Colors.white, fontSize: 16),
      rightStyle: const TextStyle(color: Colors.yellow, fontSize: 14),
      leftDecoration: BoxDecoration(
        color: Colors.pink,
        borderRadius: BorderRadius.circular(100),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Theme')),
      body: Column(
        children: [
          const SizedBox(height: 30),
          const Text('''
通过配置主题参数`theme`实现基础的主题配置
'''),
          const SizedBox(height: 10),
          SpinnerBox(controller: _controler, children: [
            ValueListenableBuilder(
                valueListenable: _condition2,
                builder: (context, value, child) {
                  return SpinnerFilter(
                    data: value,
                    theme: themeData,
                    onCompleted: (result, name, data, onlyClosed) {
                      if (onlyClosed) {
                        _controler.closed();
                        return;
                      }
                      _controler.updateName(name);
                      _condition2.value = data;
                      // 如果调用刷新，其他`builder`下拉框会失效
                      // setState(() {});
                    },
                  );
                }).heightPart,
            ValueListenableBuilder(
                valueListenable: _condition3,
                builder: (context, value, child) {
                  return SpinnerFilter(
                    data: value,
                    theme: themeData,
                    onCompleted: (result, name, data, onlyClosed) {
                      if (onlyClosed) {
                        _controler.closed();
                        return;
                      }
                      _controler.updateName(name);
                      _condition3.value = data;
                      // 如果调用刷新，其他`builder`下拉框会失效
                      // setState(() {});
                    },
                  );
                }).heightPart,
            ValueListenableBuilder(
                valueListenable: _condition1,
                builder: (context, value, child) {
                  return SpinnerFence(
                    data: value,
                    theme: themeData,
                    onCompleted: (result, name, data, onlyClosed) {
                      if (onlyClosed) {
                        _controler.closed();
                        return;
                      }
                      _controler.updateName(name);
                      _condition1.value = data;
                      // 如果调用刷新，其他`builder`下拉框会失效
                      // setState(() {});
                    },
                  );
                }).heightPart,
          ]),
        ],
      ),
    );
  }
}
