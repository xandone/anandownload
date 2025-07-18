import 'package:flutter/material.dart';

import 'colors.dart';

/// @author: xiao
/// created on: 2024/12/6 16:32
/// description:
class MyStyles {
  static const TextStyle btn_text_style = TextStyle(
    fontSize: 16,
    color: MyColors.white,
    fontWeight: FontWeight.normal,
  );

  static ButtonStyle btn_commit_style = TextButton.styleFrom(
      backgroundColor: MyColors.btnColor,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(2))));

  static const TextStyle text_nobtn_style = TextStyle(
    fontSize: 14,
    color: MyColors.btnColor,
  );

  static const RoundedRectangleBorder shape_r_8 = RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)));

  static const TextStyle text_simple_tip_style = TextStyle(
    fontSize: 20,
    color: MyColors.textColor2,
    decoration: TextDecoration.none,
  );
}
