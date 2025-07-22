import 'package:anandownload/components/windows_widget.dart';
import 'package:anandownload/res/colors.dart';
import 'package:anandownload/ui/search/search_controller.dart';
import 'package:anandownload/utils/my_utils.dart';
import 'package:anandownload/utils/toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/drag_wiget.dart';
import '../../res/gaps.dart';
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
          preferredSize: const Size.fromHeight(80),
          child: DragWiget(
              child: Column(children: [
            Visibility(
              visible: MyUtils.isPC(),
              child: const WindowsWidget(),
            ),
            Expanded(
                child: Row(children: [
              Obx(() => DropdownButton(
                  icon: const Icon(Icons.arrow_drop_down),
                  value: controller.selectIndex.value,
                  items: const [
                    DropdownMenuItem(
                      value: 0,
                      child: Text('B站'),
                    ),
                    DropdownMenuItem(
                      value: 1,
                      child: Text('抖音'),
                    ),
                    DropdownMenuItem(
                      value: 2,
                      child: Text('其他'),
                    ),
                  ],
                  onChanged: (v) {
                    controller.selectIndex.value = v!;
                  })),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: TextField(
                    controller: controller.textEditingController,
                    decoration: InputDecoration(
                        hintText: '请输入关键字',
                        hintStyle: const TextStyle(color: MyColors.hintColor),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide:
                              const BorderSide(color: MyColors.divideLineColor),
                        ),
                        contentPadding: const EdgeInsets.only(left: 10)),
                  ),
                ),
              ),
              Gaps.hGaps10,
              SizedBox(
                height: 45,
                child: ElevatedButton(
                  onPressed: controller.getData,
                  style: TextButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 30,
                      ),
                      backgroundColor: MyColors.btnColor,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(2)))),
                  child: const Text(
                    '搜索',
                    style: TextStyle(fontSize: 14, color: MyColors.white),
                  ),
                ),
              ),
              Gaps.hGaps10,
            ])),
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
