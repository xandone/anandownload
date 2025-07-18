import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

/// @author: xiao
/// created on: 2025/7/11 10:29
/// description:

class MyUtils {
  MyUtils._();

  static bool isPhone() {
    return Platform.isAndroid || Platform.isIOS;
  }

  static bool isPC() {
    return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  }

  static Future open(String filePath) async {
    if (Platform.isWindows) {
      await Process.run('explorer', [filePath]);
    } else if (Platform.isMacOS) {
      await Process.run('open', [filePath]);
    }
  }
}
