import 'package:article_app/app/model/ArticleListModel.dart';
import 'package:article_app/app/model/ArticleRequestModel.dart';
import 'package:article_app/app/repository/article_repository.dart';
import 'package:article_app/base/base_controller.dart';
import 'package:article_app/utils/text_field_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../utils/app_utils.dart';
import '../../../model/generic_response.dart';
import '../../../model/response.dart';

class AddArticleController extends BaseController<ArticleRepository> {
  RxBool isUpdating = RxBool(false);
  RxBool isLoading = RxBool(false);

  final articleFormKey = GlobalKey<FormState>();

  Rx<Article?> article = Rx(null);

  TextFieldWrapper titleWrapper = TextFieldWrapper();
  TextFieldWrapper authorWrapper = TextFieldWrapper();
  TextFieldWrapper categoryWrapper = TextFieldWrapper();
  TextFieldWrapper descriptionWrapper = TextFieldWrapper();
  TextFieldWrapper readTimeWrapper = TextFieldWrapper();

  @override
  void onInit() {
    if (Get.arguments != null) {
      isUpdating(true);
      article(Get.arguments);
      fillData(Get.arguments);
    }
    super.onInit();
  }

  Future<void> createArticle() async {
    if (articleFormKey.currentState!.validate()) {
      isLoading(true);
      try {
        ArticleRequestModel article = ArticleRequestModel(
          title: titleWrapper.controller.text,
          author: authorWrapper.controller.text,
          description: descriptionWrapper.controller.text,
          category: categoryWrapper.controller.text,
          readTime: int.tryParse(readTimeWrapper.controller.text),
        );
        RepoResponse<GenericResponse> response = await repository.createArticle(
          data: article,
        );
        if (response.data?.statusCode == 200 ||
            response.data?.statusCode == 201) {
          Get.back(result: true);
        } else {
          AppUtils.showErrorMessage(response);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> updateArticle() async {
    if (articleFormKey.currentState!.validate()) {
      isLoading(true);
      try {
        ArticleRequestModel request = ArticleRequestModel(
          title: titleWrapper.controller.text,
          description: descriptionWrapper.controller.text,
          readTime: int.tryParse(readTimeWrapper.controller.text),
        );
        RepoResponse<GenericResponse> response = await repository.updateArticle(
          data: request,
          id: article.value?.id ?? '',
        );
        if (response.data?.statusCode == 200) {
          Get.back(result: true);
        } else {
          AppUtils.showErrorMessage(response);
        }
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      } finally {
        isLoading(false);
      }
    }
  }

  fillData(Article data) {
    titleWrapper.controller.text = data.title ?? '';
    authorWrapper.controller.text = data.author ?? '';
    descriptionWrapper.controller.text = data.description ?? '';
    categoryWrapper.controller.text = data.category ?? '';
    readTimeWrapper.controller.text =
        data.readTime != null ? data.readTime.toString() : '';
  }

  handelButton() {
    isUpdating.value ? updateArticle() : createArticle();
  }
}
