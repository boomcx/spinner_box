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
    Widget icon = isSelect ? _Assets.name('single_select') : const SizedBox();
    if (isMuti) {
      icon = isSelect
          ? _Assets.name('muti_select')
          : _Assets.name('muti_unselect');
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

class _Assets {
  static Widget name(String name, {double width = 16}) {
    return Image.asset(
      'assets/images/$name.png',
      width: width,
      fit: BoxFit.contain,
      package: 'spinner_box',
    );
  }
}
