import 'package:flutter/cupertino.dart';

import '../theme/theme.dart';

class WrapButton extends StatelessWidget {
  const WrapButton(
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
    final theme = SpinnerBoxTheme.of(context).wrap;

    return TapScope(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        constraints: const BoxConstraints(minWidth: 48, minHeight: 28),
        decoration:
            isSelected ? theme.selectedDecoration : theme.unselectedDecoration,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              name,
              style: isSelected ? theme.selectedStyle : theme.unselectedStyle,
            ),
          ],
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
      pressedOpacity: 0.6,
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
