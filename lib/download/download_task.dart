import 'package:anandownload/model/videoinfo_model.dart';

import '../entity/video_entity.dart';
import '../model/video_info_details.dart';
import '../utils/logger.dart';
import '../utils/my_utils.dart';

/// @author: xiao
/// created on: 2025/7/16 10:53
/// description:

class DownloadTask {
  TaskState state;
  late VideoEntity videoEntity;

  DownloadTask({
    this.state = TaskState.preparing,
  });

  static Future<DownloadTask> create(
      VideoInfoModel info, VideoInfoDetails? details) async {
    final String savePath =
        '${await MyUtils.getDownloadPath()}/${info.title}.mp4';
    Map<String, dynamic> json = {
      'fileName': info.title,
      'pic': info.pic,
      'url': details?.url,
      'size': details?.size ?? 0,
      'timelength': details?.timelength,
      'savePath': savePath,
    };
    Log.d('savePath=$savePath');
    return DownloadTask()..videoEntity = VideoEntity.fromJson(json);
  }
}

enum TaskState {
  preparing,
  running,
  paused,
  completed,
  failed,
}
