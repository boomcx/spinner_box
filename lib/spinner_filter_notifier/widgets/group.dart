part of '../spinner_filter.dart';

class _GroupContent extends StatelessWidget {
  const _GroupContent();

  @override
  Widget build(BuildContext context) {
    final group = _FilterGroupScope.of(context).$1;

    return Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _GroupHeader(),
            if (group.type == MoreContentType.column) const _CheckListCnt(),
            if (group.type == MoreContentType.wrap) const _GroupBtnsCnt(),
            // if (group.type == MoreContentType.fence) const _FenceCnt(),
          ],
        ));
  }
}

class _GroupHeader extends StatelessWidget {
  const _GroupHeader();

  @override
  Widget build(BuildContext context) {
    final group = _FilterGroupScope.of(context).$1;
    final theme = SpinnerBoxTheme.of(context).header;

    if (group.title.isEmpty) return const SizedBox();

    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Wrap(
        spacing: theme.spacing,
        children: [
          Text(group.title, style: theme.style),
          if (group.desc.isNotEmpty) _ExplainIcon(desc: group.desc),
          if (group.titleSuffix.isNotEmpty)
            Image.asset(
              group.titleSuffix,
              height: 15,
              fit: BoxFit.fitHeight,
            ),
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
    final data = _FilterGroupScope.of(context);
    final items = data.$1.items;

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
              notifier.itemOnSelected(data, index);
            },
            child: _CheckListItem(
              name: item.name,
              isSelect: item.selected,
              isMulti: !data.$1.isRadio,
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
    final data = _FilterGroupScope.of(context);
    final theme = SpinnerBoxTheme.of(context).wrap;
    final items = data.$1.items;

    return Wrap(
        spacing: theme.spacing,
        runSpacing: theme.runSpacing,
        children: [
          ...List.generate(items.length, (index) {
            final item = items[index];
            return ValueListenableBuilder(
              valueListenable: item,
              builder: (context, value, child) => WrapButton(
                item.name,
                item.selected,
                onPressed: () {
                  notifier.itemOnSelected(data, index);
                },
              ),
            );
          }),
          ...List.generate(notifier.attachment.length, (index) {
            final attach = notifier.attachment[index];
            if (attach.groupKey == data.$1.key) {
              return attach;
            }
            return const SizedBox();
          })
        ]);
  }
}
