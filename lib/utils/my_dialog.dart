import 'package:anandownload/utils/my_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../res/colors.dart';

/// @author: xandone
/// created on: 2025/1/18 9:16
/// description:
class MyDialog {
  static void showLoading0({String msg = '加载中'}) {
    SmartDialog.showLoading(msg: msg);
  }

  static void showLoading({String msg = ''}) {
    SmartDialog.showLoading(builder: (_) => CustomLoadingWidget(msg: msg));
  }

  static void dismiss() {
    SmartDialog.dismiss();
  }

  static void showSimple(var content, VoidCallback onConfirm,
      {String cancelStr = '取消',
      String confirmStr = '确定',
      String title = '提示'}) {
    SmartDialog.show(
        nonAnimationTypes: [SmartNonAnimationType.closeDialog_nonAnimation],
        builder: (context) {
          return Container(
            width: MediaQuery.of(context).size.width *
                (MyUtils.isPC() ? 0.4 : 0.8),
            padding: const EdgeInsets.only(top: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17.0,
                      color: MyColors.textColor1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Text(
                      content,
                      style: const TextStyle(
                          fontSize: 14, color: MyColors.textColor1),
                    )),
                const SizedBox(height: 20.0),
                // 底部按钮
                Container(
                  height: 52,
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: MyColors.divideLineColor,
                        width: 1.0,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TextButton(
                          onPressed: () {
                            SmartDialog.dismiss();
                          },
                          child: Text(cancelStr,
                              style: const TextStyle(
                                  fontSize: 14, color: MyColors.btnColor))),
                      TextButton(
                          onPressed: () {
                            SmartDialog.dismiss();
                            onConfirm();
                          },
                          child: Text(confirmStr,
                              style: const TextStyle(
                                  fontSize: 14, color: MyColors.btnColor)))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  static void showSimpleOnlyComfirm(var content, VoidCallback onConfirm,
      {String title = '温馨提示', String confirmStr = '确定'}) {
    SmartDialog.show(builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width * (MyUtils.isPC() ? 0.4 : 0.8),
        padding: const EdgeInsets.only(top: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 17.0,
                  color: MyColors.textColor1,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Text(
                  content,
                  style:
                      const TextStyle(fontSize: 14, color: MyColors.textColor1),
                )),
            const SizedBox(height: 20.0),
            // 底部按钮
            Container(
              height: 52,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: MyColors.divideLineColor,
                    width: 1.0,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  TextButton(
                      onPressed: () {
                        onConfirm();
                        SmartDialog.dismiss();
                      },
                      child: Text(confirmStr,
                          style: const TextStyle(
                              fontSize: 14, color: MyColors.btnColor)))
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({super.key, required this.msg});

  ///loading msg
  final String msg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const CircularProgressIndicator(
          strokeWidth: 3,
          valueColor: AlwaysStoppedAnimation(MyColors.white),
        ),
        Visibility(
          visible: msg.isNotEmpty,
          child: Container(
            margin: const EdgeInsets.only(top: 10),
            child: Text(msg,
                style: const TextStyle(color: MyColors.white, fontSize: 14)),
          ),
        ),
      ]),
    );
  }
}
