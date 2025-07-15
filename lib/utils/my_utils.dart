import 'dart:io';

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
}
