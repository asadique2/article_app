import 'package:article_app/app/model/ArticleListModel.dart';
import 'package:article_app/app/repository/article_repository.dart';
import 'package:article_app/base/base_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/app_utils.dart';
import '../../../model/generic_response.dart';
import '../../../model/response.dart';
import '../../../routes/app_routes.dart';

class ArticleDetailsController extends BaseController<ArticleRepository> {
  RxBool isLoadingData = false.obs;
  Rx<Article?> articleDetails = Rx(null);
  @override
  void onInit() {
    if (Get.arguments != null) {
      getArticlesDetails(Get.arguments);
    }
    super.onInit();
  }

  Future<void> getArticlesDetails(String id) async {
    isLoadingData(true);
    try {
      RepoResponse<GenericResponse> response = await repository
          .getArticlesDetails(id);
      if (response.data?.statusCode == 200) {
        articleDetails.value = Article.fromJson(response.data?.data);
      } else {
        AppUtils.showErrorMessage(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoadingData(false);
    }
  }

  Future<void> createArticle(String id) async {
    isLoadingData(true);
    try {
      RepoResponse<GenericResponse> response = await repository
          .getArticlesDetails(id);
      if (response.data?.statusCode == 200) {
        articleDetails.value = Article.fromJson(response.data?.data);
      } else {
        AppUtils.showErrorMessage(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoadingData(false);
    }
  }

  handelUpdate() async {
    var isUpdated = await Get.toNamed(
      Routes.create_article,
      arguments: articleDetails.value,
    );
    if (isUpdated != null && isUpdated) {
      getArticlesDetails(articleDetails.value?.id ?? '');
    }
  }
}
