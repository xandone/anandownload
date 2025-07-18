import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';

import '../download/download_task.dart';
import '../http/http_dio.dart';
import '../utils/logger.dart';
import '../utils/timer_count_utils.dart';

/// @author: xiao
/// created on: 2025/7/16 16:32
/// description:

class DownloadService extends GetxService {
  static DownloadService get instance => Get.find();
  RxList<DownloadTask> taskList = RxList();

  Timer? _timer;

  @override
  onInit() async {
    super.onInit();
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
  }

  void download(DownloadTask task) async {
    task.state = TaskState.running;
    await HttpDio.instance.download(
        task.videoEntity.url!, task.videoEntity.savePath, (received, total) {
      task.videoEntity.dSize = received;
      task.videoEntity.progress = received / total;
      if (task.videoEntity.progress >= 1) {
        task.state = TaskState.completed;
      }
    });
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
