import 'dart:convert';

import 'package:get/get.dart';

import '../download/download_task.dart';
import '../http/http_dio.dart';
import '../utils/logger.dart';

/// @author: xiao
/// created on: 2025/7/16 16:32
/// description:

class DownloadService extends GetxService {
  static DownloadService get instance => Get.find();
  final RxList<DownloadTask> taskList = RxList();

  @override
  onInit() async {
    super.onInit();
    ever<List<DownloadTask>>(taskList, (task) {
      download(taskList[0]);
    });
  }

  void addDownloadTask(DownloadTask task) {
    taskList.add(task);
  }

  void download(DownloadTask task) async {
    await HttpDio.instance.download(task.url!, task.savePath,
        (received, total) {
      Log.d('received=$received,total=$total');
    });
    Log.d('下载完成');
  }
}
