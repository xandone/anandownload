import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../service/download_service.dart';
import '../../utils/my_utils.dart';
import '../../widget/image_loader.dart';

/// @author: xiao
/// created on: 2025/7/15 14:25
/// description:

class DownloadPage extends StatelessWidget {
  const DownloadPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => ListView.builder(
          itemCount: DownloadService.instance.taskList.length,
          itemBuilder: (context, index) {
            return Card(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ImageLoader.display(
                    DownloadService.instance.taskList[index].videoEntity.pic ??
                        '',
                    120,
                    80),
                Expanded(
                  child: ListTile(
                    title: Text(DownloadService
                            .instance.taskList[index].videoEntity.fileName ??
                        ''),
                  ),
                )
              ],
            ));
          },
        ));
  }
}
