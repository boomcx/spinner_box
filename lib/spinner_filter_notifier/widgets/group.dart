part of '../spinner_filter.dart';

class _GroupContent extends StatelessWidget {
  const _GroupContent();

  @override
  Widget build(BuildContext context) {
    final group = _FilterGroupScope.of(context).item1;

    return SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _GroupHeader(),
            if (group.entity.type == MoreContentType.checkList)
              const _CheckListCnt(),
            if (group.entity.type == MoreContentType.groupBtn)
              const _GroupBtnsCnt(),
          ],
        ));
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader();

  @override
  Widget build(BuildContext context) {
    final group = _FilterGroupScope.of(context).item1;

    if (group.entity.title.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Wrap(
        spacing: 8,
        children: [
          Text(
            group.entity.title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          if (group.entity.desc.isNotEmpty)
            _ExplainIcon(desc: group.entity.desc),
          if (group.entity.suffixIcon.isNotEmpty)
            Image.asset(
              group.entity.suffixIcon,
              height: 15,
              fit: BoxFit.fitHeight,
              package: 'spinner_box',
            ),
          // const Icon(Icons.hotel_class_sharp,
          //     size: 16, color: Colors.black26),
          // Assets.images.searchIconVip
          //     .image(width: 32, height: 16, fit: BoxFit.contain)
        ],
      ),
    );
  }
}

class _CheckListCnt extends StatelessWidget {
  const _CheckListCnt();

  @override
  Widget build(BuildContext context) {
    final notifier = _FilterNotiferScope.of(context);

    final tuple = _FilterGroupScope.of(context);
    final items = tuple.item1.changeList;

    return ListView.builder(
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
    );
  }
}

class _GroupBtnsCnt extends StatelessWidget {
  const _GroupBtnsCnt();

  @override
  Widget build(BuildContext context) {
    final notifier = _FilterNotiferScope.of(context);
    final tuple = _FilterGroupScope.of(context);
    final items = tuple.item1.changeList;

    return Wrap(spacing: 10, runSpacing: 10, children: [
      ...List.generate(
        items.length,
        (index) {
          final item = items[index];
          return ValueListenableBuilder(
            valueListenable: item,
            builder: (context, value, child) => _Button(
              item.data.name,
              item.selected,
              onPressed: () {
                notifier.itemOnClick(tuple, index);
              },
            ),
          );
        },
      ),
    ]);
  }
}
