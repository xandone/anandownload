import 'dart:io';

import 'package:anandownload/components/drag_wiget.dart';
import 'package:anandownload/ui/download/download_page.dart';
import 'package:anandownload/ui/search/search_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/assets.dart';
import '../../res/colors.dart';
import '../../res/gaps.dart';
import '../../utils/my_utils.dart';

/// @author: xiao
/// created on: 2025/7/10 14:49
/// description:

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final RxInt _index = 0.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Row(
        children: [
          Visibility(
            visible: MyUtils.isPC(),
            child: leftNavigationBar(),
          ),
          Expanded(
            child: Obx(() => Center(
                  child: IndexedStack(index: _index.value, children: [
                    SearchPage(),
                    const DownloadPage(),
                  ]),
                )),
          ),
        ],
      )),
      bottomNavigationBar: Visibility(
          visible: MyUtils.isPhone(),
          child: Obx(() => BottomNavigationBar(
                selectedItemColor: MyColors.textColor1,
                unselectedItemColor: MyColors.textColor2,
                currentIndex: _index.value,
                onTap: (index) {
                  _index.value = index;
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(Icons.search), label: "搜索"),
                  BottomNavigationBarItem(icon: Icon(Icons.home), label: "下载")
                ],
              ))),
    );
  }

  Widget leftNavigationBar() {
    return DragWiget(
        child: Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(color: Colors.grey),
      child: Column(children: [
        Image.asset(Assets.logo, width: 60, height: 60),
        InkWell(
          child: const Row(
            children: [Icon(Icons.search), Text("搜索")],
          ),
          onTap: () {
            _index.value = 0;
          },
        ),
        Gaps.vGaps20,
        InkWell(
          child: const Row(
            children: [Icon(Icons.downloading), Text("下载")],
          ),
          onTap: () {
            _index.value = 1;
          },
        ),
      ]),
    ));
  }
}
