part of '../spinner_filter.dart';

class _FenceCnt extends StatelessWidget {
  const _FenceCnt();

  @override
  Widget build(BuildContext context) {
    final notifier = _FilterNotiferScope.of(context);
    final tuple = _FilterGroupScope.of(context);
    final items = tuple.item1.notifierList;

    return Row(
      children: [
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ValueListenableBuilder(
              valueListenable: item,
              builder: (context, value, child) => TapScope(
                onPressed: () {
                  notifier.itemOnClick(tuple, index);
                },
                child: _CheckListItem(
                  name: item.data.name,
                  isSelect: item.selected,
                  isMuti: !tuple.item1.entity.isRadio,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
