part of '../spinner_filter.dart';

class _CheckListItem extends StatelessWidget {
  const _CheckListItem({
    required this.name,
    required this.isSelect,
    this.isMulti = false,
  });

  final String name;
  final bool isSelect;
  final bool isMulti;

  @override
  Widget build(BuildContext context) {
    Widget icon = isSelect ? Assets.name('single_select') : const SizedBox();
    if (isMulti) {
      icon = isSelect
          ? Assets.name('muti_select')
          : Assets.name('muti_unselect');
    }
    return Container(
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
