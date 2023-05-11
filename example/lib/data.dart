import 'dart:math';

import 'package:spinner_box/spinner_box.dart';

SpinnerEntity years({
  String key = 'year',
  bool isRadio = true,
  int count = 5,
  MoreContentType type = MoreContentType.checkList,
}) {
  return SpinnerEntity(
      key: key,
      title: '条件标题',
      isRadio: isRadio,
      type: type,
      desc: type == MoreContentType.checkList
          ? ''
          : '描述文本描述文本描述文本描述文本描述文本描述文本描述文本描述文本',
      items: [
        SpinnerItem(name: '全部', result: '', selected: true, isMutex: true),
        ...List.generate(
            count, (index) => (DateTime.now().year - index).toString()).map(
          (e) => SpinnerItem.fromJson({'name': e, 'result': e}),
        ),
      ]);
}

SpinnerEntity text({
  String key = 'text',
  bool isRadio = true,
  int count = 8,
  MoreContentType type = MoreContentType.checkList,
}) {
  return SpinnerEntity(
      key: key,
      title: '条件标题',
      isRadio: isRadio,
      type: type,
      desc: type == MoreContentType.checkList
          ? ''
          : '描述文本描述文本描述文本描述文本描述文本描述文本描述文本描述文本',
      items: [
        SpinnerItem(name: '全部', result: '', selected: true, isMutex: true),
        ...List.generate(count, (index) {
          const text = '庆历四年春滕子京谪守巴陵郡越明年政通人和百废具兴乃重修岳阳楼增其旧制刻唐贤今人诗赋于其上属予作文以记之';
          final space = Random().nextInt(3) + 2;
          final posi = max(Random().nextInt(text.length) - space, 0);
          final name = text.substring(posi, posi + space);
          return SpinnerItem.fromJson({'name': name, 'result': name});
        }),
      ]);
}

SpinnerEntity fence({
  String key = 'text',
  bool isRadio = true,
  int count = 8,
}) {
  return SpinnerEntity(
      key: key,
      title: '条件标题',
      isRadio: isRadio,
      type: MoreContentType.fence,
      desc: '描述文本描述文本描述文本描述文本描述文本描述文本描述文本描述文本',
      items: [
        SpinnerItem(name: '全部', result: '', selected: true, isMutex: true),
        ...List.generate(count, (index) {
          const text = '庆历四年春滕子京谪守巴陵郡越明年政通人和百废具兴乃重修岳阳楼增其旧制刻唐贤今人诗赋于其上属予作文以记之';
          final space = Random().nextInt(3) + 2;
          final posi = max(Random().nextInt(text.length) - space, 0);
          final name = text.substring(posi, posi + space);

          return SpinnerItem(name: name, result: name, items: [
            ...List.generate(count + space, (index) {
              const text =
                  '庆历四年春滕子京谪守巴陵郡越明年政通人和百废具兴乃重修岳阳楼增其旧制刻唐贤今人诗赋于其上属予作文以记之';
              final space = Random().nextInt(3) + 2;
              final posi = max(Random().nextInt(text.length) - space, 0);
              final name = text.substring(posi, posi + space);
              return SpinnerItem(name: name, result: name);
            }),
          ]);
        }),
      ]);
}
