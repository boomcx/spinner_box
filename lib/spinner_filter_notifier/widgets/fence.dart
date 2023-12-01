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
              final List<SpinnerItemData> data = notifier.getColumn(index);

              return Expanded(
                flex: 1,
                child: _FenceList(
                  column: index,
                  data: data,
                  notifier: notifier,
                  isLast: index == value.idxList.length - 1,
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
  const _FenceList(
      {required this.column,
      required this.data,
      required this.notifier,
      this.isLast = false});

  final int column;
  final bool isLast;
  final List<SpinnerItemData> data;
  final SpinnerFenceNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final theme = SpinnerBoxTheme.of(context).fence;
    final columnColor = theme.backgroundColors.length > column
        ? theme.backgroundColors[column]
        : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: columnColor,
        border: Border(
          right: BorderSide(
            width: isLast ? 0 : 0.5,
            color: const Color(0xfff5f5f5),
          ),
        ),
      ),
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
                if (isLast) {
                  notifier.itemOnSelected(index, column);
                } else {
                  notifier.itemOnHightlighted(index, column);
                }
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

  final SpinnerItemData item;
  final int column;
  final int index;
  final SpinnerFenceNotifier notifier;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = SpinnerBoxTheme.of(context).column;
    final fence = SpinnerBoxTheme.of(context).fence;

    Widget icon = item.selected
        ? (theme.icon1 ?? Assets.name('single_select'))
        : (theme.icon2 ?? const SizedBox());
    if (!notifier.value.data.isRadio) {
      if (item.selected) {
        icon = item.isSelectedAll
            ? (theme.iconMulti1 ?? Assets.name('muti_select'))
            : (theme.iconMulti3 ?? Assets.name('muti_select_not_all'));
      } else {
        icon = (theme.iconMulti2 ?? Assets.name('muti_unselect'));
      }
    }

    var color = Colors.transparent;
    if (index == notifier.value.idxList[column] &&
        column < notifier.value.idxList.length - 1) {
      color = fence.hightlightedColors.length > column
          ? fence.hightlightedColors[column]
          : const Color(0xfff7f7f7);
    }

    return Container(
      color: color,
      height: fence.height,
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              item.name,
              style:
                  item.selected ? theme.selectedStyle : theme.unselectedStyle,
              overflow: TextOverflow.ellipsis,
              maxLines: theme.maxLine,
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
