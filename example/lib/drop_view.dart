// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import 'package:spinner_box/spinner_box.dart';

class DropViewPage extends StatefulWidget {
  const DropViewPage({super.key});

  @override
  State<DropViewPage> createState() => _DropViewPageState();
}

class _DropViewPageState extends State<DropViewPage> {
  final _textEditing = TextEditingController();
  final _controller = PopupValueNotifier.titles(const ['单列表', '传入自定义视图']);
  var _filterData = def;

  @override
  void initState() {
    super.initState();
    _controller.setHighlight(true, 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('下拉筛选框')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const TextField(
              decoration: InputDecoration(hintText: 'input hint'),
            ),
            const _Title(name: 'children构建'),
            SpinnerBox(
              controller: _controller,
              theme: defaultPinnerTheme.copyWith(outsideFocus: true),
              children: [
                SpinnerFilter(
                  data: [
                    SpinnerEntity(
                        key: 'year',
                        type: MoreContentType.checkList,
                        items: [
                          const SpinnerItem(name: '不限', value: ''),
                          ...List.generate(5, (index) {
                            final year =
                                (DateTime.now().year - index).toString();
                            return SpinnerItem(name: year, value: year);
                          }),
                        ])
                  ],
                  onCompleted: (result, name, data) {
                    _controller.updateName(name);
                  },
                ).heightPart,
                SpinnerFilter(
                  data: _filterData,
                  attachment: [
                    // const Tuple2(2, Text('attachment1')),
                    // Tuple2(
                    //     2,
                    //     Container(
                    //       height: 130,
                    //       color: Colors.red,
                    //       child: const Text('attachment2'),
                    //     )),
                    MyWidget2(data: _filterData),
                    MyWidget1(_textEditing, data: _filterData),
                  ],
                  onReseted: () {},
                  onItemIntercept: (p0, p1) {
                    if (p1 == 2) {
                      // ignore: avoid_print
                      print('key = ${p0.key}; index = 2, 我拦截的选中事件');
                      return true;
                    }
                    return false;
                  },
                  onCompleted: (result, name, data) {
                    _controller.updateName(name);

                    // 建议局部刷新/状态管理
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {
                        _filterData = data;
                      });
                    });
                  },
                ).heightPart,
              ],
            ),
            const _GroupView('builder构建'),
            const _GroupView(
              '并排其他组件',
              suffix: Text('后置视图'),
              prefix: Text('前置视图'),
            ),
            _GroupView(
              '并排输入框（焦点脱离）',
              prefix: Container(
                width: 200,
                color: Colors.white,
                padding: const EdgeInsets.all(5),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: '点击输入框关闭筛选弹框',
                    hintStyle: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// 仅需要`key`和`extraData`
class MyWidget1 extends AttachmentView {
  MyWidget1(this.textEditing, {super.key, required super.data});
  final TextEditingController textEditing;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      child: TextField(
        controller: textEditing,
        decoration: const InputDecoration(hintText: 'MyWidget1 input'),
        onChanged: (value) {
          updateExtra(value);
        },
      ),
    );
  }

  @override
  void reset() {
    super.reset();
    textEditing.clear();
  }

  @override
  String get groupKey => 'group2';
}

class MyWidget2 extends AttachmentView {
  MyWidget2({super.key, required super.data});
  final textEditing = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.greenAccent,
      child: TextField(
        controller: textEditing,
        decoration: const InputDecoration(hintText: 'MyWidget2 input'),
        onChanged: (value) {
          updateExtra(value);
        },
      ),
    );
  }

  @override
  void reset() {
    super.reset();
    textEditing.clear();
  }

  @override
  String get groupKey => 'group1';
}

class _GroupView extends StatelessWidget {
  const _GroupView(this.name, {this.prefix, this.suffix});

  final String name;

  /// 前置视图
  final Widget? prefix;

  /// 后置视图
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Title(name: name),
        _FilterView(
          suffix: suffix,
          prefix: prefix,
        ),
      ],
    );
  }
}

class _Title extends StatelessWidget {
  const _Title({
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      alignment: Alignment.centerLeft,
      color: Colors.red[100],
      child: Text(
        name,
        style: Theme.of(context).textTheme.titleSmall,
      ),
    );
  }
}

