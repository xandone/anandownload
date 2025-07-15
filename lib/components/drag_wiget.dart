import 'package:anandownload/utils/my_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';

/// @author: xiao
/// created on: 2025/7/11 14:23
/// description:

class DragWiget extends StatelessWidget {
  final Widget child;

  const DragWiget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (MyUtils.isPhone()) {
      return child;
    }
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onPanStart: (details) {
        windowManager.startDragging();
      },
      child: child,
    );
  }
}
