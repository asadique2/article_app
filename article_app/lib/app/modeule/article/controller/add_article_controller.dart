import 'package:article_app/base/base_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class AddArticleController extends BaseController {
  RxBool isUpdating = RxBool(false);
  @override
  void onInit() {
    if (Get.arguments != null) {
      isUpdating(true);
    }
    super.onInit();
  }
}
