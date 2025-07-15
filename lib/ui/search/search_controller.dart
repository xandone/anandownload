import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';

import '../../entity/videoinfo_entity.dart';
import '../../http/api.dart';
import '../../http/http_dio.dart';
import '../../model/videoinfo_model.dart';
import '../../utils/logger.dart';

/// @author: xiao
/// created on: 2025/7/11 17:42
/// description:

class SearchVideoController extends GetxController {
  TextEditingController textEditingController = TextEditingController();

  RxList<VideoInfoModel> datas = RxList();
  Rx<VideoInfoEntity?> videoInfoEntity = Rx(null);

  @override
  void onInit() {
    super.onInit();
  }

  Future<void> getData() async {
    final RegExp regExp = RegExp(r'BV[\w]+');
    final match = regExp.firstMatch(Api.test);
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
      videoInfoEntity.value =
          VideoInfoEntity.fromJson(value['data']['durl'][0]);
      Log.d('ssss=${videoInfoEntity.value?.url}');
    });
  }

  void download(String? url, String fileName) async {
    final Directory? downloadsDir = await getDownloadsDirectory();
    final String savePath = '${downloadsDir?.path}/$fileName.mp4';
    HttpDio.instance.download(url!, savePath);
  }
}
