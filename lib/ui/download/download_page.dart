import 'package:anandownload/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../service/download_service.dart';
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
              child: Stack(children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ImageLoader.display(
                        DownloadService
                                .instance.taskList[index].videoEntity.pic ??
                            '',
                        120,
                        80),
                    Expanded(
                      child: ListTile(
                        title: Text(DownloadService.instance.taskList[index]
                                .videoEntity.fileName ??
                            ''),
                      ),
                    )
                  ],
                ),
                LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  lineHeight: 80,
                  percent: DownloadService
                      .instance.taskList[index].videoEntity.progress,
                  trailing: Text(
                    '${(DownloadService.instance.taskList[index].videoEntity.progress * 100).toStringAsFixed(2)}%',
                    style:
                        const TextStyle(fontSize: 14, color: MyColors.btnColor),
                  ),
                  backgroundColor: Colors.transparent,
                  progressColor: MyColors.downloadBgColor,
                )
              ]),
            );
          },
        ));
  }
}
