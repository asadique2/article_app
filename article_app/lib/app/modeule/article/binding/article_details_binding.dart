import 'package:get/get.dart';

import '../controller/article_details_controller.dart';

class ArticleDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArticleDetailsController());
  }
}
