import 'package:anandownload/routes/page_path.dart';
import 'package:get/get.dart';

import '../ui/home/home_page.dart';
import '../ui/search/search_controller.dart';
import '../ui/search/search_page.dart';

/// @author: xandone
/// created on: 2025/7/10 11:14
/// description:

class PageManifest {
  PageManifest._();

  static final routes = [
    GetPage(
      name: PagePath.mMain,
      page: () {
        return HomePage();
      },
      bindings: const [],
    ),
    GetPage(
      name: PagePath.mSearch,
      page: () {
        return SearchPage();
      },
      bindings: [
        BindingsBuilder.put(() => SearchVideoController()),
      ],
    ),
  ];
}
