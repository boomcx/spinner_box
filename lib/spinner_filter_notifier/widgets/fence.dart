part of '../spinner_filter.dart';

class _FenceCnt extends StatelessWidget {
  const _FenceCnt();

  @override
  Widget build(BuildContext context) {
    final notifier = _FilterNotiferScope.of(context);
    final tuple = _FilterGroupScope.of(context);
    final items = tuple.item1.items;
    final fenceList = items.fenceList;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...List.generate(fenceList.length, (index) {
          final data = fenceList[index];

          return Expanded(
            flex: 1,
            child: _FenceList(
              data: data,
              tuple: tuple,
              notifier: notifier,
            ),
          );
        })
      ],
    );
  }
}

class _FenceList extends StatelessWidget {
  const _FenceList({
    required this.data,
    required this.tuple,
    required this.notifier,
  });

  final List<SpinnerItem> data;
  final Tuple2<SpinnerEntity, int> tuple;
  final SpinnerFilterNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView.builder(
        padding: EdgeInsets.zero,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
        itemCount: data.length,
        itemBuilder: (context, index) {
          final item = data[index];
          return ValueListenableBuilder(
            valueListenable: item,
            builder: (context, value, child) => TapScope(
              onPressed: () {
                // notifier.itemOnClick(tuple, index);
              },
              child: _FenceListItem(
                name: item.name,
                isSelect: item.selected,
                isMuti: !tuple.item1.isRadio,
                onSelected: () {
                  notifier.itemOnSelected(tuple, index);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FenceListItem extends StatelessWidget {
  const _FenceListItem({
    required this.name,
    required this.isSelect,
    this.isMuti = false,
    this.onSelected,
  });

  final String name;
  final bool isSelect;
  final bool isMuti;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    Widget icon = isSelect ? _Assets.name('single_select') : const SizedBox();
    if (isMuti) {
      icon = isSelect
          ? _Assets.name('muti_select')
          : _Assets.name('muti_unselect');
    }
    return Container(
      color: Colors.white,
      height: 30,
      child: Row(
        children: [
          Expanded(
            child: Text(
              name,
              style: TextStyle(
                color: isSelect
                    ? const Color(0xffE72410)
                    : const Color(0xff20263A),
                fontSize: 14,
                fontWeight: isSelect ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onSelected,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: icon,
            ),
          ),
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}

extension _DataTierX on List<SpinnerItem> {
  /// 获取层级
  int get tier {
    int count = 0;
    runLoop(List<SpinnerItem> list, int floor) {
      for (var e in list) {
        if (floor > count) {
          count = floor;
        }
        if (e.items.isNotEmpty) {
          runLoop(e.items, floor + 1);
        } else {
          continue;
        }
      }
    }

    runLoop(this, 1);
    return count;
  }

  List<List<SpinnerItem>> get fenceList {
    final result = <List<SpinnerItem>>[];
    result.add(this);

    runLoop(List<SpinnerItem> list) {
      for (var e in list) {
        if (e.selected) {
          result.add(e.items);
          runLoop(e.items);
        }
      }
    }

    runLoop(this);

    if (result.length < tier) {
      result.addAll(
        List.generate(tier - result.length, (_) => <SpinnerItem>[]),
      );
    }

    return result;
  }
}
