import 'package:anandownload/download/download_task.dart';
import 'package:anandownload/res/colors.dart';
import 'package:anandownload/ui/search/search_controller.dart';
import 'package:anandownload/utils/my_utils.dart';
import 'package:anandownload/utils/toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/drag_wiget.dart';
import '../../service/download_service.dart';
import '../../utils/logger.dart';
import '../../widget/image_loader.dart';

/// @author: xiao
/// created on: 2025/7/11 17:39
/// description:

class SearchPage extends GetView<SearchVideoController> {
  var controller = Get.put(SearchVideoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: DragWiget(
              child: Row(children: [
            Expanded(
                child: TextField(
              controller: TextEditingController(),
              decoration: InputDecoration(
                  hintText: '请输入关键字',
                  hintStyle: const TextStyle(color: MyColors.hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5),
                    borderSide:
                        const BorderSide(color: MyColors.divideLineColor),
                  ),
                  contentPadding: const EdgeInsets.only(left: 10)),
            )),
            ElevatedButton(
                onPressed: controller.getData, child: const Text('搜索'))
          ]))),
      body: Obx(() => ListView.builder(
            itemCount: controller.datas.length,
            itemBuilder: (context, index) {
              return Card(
                  child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ImageLoader.display(controller.datas[index].pic, 120, 80),
                  Expanded(
                    child: ListTile(
                      title: Text(controller.datas[index].title),
                      subtitle:
                          Text(controller.datas[index].pubdate.toString()),
                      trailing: IconButton(
                        onPressed: () {
                          if (MyUtils.isPhone()) {
                            MyToast.showToast('开始下载');
                          }
                          controller.addDownloadTask();
                        },
                        icon: const Icon(Icons.download),
                      ),
                    ),
                  )
                ],
              ));
            },
          )),
    );
  }
}