class _FilterView extends StatelessWidget {
  const _FilterView({
    this.prefix,
    this.suffix,
  });

  /// 前置视图
  final Widget? prefix;

  /// 后置视图
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return SpinnerBox.rebuilder(
      prefix: prefix,
      suffix: suffix,
      titles: const ['单列表', '状态保留'],
      theme: defaultPinnerTheme.copyWith(outsideFocus: true),
      builder: (p0) => [
        SpinnerFilter(
          data: [
            SpinnerEntity(key: 'year', type: MoreContentType.checkList, items: [
              const SpinnerItem(name: '不限', value: ''),
              ...List.generate(5, (index) {
                final year = (DateTime.now().year - index).toString();
                return SpinnerItem(name: year, value: year);
              }),
            ])
          ],
          onCompleted: (result, name, data) {
            p0.updateName(name);
          },
        ).heightPart,
        SpinnerFilter(
          data: def,
          onCompleted: (result, name, data) {
            p0.updateName(name);
          },
        ).heightPart,
      ],
    );
  }
}

var def = [
  SpinnerEntity(
      key: 'group1',
      title: '分组1-多选',
      isRadio: false,
      suffixIcon: 'assets/icon.png',
      items: [
        const SpinnerItem(name: '不限', value: '', isMutex: true),
        ...List.generate(10, (index) {
          return SpinnerItem(name: '分组1-$index', value: index);
        }),
      ]),
  SpinnerEntity(key: 'group2', title: '分组2-单选', items: [
    const SpinnerItem(name: '不限', value: ''),
    ...List.generate(10, (index) {
      return SpinnerItem(name: '分组2-$index', value: index);
    }),
  ]),
  SpinnerEntity(
      desc: '9999999999999999999999999999999999999999999999',
      key: 'group3',
      title: '分组3-多选',
      isRadio: false,
      type: MoreContentType.checkList,
      items: [
        ...List.generate(3, (index) {
          return SpinnerItem(name: '分组3-$index', value: index);
        }),
      ]),
  SpinnerEntity(
      key: 'group4',
      title: '分组4-单选',
      type: MoreContentType.checkList,
      items: [
        ...List.generate(3, (index) {
          return SpinnerItem(name: '分组4-$index', value: index);
        }),
      ]),
];

// import 'package:flutter/material.dart';
// import 'package:hooks_riverpod/hooks_riverpod.dart';
// import 'package:riverpod_annotation/riverpod_annotation.dart';
// import 'package:freezed_annotation/freezed_annotation.dart';

// import 'package:spinner_box/spinner_box.dart';
// import 'package:tuple/tuple.dart';

// part 'drop_view.freezed.dart';
// part 'drop_view.g.dart';

// class DropViewPage extends ConsumerWidget {
//   const DropViewPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final textEditing = TextEditingController();
//     final controller = PopupValueNotifier.titles(const ['单列表', '传入自定义视图']);
//     final name =
//         ref.watch(dropViewControllerProvider.select((value) => value.name));

