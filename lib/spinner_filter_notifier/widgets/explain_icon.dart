part of '../spinner_filter.dart';

class _ExplainIcon extends StatelessWidget {
  const _ExplainIcon({
    required this.desc,
  });

  final String desc;

  @override
  Widget build(BuildContext context) {
    return PopupMessage(
      bgColor: Colors.black54,
      content: Text(
        desc,
        style: const TextStyle(color: Colors.white, height: 1, fontSize: 13),
      ),
      child: const Icon(
        Icons.help_outline_outlined,
        size: 15,
        color: Colors.black26,
      ),
    );
  }
}
