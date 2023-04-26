part of '../spinner_filter.dart';

class _CheckListItem extends StatelessWidget {
  const _CheckListItem({
    required this.name,
    required this.isSelect,
    this.isMuti = false,
  });

  final String name;
  final bool isSelect;
  final bool isMuti;

  @override
  Widget build(BuildContext context) {
    Widget icon = isSelect
        ? const Icon(Icons.check, size: 18, color: Colors.red)
        : const SizedBox();
    // isSelect ? Assets.images.icSelectS.image(width: 16) : const SizedBox();
    if (isMuti) {
      icon = isSelect
          ? const Icon(Icons.check_box, size: 18, color: Colors.red)
          : const Icon(Icons.check_box_outline_blank,
              size: 18, color: Colors.black26);
      // ? Assets.images.checkboxS.image(width: 16)
      // : Assets.images.checkboxD.image(width: 16);
    }
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 12),
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
          icon,
          const SizedBox(width: 6),
        ],
      ),
    );
  }
}
