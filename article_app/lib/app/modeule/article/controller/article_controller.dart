import 'package:article_app/app/model/ArticleListModel.dart';
import 'package:article_app/app/model/generic_response.dart';
import 'package:article_app/app/model/response.dart';
import 'package:article_app/base/base_controller.dart';
import 'package:article_app/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../repository/article_repository.dart';

class ArticleController extends BaseController<ArticleRepository> {
  RxBool isLoadingData = false.obs;
  RxList<Article> articles = RxList();
  @override
  void onInit() {
    getArticles();
    super.onInit();
  }

  Future<void> getArticles() async {
    isLoadingData(true);
    try {
      RepoResponse<GenericResponse> response = await repository.getArticles();
      if (response.data?.statusCode == 200) {
        ArticleListModel articleList = ArticleListModel.fromJson(
          response.data?.data,
        );
        if (articleList.article?.isNotEmpty ?? false) {
          articles.value = articleList.article ?? [];
        }
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
    print(articles.length);
  }
}
