import 'dart:convert';

import 'package:article_app/app/model/ArticleListModel.dart';
import 'package:article_app/app/model/generic_response.dart';
import 'package:article_app/app/model/response.dart';
import 'package:article_app/app/routes/app_routes.dart';
import 'package:article_app/base/base_controller.dart';
import 'package:article_app/utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../../repository/article_repository.dart';
import '../view/filters_view.dart';

class ArticleController extends BaseController<ArticleRepository> {
  RxBool isLoadingData = false.obs;
  RxBool isLoadingMoreData = false.obs;
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
    List<String>? titles,
    List<String>? categories,
    List<String>? authors,
    bool isLoadMore = false, // New parameter for pagination
  }) async {
    if (!isLoadMore) {
      isLoadingData(true);
    } else {
      isLoadingMoreData(true); // Show loading indicator when fetching more
    }

    try {
      // Construct filters properly
      Map<String, dynamic> filters = {
        if (titles != null && titles.isNotEmpty) "title": {"values": titles},
        if (categories != null && categories.isNotEmpty)
          "category": {"values": categories},
        if (authors != null && authors.isNotEmpty)
          "author": {"values": authors},
      };

      // Encode filters into a JSON string for API request
      Map<String, dynamic> queryParams = {
        "page": page,
        "size": size,
        if (filters.isNotEmpty) "filters": jsonEncode(filters), // JSON encoded
      };

      RepoResponse<GenericResponse> response = await repository.getArticles(
        queryParams,
      );

      if (response.data?.statusCode == 200) {
        ArticleListModel articleList = ArticleListModel.fromJson(
          response.data?.data,
        );

        if (articleList.article?.isNotEmpty ?? false) {
          if (!isLoadMore) {
            articles.value = articleList.article ?? []; // Refresh data
          } else {
            articles.addAll(articleList.article ?? []); // Append for pagination
          }
          lastPage(articleList.lastPage);
          currentPage(articleList.currentPage);
        }

        updateFilterValue(articleList); // Update filter values dynamically
      } else {
        AppUtils.showErrorMessage(response);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error fetching articles: $e");
      }
    } finally {
      isLoadingData(false);
      isLoadingMoreData(false); // Hide loader
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

  void loadMoreArticles() {
    if (currentPage < lastPage.value && !isLoadingMoreData.value) {
      getArticles(
        page: currentPage.value + 1,
        size: 10, // Keep the same page size
        titles: selectedTitles,
        categories: selectedCategory,
        authors: selectedAuthor,
        isLoadMore: true,
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
    currentPage(1);
    lastPage(1);
    articles.clear();
    getArticles(
      page: currentPage.value + 1,
      size: 10, // Keep the same page size
      titles: selectedTitles.value,
      categories: selectedCategory.value,
      authors: selectedAuthor.value,
    );
    Get.back();
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
