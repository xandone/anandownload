import 'dart:io';

import 'package:path_provider/path_provider.dart';

import '../constant/constants.dart';
import '../utils/sp_utils.dart';

/// @author: xiao
/// created on: 2025/7/18 9:30
/// description:

class StorageUtils {
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
