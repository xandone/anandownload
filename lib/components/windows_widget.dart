import 'package:flutter/cupertino.dart';
import 'package:window_manager/window_manager.dart';

/// @author: xiao
/// created on: 2025/7/18 11:08
/// description:

class WindowsWidget extends StatelessWidget {
  const WindowsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          child: WindowCaptionButton.minimize(
            onPressed: () async {
              if (await windowManager.isMinimized()) {
                windowManager.restore();
              } else {
                windowManager.minimize();
              }
            },
          ),
        ),
        SizedBox(
          child: FutureBuilder<bool>(
            future: windowManager.isMaximized(),
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return WindowCaptionButton.unmaximize(
                  onPressed: () async {
                    await windowManager.unmaximize();
                  },
                );
              }
              return WindowCaptionButton.maximize(
                onPressed: () async {
                  await windowManager.maximize();
                },
              );
            },
          ),
        ),
        SizedBox(
          child: WindowCaptionButton.close(
            onPressed: () {
              windowManager.close();
            },
          ),
        ),
      ],
    );
  }
}
