import 'dart:math';

import 'package:spinner_box/spinner_box.dart';

SpinnerEntity years({
  String key = 'year',
  bool isRadio = true,
  int count = 5,
  MoreContentType type = MoreContentType.column,
}) {
  return SpinnerEntity(
      key: key,
      title: '条件标题',
      isRadio: isRadio,
      type: type,
      isShowButtons: true,
      desc: type == MoreContentType.column
          ? ''
          : '描述文本描述文本描述文本描述文本描述文本描述文本描述文本描述文本',
      items: [
        SpinnerItemData(
            name: '全部',
            result: '',
            selected: SCheckedStatus.checked,
            isMutex: true),
        SpinnerItemData(name: '-', result: ''),
        ...List.generate(
            count, (index) => (DateTime.now().year - index).toString()).map(
          (e) => SpinnerItemData.fromJson({'name': e, 'result': e}),
        ),
      ]);
}

SpinnerEntity text({
  String key = 'text',
  bool isRadio = true,
  int count = 8,
  MoreContentType type = MoreContentType.column,
}) {
  return SpinnerEntity(
      key: key,
      title: '条件标题',
      isRadio: isRadio,
      type: type,
      desc: type == MoreContentType.column
          ? ''
          : '描述文本描述文本描述文本描述文本描述文本描述文本描述文本描述文本',
      items: [
        SpinnerItemData(
            name: '全部',
            result: '',
            selected: SCheckedStatus.checked,
            isMutex: true),
        ...List.generate(count, (index) {
          const text = '庆历四年春滕子京谪守巴陵郡越明年政通人和百废具兴乃重修岳阳楼增其旧制刻唐贤今人诗赋于其上属予作文以记之';
          final space = Random().nextInt(3) + 2;
          final posi = max(Random().nextInt(text.length) - space, 0);
          final name = text.substring(posi, posi + space);
          final intercept = Random().nextInt(10) > 5;
          return SpinnerItemData.fromJson(
              {'name': name, 'result': name, 'isItemIntercept': intercept});
        }),
      ]);
}

SpinnerEntity fence({
  String key = 'text',
  bool isRadio = true,
  int count = 8,
  int tier = 3,
}) {
  List<SpinnerItemData> getList(int maxLevel) {
    final space = Random().nextInt(3) + 2;

    return [
      ...List.generate(count + space, (_) {
        const text = '庆历四年春滕子京谪守巴陵郡越明年政通人和百废具兴乃重修岳阳楼增其旧制刻唐贤今人诗赋于其上属予作文以记之';
        final space = Random().nextInt(3) + 2;
        final posi = max(Random().nextInt(text.length) - space, 0);
        final name3 = text.substring(posi, posi + space);
        if (maxLevel == 1) {
          return SpinnerItemData(name: name3, result: name3);
        }
        return SpinnerItemData(
            name: name3, result: name3, items: getList(maxLevel - 1));
      }),
    ];
  }

  return SpinnerEntity(
    key: key,
    title: '条件标题',
    isRadio: isRadio,
    desc: '描述文本描述文本描述文本描述文本描述文本描述文本描述文本描述文本',
    items: getList(tier),
  );
  //  [
  //   // SpinnerItem(name: '全部', result: '', selected: true, isMutex: true),
  //   ...List.generate(count, (index) {
  //     const text = '庆历四年春滕子京谪守巴陵郡越明年政通人和百废具兴乃重修岳阳楼增其旧制刻唐贤今人诗赋于其上属予作文以记之';
  //     final space = Random().nextInt(3) + 2;
  //     final posi = max(Random().nextInt(text.length) - space, 0);
  //     final name1 = text.substring(posi, posi + space);

  //     return SpinnerItem(name: name1, result: name1, items: [
  //       ...List.generate(count + space, (index) {
  //         const text =
  //             '庆历四年春滕子京谪守巴陵郡越明年政通人和百废具兴乃重修岳阳楼增其旧制刻唐贤今人诗赋于其上属予作文以记之';
  //         final space = Random().nextInt(3) + 2;
  //         final posi = max(Random().nextInt(text.length) - space, 0);
  //         final name2 = text.substring(posi, posi + space);
  //         return SpinnerItem(
  //           name: name2,
  //           result: name2,
  //           items: [
  //             ...List.generate(count + space, (index) {
  //               const text =
  //                   '庆历四年春滕子京谪守巴陵郡越明年政通人和百废具兴乃重修岳阳楼增其旧制刻唐贤今人诗赋于其上属予作文以记之';
  //               final space = Random().nextInt(3) + 2;
  //               final posi = max(Random().nextInt(text.length) - space, 0);
  //               final name3 = text.substring(posi, posi + space);
  //               return SpinnerItem(name: name3, result: name3);
  //             }),
  //           ],
  //         );
  //       }),
  //     ]);
  //   }),
  // ]);
}
