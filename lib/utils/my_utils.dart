import 'dart:io';

import 'package:anandownload/utils/sp_utils.dart';
import 'package:path_provider/path_provider.dart';

import '../constant/constants.dart';

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

  static Future<String> getDownloadPath() async {
    String? path = await SpUtils.get<String>(Constants.SP_DOWNLOAD_PATH_KEY);
    if (path != null) {
      return path;
    }
    final Directory? downloadsDir = await getDownloadsDirectory();
    path = downloadsDir?.path ?? "";
    SpUtils.save(Constants.SP_DOWNLOAD_PATH_KEY, path);
    return path;
  }
}
