part of '../spinner_filter.dart';

class _ExplainIcon extends StatelessWidget {
  const _ExplainIcon({
    required this.desc,
  });

  final String desc;

  @override
  Widget build(BuildContext context) {
    final theme = BoxTheme.of(context).header;
    return PopupMessage(
      bgColor: Colors.black54,
      content: Text(desc, style: theme.descStyle),
      child: Icon(
        Icons.help_outline_outlined,
        size: theme.iconSize,
        color: Colors.black26,
      ),
    );
  }
}
