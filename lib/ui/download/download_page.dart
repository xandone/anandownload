import 'package:anandownload/res/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../download/download_task.dart';
import '../../service/download_service.dart';
import '../../utils/logger.dart';
import '../../utils/my_dialog.dart';
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
              child: Stack(alignment: Alignment.bottomLeft, children: [
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
                        title: Row(children: [
                          Expanded(
                            child: Text(
                              DownloadService.instance.taskList[index]
                                      .videoEntity.fileName ??
                                  '',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(DownloadService
                                        .instance.taskList[index].state ==
                                    TaskState.running
                                ? Icons.pause
                                : Icons.play_arrow),
                            color: MyColors.btnColor,
                            tooltip: DownloadService
                                        .instance.taskList[index].state ==
                                    TaskState.running
                                ? '暂停'
                                : '继续',
                          ),
                          IconButton(
                            onPressed: () {
                              MyDialog.showSimple('确定删除吗？', () {
                                Log.d('删除');
                              });
                            },
                            icon: const Icon(Icons.delete),
                            color: Colors.red,
                            tooltip: '删除',
                          ),
                          IconButton(
                            onPressed: () {
                              Log.d(
                                  '路径：${DownloadService.instance.taskList[index].videoEntity.basePath}');
                              MyUtils.open(DownloadService.instance
                                  .taskList[index].videoEntity.basePath);
                            },
                            icon: const Icon(Icons.folder),
                            color: Colors.orangeAccent,
                            tooltip: '打开',
                          ),
                        ]),
                      ),
                    )
                  ],
                ),
                LinearPercentIndicator(
                  padding: EdgeInsets.zero,
                  lineHeight: 6,
                  percent: DownloadService
                      .instance.taskList[index].videoEntity.progress,
                  trailing: Text(
                    '${(DownloadService.instance.taskList[index].videoEntity.progress * 100).toStringAsFixed(2)}%',
                    style:
                        const TextStyle(fontSize: 14, color: MyColors.btnColor),
                  ),
                  backgroundColor: Colors.transparent,
                  progressColor: MyColors.downloadBgColor,
                ),
              ]),
            );
          },
        ));
  }
}
