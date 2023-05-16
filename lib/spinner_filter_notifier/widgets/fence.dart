part of '../spinner_fence.dart';

class _FenceCnt extends StatefulWidget {
  const _FenceCnt();

  @override
  State<_FenceCnt> createState() => _FenceCntState();
}

class _FenceCntState extends State<_FenceCnt> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notifier = _FenceNotiferScope.of(context);

    return ValueListenableBuilder(
      valueListenable: notifier,
      builder: (context, value, child) {
        if (value.idxList.isEmpty) {
          return const SizedBox(
            width: double.infinity,
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(value.idxList.length, (index) {
              final List<SpinnerItem> data = notifier.getColumn(index);

              return Expanded(
                flex: 1,
                child: _FenceList(
                  column: index,
                  data: data,
                  notifier: notifier,
                ),
              );
            }),
          ],
        );
      },
    );
  }
}

class _FenceList extends StatelessWidget {
  const _FenceList({
    required this.column,
    required this.data,
    required this.notifier,
  });

  final int column;
  final List<SpinnerItem> data;
  final SpinnerFenceNotifier notifier;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: column == 0 ? const Color(0xfff5f5f5) : Colors.white,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return TapScope(
              onPressed: () {
                notifier.itemOnHightlighted(index, column);
              },
              child: _FenceListItem(
                item: item,
                notifier: notifier,
                column: column,
                index: index,
                onSelected: () {
                  notifier.itemOnSelected(index, column);
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

class _FenceListItem extends StatelessWidget {
  const _FenceListItem({
    required this.item,
    required this.notifier,
    this.column = 0,
    this.index = 0,
    this.onSelected,
  });

  final SpinnerItem item;
  final int column;
  final int index;
  final SpinnerFenceNotifier notifier;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    Widget icon =
        item.selected ? Assets.name('single_select') : const SizedBox();
    if (!notifier.value.data.isRadio) {
      if (item.selected) {
        icon = item.isSelectedAll
            ? Assets.name('muti_select')
            : Assets.name('muti_select_not_all');
      } else {
        icon = Assets.name('muti_unselect');
      }
    }

    var color = Colors.transparent;
    if (index == notifier.value.idxList[column] &&
        column < notifier.value.idxList.length - 1) {
      color = column == 0 ? Colors.white : const Color(0xfff7f7f7);
    }

    return Container(
      color: color,
      height: 42,
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.name,
              style: TextStyle(
                color: item.selected
                    ? const Color(0xffE72410)
                    : const Color(0xff20263A),
                fontSize: 14,
                fontWeight: item.selected ? FontWeight.w600 : FontWeight.normal,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onSelected,
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: icon,
            ),
          ),
        ],
      ),
    );
  }
}
