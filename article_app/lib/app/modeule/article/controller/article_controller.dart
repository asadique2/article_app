import 'package:article_app/app/model/ArticleListModel.dart';
import 'package:article_app/app/model/generic_response.dart';
import 'package:article_app/app/model/response.dart';
import 'package:article_app/app/routes/app_routes.dart';
import 'package:article_app/base/base_controller.dart';
import 'package:article_app/utils/app_utils.dart';
import 'package:article_app/utils/text_field_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../repository/article_repository.dart';
import '../view/filters_view.dart';

class ArticleController extends BaseController<ArticleRepository> {
  RxBool isLoadingData = false.obs;
  RxBool isLoadingMore = false.obs;
  RxList<Article> articles = RxList();

  RxInt currentPage = 1.obs;
  RxInt lastPage = 0.obs;

  RxList<String> selectedTitles = RxList();
  RxList<String> selectedAuthor = RxList();
  RxList<String> selectedCategory = RxList();

  RxList<String> titlesList = RxList();
  RxList<String> authorList = RxList();
  RxList<String> categoryList = RxList();

  final List<String> filterOptions = ["Title", "Category", "Author"];

  // Current selected filter
  RxString selectedFilter = "Title".obs;

  @override
  void onInit() {
    getArticles();
    super.onInit();
  }

  Future<void> getArticles({
    int page = 1,
    int size = 10,
    Map<String, dynamic>? filters,
    bool isLoadMore =
        false, // Parameter to differentiate normal fetch & load more
  }) async {
    if (isLoadingData.value || isLoadingMore.value) return;
    if (isLoadMore) {
      isLoadingMore(true);
    } else {
      isLoadingData(true);
    }

    try {
      Map<String, dynamic> queryParams = {
        "page": page,
        "size": size,
        if (filters != null) "filters": filters,
      };

      RepoResponse<GenericResponse> response = await repository.getArticles(
        queryParams,
      );
      if (response.data?.statusCode == 200) {
        ArticleListModel articleList = ArticleListModel.fromJson(
          response.data?.data,
        );

        if (articleList.article?.isNotEmpty ?? false) {
          if (isLoadMore) {
            articles.addAll(articleList.article ?? []);
          } else {
            articles.value = articleList.article ?? [];
          }
          lastPage(articleList.lastPage ?? 1);
          currentPage(articleList.currentPage ?? 1);
        }
        updateFilterValue(articleList);
      } else {
        AppUtils.showErrorMessage(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } finally {
      isLoadingData(false);
      isLoadingMore(false);
    }
  }

  void updateFilterValue(ArticleListModel articleList) {
    Set<String> authorSet = authorList.toSet();
    Set<String> categorySet = categoryList.toSet();
    Set<String> titleSet = titlesList.toSet();

    for (var article in articleList.article ?? []) {
      if (article.author != null) {
        authorSet.add(article.author!);
      }
      if (article.category != null) {
        categorySet.add(article.category!);
      }
      if (article.title != null) {
        titleSet.add(article.title!);
      }
    }

    authorList.value = authorSet.toList();
    categoryList.value = categorySet.toList();
    titlesList.value = titleSet.toList();
  }

  void loadMoreArticle() {
    if (currentPage.value < lastPage.value) {
      getArticles(
        page: currentPage.value + 1,
        isLoadMore: true,
        filters: {
          "title": {"values": selectedTitles},
          "category": {"values": selectedCategory}, // Example category
          "author": {"values": selectedAuthor},
        },
      );
    }
  }

  handelCreateArticle() async {
    var articleCreated = await Get.toNamed(Routes.create_article);
    if (articleCreated != null && articleCreated) {
      clearFilter();
      getArticles();
    }
  }

  clearFilter() {
    selectedAuthor.clear();
    selectedCategory.clear();
    selectedTitles.clear();
    authorList.clear();
    categoryList.clear();
    titlesList.clear();
  }

  // Method to get the active list based on selected filter
  RxList<String> get activeList {
    switch (selectedFilter.value) {
      case "Category":
        return categoryList;
      case "Author":
        return authorList;
      default:
        return titlesList;
    }
  }

  // Method to get the selected list based on selected filter
  RxList<String> get selectedList {
    switch (selectedFilter.value) {
      case "Category":
        return selectedCategory;
      case "Author":
        return selectedAuthor;
      default:
        return selectedTitles;
    }
  }

  // Toggle selection
  void toggleSelection(String item) {
    if (selectedList.contains(item)) {
      selectedList.remove(item);
    } else {
      selectedList.add(item);
    }
  }

  // Apply filters
  void applyFilters() {
    Map<String, dynamic> filters = {
      if (selectedTitles.isNotEmpty) "title": {"values": selectedTitles},
      if (selectedCategory.isNotEmpty) "category": {"values": selectedCategory},
      if (selectedAuthor.isNotEmpty) "author": {"values": selectedAuthor},
    };
    currentPage(1);
    lastPage(1);
    getArticles(filters: filters);
    Get.back(result: filters);
  }

  goToFilter() async {
    Get.to(() => FilterPage());
  }

  clearSelectedFilter() {
    selectedAuthor.clear();
    selectedCategory.clear();
    selectedTitles.clear();
  }
}
