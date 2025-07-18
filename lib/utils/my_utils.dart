import 'dart:io';

import 'package:anandownload/utils/sp_utils.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constant/constants.dart';

/// @author: xiao
/// created on: 2025/7/11 10:29
/// description:

class MyUtils {
  MyUtils._();

  static bool isPhone() {
    return Platform.isAndroid || Platform.isIOS;
  }

  static bool isPC() {
    return Platform.isMacOS || Platform.isWindows || Platform.isLinux;
  }

  static Future open(String path) async {
    final url = Uri.parse('file:///$path');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
