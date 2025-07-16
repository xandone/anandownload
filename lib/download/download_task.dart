import 'package:anandownload/model/videoinfo_model.dart';

import '../model/video_info_details.dart';
import '../utils/logger.dart';
import '../utils/my_utils.dart';

/// @author: xiao
/// created on: 2025/7/16 10:53
/// description:

class DownloadTask {
  int? id;
  String? fileName;
  String? url;
  late String savePath;

  DownloadTask({this.id, this.fileName, this.url, this.savePath = ''});

  static Future<DownloadTask> create(
      VideoInfoModel info, VideoInfoDetails? details) async {
    final String savePath =
        '${await MyUtils.getDownloadPath()}/${info.title}.mp4';
    Log.d('savePath=$savePath');
    return DownloadTask()
      ..fileName = info.title
      ..url = details?.url
      ..savePath = savePath;
  }
}
