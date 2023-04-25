import 'package:flutter/material.dart';

class _PopupConfig {
  BuildContext context;

  /// 内容边框边距
  // final double padding;

  final Color bgColor;

  /// 距离点击视图的间隔 / 上下左右的距离
  final EdgeInsets margin;

  /// 三角的大小
  final Size size;

  _PopupConfig({
    required this.context,
    // this.padding = 10,
    required this.margin,
    required this.size,
    required this.bgColor,
  });
}

class PopupMessage extends StatefulWidget {
  const PopupMessage({
    super.key,
    required this.child,
    required this.content,
    this.padding = const EdgeInsets.all(10),
    this.margin = const EdgeInsets.all(5),
    this.size = const Size(7, 7),
    this.bgColor = Colors.white,
    this.maxWidth = 200,
    this.barrierColor = const Color(0x05000000),
  });

  final Widget child;
  final Widget content;
  final double maxWidth;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Size size;
  final Color barrierColor;
  final Color bgColor;

  @override
  State<PopupMessage> createState() => _PopupMessageState();
}

class _PopupMessageState extends State<PopupMessage> {
  late _PopupConfig _config;

  OverlayEntry? _entry;

  @override
  void initState() {
    _config = _PopupConfig(
      context: context,
      // padding: widget.padding,
      margin: widget.margin,
      size: widget.size,
      bgColor: widget.bgColor,
    );

    super.initState();
  }

  _removeEntry() {
    if (_entry != null) {
      _entry!.remove();
      _entry = null;
    }
  }

  _showText() {
    final box = context.findRenderObject() as RenderBox;
    final offset = box.localToGlobal(Offset.zero);

    _entry = OverlayEntry(builder: (context) {
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: _removeEntry,
          child: Align(
            alignment: Alignment.topLeft,
            child: CustomSingleChildLayout(
              delegate: _ChildLayoutDelegate(
                _config,
                target: offset & box.size,
              ),
              child: CustomPaint(
                painter: _PopupMsgPainter(
                  _config,
                  target: offset & box.size,
                ),
                child: Container(
                  constraints: BoxConstraints(maxWidth: widget.maxWidth),
                  // color: Colors.red,
                  padding: widget.padding,
                  child: widget.content,
                ),
              ),
            ),
          ),
        ),
      );
    });

    Overlay.of(context).insert(_entry!);

    // return showDialog(
    //   context: context,
    //   barrierColor: widget.barrierColor,
    //   builder: (context) {
    //     return follow;
    //   },
    // );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _showText,
      child: widget.child,
    );
  }
}

class _ChildLayoutDelegate extends SingleChildLayoutDelegate {
  _ChildLayoutDelegate(
    this.config, {
    required this.target,
  });

  final _PopupConfig config;

  final Rect target;

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) => false;

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // return Offset.zero;
    return getContentOffset(childSize);
  }

  Offset getContentOffset(Size size) {
    final media = MediaQuery.of(config.context);
    final sw = media.size.width;
    final sh = media.size.height;

    // 默认显示在正下方
    Offset offset = Offset(
      0,
      target.bottom + config.size.height + config.margin.bottom,
    );

    // 超出左边屏幕
    if (target.center.dx < size.width / 2 + config.margin.left) {
      offset = Offset(config.margin.left, offset.dy);
    }
    // 超出屏幕右边
    else if (target.center.dx + size.width / 2 + config.margin.right > sw) {
      offset = Offset(sw - size.width - config.margin.right, offset.dy);
    }
    // 居中
    else {
      offset = Offset(target.center.dx - size.width / 2, offset.dy);
    }

    // 底部溢出 正上方显示
    if (target.bottom + size.height + media.padding.bottom + kToolbarHeight >
        sh) {
      offset = Offset(offset.dx,
          target.top - size.height - config.margin.top - config.size.height);
    }

    return offset;
  }
}

class _PopupMsgPainter extends CustomPainter {
  const _PopupMsgPainter(
    this.config, {
    required this.target,
  });

  final Rect target;
  final _PopupConfig config;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(4));

    final paint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.fill
      ..color = config.bgColor;

    final path = Path();

    final offset = getArrowOffset(size);

    // 三角形
    path.moveTo(offset.dx - config.size.width / 1.2, offset.dy);
    path.lineTo(
        offset.dx,
        offset.dy > 0
            ? offset.dy + config.size.height
            : offset.dy - config.size.height);
    path.lineTo(offset.dx + config.size.width / 1.2, offset.dy);

    // 矩形
    path.addRRect(rrect);

    if (config.bgColor.opacity == 1) {
      canvas.drawShadow(
          Path()
            ..addRRect(RRect.fromRectAndRadius(
                Rect.fromLTWH(
                  rect.left - config.size.width / 2,
                  rect.top - config.size.height,
                  rect.width + config.size.width,
                  rect.height + config.size.height,
                ),
                const Radius.circular(4))),
          Colors.black26,
          5,
          false);
    }
    canvas.drawPath(path, paint);
  }

  Offset getArrowOffset(Size size) {
    final media = MediaQuery.of(config.context);
    final sw = media.size.width;
    final sh = media.size.height;

    // 默认显示在正下方
    Offset offset = Offset.zero;

    // 超出左边屏幕
    if (target.center.dx < size.width / 2 + config.margin.left) {
      offset = Offset(target.center.dx - config.margin.left, offset.dy);
    }
    // 超出屏幕右边
    else if (target.center.dx + size.width / 2 + config.margin.right > sw) {
      offset = Offset(
          target.center.dx - sw + size.width + config.margin.right, offset.dy);
    }
    // 居中
    else {
      offset = Offset(size.width / 2, offset.dy);
    }

    // 底部溢出 正上方显示
    if (target.bottom + size.height + media.padding.bottom + kToolbarHeight >
        sh) {
      offset = Offset(offset.dx, size.height);
    }

    return offset;
  }

  @override
  bool shouldRepaint(_PopupMsgPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(_PopupMsgPainter oldDelegate) => false;
}
