import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../db/video_entity.dart';
import '../download/download_task.dart';
import '../http/http_dio.dart';
import '../utils/logger.dart';
import '../utils/timer_count_utils.dart';

/// @author: xiao
/// created on: 2025/7/16 16:32
/// description:

const String VIDEO_ENTITY_KEY = 'video_entity_key';

class DownloadService extends GetxService {
  static DownloadService get instance => Get.find();
  RxList<DownloadTask> taskList = RxList();

  Timer? _timer;
  late Box<VideoEntity> videoEntityBox;

  @override
  onInit() async {
    super.onInit();
    var dir = await getApplicationSupportDirectory();
    videoEntityBox =
        await Hive.openBox<VideoEntity>(VIDEO_ENTITY_KEY, path: dir.path);

    List<DownloadTask> list = videoEntityBox.values
        .toList()
        .map((it) => DownloadTask()
          ..state = TaskState.paused
          ..videoEntity = it)
        .toList();
    Log.d('list=${jsonEncode(list[0].videoEntity.progress)}');
    taskList.addAll(list);

    startPeriodic();
    ever<List<DownloadTask>>(taskList, (task) {
      taskList.forEach((task) {
        if (task.state == TaskState.preparing) {
          download(task);
        }
      });
    });
  }

  void addDownloadTask(DownloadTask task) {
    taskList.add(task);
    videoEntityBox.add(task.videoEntity);
  }

  void switchDownload(DownloadTask task) {
    if (task.state == TaskState.running) {
      pauseDownload(task);
    } else {
      reDownload(task);
    }
  }

  void pauseDownload(DownloadTask task) {
    task.state = TaskState.paused;
    task.cancelToken.cancel();
  }

  void reDownload(DownloadTask task) {
    task.cancelToken = CancelToken();
    download(task);
  }

  void deleteDownload(DownloadTask task) {
    task.state = TaskState.failed;
    task.cancelToken.cancel();
    taskList.remove(task);
    videoEntityBox.delete(task.videoEntity.id);
  }

  void download(DownloadTask task) async {
    task.state = TaskState.running;
    await HttpDio.instance.download(
        task.videoEntity.url!, task.videoEntity.savePath, (received, total) {
      task.videoEntity.pSize = received;
      task.videoEntity.progress = received / total;
      if (task.videoEntity.progress >= 1) {
        task.state = TaskState.completed;
      }
    }, task.cancelToken);
  }

  void startPeriodic() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (taskList.isNotEmpty) {
        taskList.refresh();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
    _timer = null;
  }
}
