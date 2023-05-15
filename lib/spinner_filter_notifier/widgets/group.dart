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
            if (group.type == MoreContentType.checkList) const _CheckListCnt(),
            if (group.type == MoreContentType.groupBtn) const _GroupBtnsCnt(),
            // if (group.type == MoreContentType.fence) const _FenceCnt(),
          ],
        ));
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader();

  @override
  Widget build(BuildContext context) {
    final group = _FilterGroupScope.of(context).item1;

    if (group.title.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Wrap(
        spacing: 8,
        children: [
          Text(
            group.title,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          if (group.desc.isNotEmpty) _ExplainIcon(desc: group.desc),
          if (group.suffixIcon.isNotEmpty)
            Image.asset(
              group.suffixIcon,
              height: 15,
              fit: BoxFit.fitHeight,
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
    final items = tuple.item1.items;

    return ListView.builder(
      padding: EdgeInsets.zero,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return ValueListenableBuilder(
          valueListenable: item,
          builder: (context, value, child) => TapScope(
            onPressed: () {
              notifier.itemOnSelected(tuple, index);
            },
            child: _CheckListItem(
              name: item.name,
              isSelect: item.selected,
              isMulti: !tuple.item1.isRadio,
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
    final items = tuple.item1.items;

    return Wrap(spacing: 10, runSpacing: 10, children: [
      ...List.generate(items.length, (index) {
        final item = items[index];
        return ValueListenableBuilder(
          valueListenable: item,
          builder: (context, value, child) => Button(
            item.name,
            item.selected,
            onPressed: () {
              notifier.itemOnSelected(tuple, index);
            },
          ),
        );
      }),
      ...List.generate(notifier.attachment.length, (index) {
        final attach = notifier.attachment[index];
        if (attach.groupKey == tuple.item1.key) {
          return attach;
        }
        return const SizedBox();
      })
    ]);
  }
}
