import 'package:anandownload/utils/my_utils.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'my_dialog.dart';

class MyToast {
  MyToast(String s);

  static void showToast(String msg, {debounce = true}) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }

  static void showToast0(String msg, {debounce = true}) {
    if (MyUtils.isPhone()) {
      showToast(msg, debounce: debounce);
    } else {
      MyDialog.showSimpleOnlyComfirm(msg, () {});
    }
  }
}
