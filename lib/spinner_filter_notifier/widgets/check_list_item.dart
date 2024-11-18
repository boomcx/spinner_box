part of '../spinner_filter.dart';

class _CheckListItem extends StatelessWidget {
  const _CheckListItem(
    this.name,
    this.isSelect,
    this.isIntercept, {
    this.onPressed,
    this.isMulti = false,
  });

  final String name;
  final bool isSelect;
  final bool isIntercept;
  final bool isMulti;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = SpinnerBoxTheme.of(context).column;

    final style = isIntercept
        ? theme.interceptStyle
        : (isSelect ? theme.selectedStyle : theme.unselectedStyle);
    Widget icon = const SizedBox.shrink();
    if (!isIntercept) {
      if (isMulti) {
        icon = isSelect
            ? (theme.iconMulti1 ?? Assets.name('muti_select'))
            : (theme.iconMulti2 ?? Assets.name('muti_unselect'));
      } else {
        icon = isSelect
            ? (theme.icon1 ?? Assets.name('single_select'))
            : (theme.icon2 ?? const SizedBox());
      }
    }

    return TapScope(
      onPressed: onPressed,
      child: SizedBox(
        height: theme.height,
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: style,
                overflow: TextOverflow.ellipsis,
                maxLines: theme.maxLine,
              ),
            ),
            icon,
            const SizedBox(width: 6),
          ],
        ),
      ),
    );
  }
}
