import 'package:get/get.dart';

import 'app/repository/article_repository.dart';
import 'base/network_requester.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(NetworkRequester());
    Get.put(ArticleRepository());
  }
}
