import 'package:anandownload/model/videoinfo_model.dart';
import 'package:anandownload/storage/storage_utils.dart';
import 'package:dio/dio.dart';

import '../entity/video_entity.dart';
import '../model/video_info_details.dart';
import '../utils/logger.dart';
import 'package:path/path.dart' as p;

/// @author: xiao
/// created on: 2025/7/16 10:53
/// description:

class DownloadTask {
  TaskState state;
  late VideoEntity videoEntity;
  CancelToken cancelToken = CancelToken();

  DownloadTask({
    this.state = TaskState.preparing,
  });

  static Future<DownloadTask> create(
      VideoInfoModel info, VideoInfoDetails? details) async {
    final String basePath = await StorageUtils.getDownloadPath();
    final String savePath = p.join(basePath, '$basePath/${info.title}.mp4');
    Map<String, dynamic> json = {
      'fileName': info.title,
      'pic': info.pic,
      'url': details?.url,
      'size': details?.size ?? 0,
      'timelength': details?.timelength,
      'savePath': savePath,
      'basePath': basePath,
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
