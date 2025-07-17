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
  final RxList<DownloadTask> taskList = RxList();

  Timer? _timer;

  @override
  onInit() async {
    super.onInit();
    startPeriodic();
    ever<List<DownloadTask>>(taskList, (task) {
      download(taskList[0]);
    });
  }

  void addDownloadTask(DownloadTask task) {
    taskList.add(task);
  }

  void download(DownloadTask task) async {
    await HttpDio.instance
        .download(task.videoEntity.url!, task.videoEntity.savePath,
            (received, total) {
      Log.d('received=$received,total=$total');
    });
  }

  void startPeriodic() {
    _timer?.cancel();

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      // Log.d('倒计时：');
    });
  }

  @override
  void onClose() {
    super.onClose();
    _timer?.cancel();
    _timer = null;
  }
}
