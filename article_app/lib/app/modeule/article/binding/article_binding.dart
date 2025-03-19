import 'package:article_app/app/modeule/article/controller/article_controller.dart';
import 'package:get/get.dart';

class ArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(ArticleController());
  }
}