//     return Scaffold(
//       appBar: AppBar(title: Text(name)),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             const TextField(
//               decoration: InputDecoration(hintText: 'input hint'),
//             ),
//             const _Title(name: 'children构建'),
//             SpinnerBox(
//               controller: controller,
//               children: [
//                 SpinnerFilter(
//                   data: [
//                     SpinnerFilterEntity(
//                         key: 'year',
//                         type: MoreContentType.checkList,
//                         items: [
//                           const SpinnerFilterItem(name: '不限', value: ''),
//                           ...List.generate(5, (index) {
//                             final year =
//                                 (DateTime.now().year - index).toString();
//                             return SpinnerFilterItem(name: year, value: year);
//                           }),
//                         ])
//                   ],
//                   onCompleted: (result, name, data) {
//                     controller.updateName(name);
//                   },
//                 ).heightPart,
//                 Consumer(
//                   builder: (context, ref, child) {
//                     final data = ref.watch(dropViewControllerProvider
//                         .select((value) => value.years));
//                     return SpinnerFilter(
//                       data: data,
//                       attachment: [
//                         const Tuple2(-1, Text('attachment1')),
//                         Tuple2(
//                             2,
//                             Container(
//                               height: 130,
//                               color: Colors.red,
//                               child: const Text('attachment2'),
//                             )),
//                         Tuple2(
//                           2,
//                           TextField(
//                             controller: textEditing,
//                             decoration:
//                                 const InputDecoration(hintText: 'input hint'),
//                           ),
//                         ),
//                       ],
//                       onReseted: () {
//                         textEditing.clear();
//                       },
//                       onCompleted: (result, name, data) {
//                         controller.updateName(name + textEditing.text);
//                         ref
//                             .read(dropViewControllerProvider.notifier)
//                             .updateYears(data);
//                       },
//                     );
//                   },
//                 ).heightPart,
//               ],
//             ),
//             const _GroupView('builder构建'),
//             const _GroupView(
//               '并排其他组件',
//               suffix: Text('尾部视图'),
//               prefix: Text('前置视图'),
//             ),
//             _GroupView(
//               '并排输入框（焦点脱离）',
//               prefix: Container(
//                 width: 200,
//                 color: Colors.white,
//                 padding: const EdgeInsets.all(5),
//                 child: TextField(
//                   decoration: InputDecoration(
//                     hintText: '点击输入框关闭筛选弹框',
//                     hintStyle: Theme.of(context).textTheme.bodySmall,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class _GroupView extends StatelessWidget {
//   const _GroupView(
//     this.name, {
//     super.key,
//     this.prefix,
//     this.suffix,
//   });

//   final String name;

//   /// 前置视图
//   final Widget? prefix;

//   /// 后置视图
//   final Widget? suffix;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _Title(name: name),
//         _FilterView(
//           suffix: suffix,
//           prefix: prefix,
//         ),
//       ],
//     );
//   }
// }

// class _Title extends StatelessWidget {
//   const _Title({
//     super.key,
//     required this.name,
//   });

//   final String name;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.all(10),
//       alignment: Alignment.centerLeft,
//       color: Colors.red[100],
//       child: Text(
//         name,
//         style: Theme.of(context).textTheme.titleSmall,
//       ),
//     );
//   }
// }

// class _FilterView extends StatelessWidget {
//   const _FilterView({
//     super.key,
//     this.prefix,
//     this.suffix,
//   });

//   /// 前置视图
//   final Widget? prefix;

//   /// 后置视图
//   final Widget? suffix;

//   @override
//   Widget build(BuildContext context) {
//     return SpinnerBox.builder(
//       prefix: prefix,
//       suffix: suffix,
//       titles: const ['单列表', '状态保留'],
//       theme: defaultPinnerTheme.copyWith(outsideFocus: true),
//       builder: (p0) => [
//         SpinnerFilter(
//           data: [
//             SpinnerFilterEntity(
//                 key: 'year',
//                 type: MoreContentType.checkList,
//                 items: [
//                   const SpinnerFilterItem(name: '不限', value: ''),
//                   ...List.generate(5, (index) {
//                     final year = (DateTime.now().year - index).toString();
//                     return SpinnerFilterItem(name: year, value: year);
//                   }),
//                 ])
//           ],
//           onCompleted: (result, name, data) {
//             p0.updateName(name);
//           },
//         ).heightPart,
//         Consumer(
//           builder: (context, ref, child) {
//             final data = ref.watch(
//                 dropViewControllerProvider.select((value) => value.years));
//             return SpinnerFilter(
//               data: data,
//               onCompleted: (result, name, data) {
//                 p0.updateName(name);
//                 ref.read(dropViewControllerProvider.notifier).updateYears(data);
//               },
//             );
//           },
//         ).heightPart,
//       ],
//     );
//   }
// }

// @freezed
// class DropViewState with _$DropViewState {
//   const factory DropViewState({
//     @Default([]) List<SpinnerFilterEntity> years,
//     @Default('下拉筛选框') String name,
//   }) = _DropViewState;
//   factory DropViewState.fromJson(Map<String, Object?> json) =>
//       _$DropViewStateFromJson(json);
// }

// @riverpod
// class DropViewController extends _$DropViewController {
//   @override
//   DropViewState build() {
//     getYears();
//     return const DropViewState();
//   }

//   getYears() async {
//     await Future.delayed(const Duration(seconds: 3));
//     updateYears(def);
//   }

//   updateYears(data) {
//     state = state.copyWith(years: data);
//   }
// }
