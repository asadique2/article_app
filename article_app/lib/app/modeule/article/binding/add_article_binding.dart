import 'package:article_app/app/modeule/article/controller/add_article_controller.dart';
import 'package:get/get.dart';

class AddArticleBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AddArticleController());
  }
}
