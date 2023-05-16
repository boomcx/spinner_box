import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PopBotButton extends StatelessWidget {
  const PopBotButton({
    super.key,
    this.name = '确定',
    this.onPressed,
    this.isReset = false,
  });

  final bool isReset;
  final String name;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return TapScope(
      onPressed: onPressed,
      child: Container(
        alignment: Alignment.center,
        width: 170,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(
              colors: isReset
                  ? const [Color(0xffeeeeee), Color(0xfff5f5f5)]
                  : const [Color(0xffF56E60), Color(0xffE72410)]),
        ),
        child: Text(
          name,
          style: !isReset
              ? const TextStyle(color: Colors.white, fontSize: 16)
              : const TextStyle(color: Colors.black87, fontSize: 16),
        ),
      ),
    );
  }
}

class Button extends StatelessWidget {
  const Button(
    this.name,
    this.isSelected, {
    super.key,
    this.onPressed,
  });

  final String name;
  final bool isSelected;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = isSelected
        ? const [Color(0xffF56E60), Color(0xffE72410)]
        : const [Color(0xfff7f7f7), Color(0xfff7f7f7)];

    return TapScope(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        constraints: const BoxConstraints(
          minWidth: 48,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          gradient: LinearGradient(colors: colors),
        ),
        child: Text(
          name,
          style: isSelected
              ? const TextStyle(color: Colors.white, fontSize: 12)
              : const TextStyle(color: Colors.black87, fontSize: 12),
        ),
      ),
    );
  }
}

class TapScope extends StatelessWidget {
  const TapScope({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      pressedOpacity: 0.85,
      padding: EdgeInsets.zero,
      borderRadius: BorderRadius.circular(0),
      minSize: 10,
      onPressed: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
        onPressed?.call();
      },
      child: child,
    );
  }
}
