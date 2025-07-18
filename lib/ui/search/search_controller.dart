import 'dart:async';

import 'package:anandownload/service/download_service.dart';
import 'package:anandownload/utils/my_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../download/download_task.dart';
import '../../http/api.dart';
import '../../http/http_dio.dart';
import '../../model/video_info_details.dart';
import '../../model/videoinfo_model.dart';
import '../../utils/logger.dart';
import '../../utils/my_utils.dart';
import '../../utils/toast.dart';

/// @author: xiao
/// created on: 2025/7/11 17:42
/// description:

class SearchVideoController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  RxList<VideoInfoModel> datas = RxList();
  Rx<VideoInfoDetails?> videoInfoDetails = Rx(null);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getData() async {
    final String keyword = textEditingController.text;
    if (keyword.isEmpty) {
      if (MyUtils.isPhone()) {
        MyToast.showToast('请输入关键字');
      } else {
        MyDialog.showSimpleOnlyComfirm('请输入关键字', () {});
      }
      return;
    }
    final RegExp regExp = RegExp(r'BV[\w]+');
    final match = regExp.firstMatch(textEditingController.text);
    await HttpDio.instance.get(Api.search, data: {
      "bvid": match?.group(0),
    }).then((value) {
      datas.clear();
      datas.add(VideoInfoModel.fromJson(value['data']));
    });

    VideoInfoModel model = datas[0];
    await HttpDio.instance.get(Api.details, data: {
      'avid': model.aid,
      'cid': model.cid,
      'qn': 80,
      'platform': 'html5',
      'otype': 'json',
      'high_quality': 1
    }).then((value) {
      videoInfoDetails.value =
          VideoInfoDetails.fromJson(value['data']['durl'][0]);
    });
  }

  void addDownloadTask() async {
    DownloadTask task =
        await DownloadTask.create(datas[0], videoInfoDetails.value);
    DownloadService.instance.addDownloadTask(task);
  }
}
