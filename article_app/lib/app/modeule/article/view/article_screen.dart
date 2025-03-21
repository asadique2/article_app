import 'package:article_app/app/model/ArticleListModel.dart';
import 'package:article_app/app/routes/app_routes.dart';
import 'package:article_app/app/themes/app_colors.dart';
import 'package:article_app/app/widgets/common_text.dart';
import 'package:article_app/data/images.dart';
import 'package:article_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../controller/article_controller.dart';

class ArticleScreen extends GetView<ArticleController> {
  const ArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(AppImages.logo),
        actions: [
          GestureDetector(
            onTap: () => controller.goToFilter(),
            child: Icon(Icons.sort).paddingOnly(right: 20.w),
          ),
        ],
      ),
      body: Obx(
        () =>
            controller.isLoadingData.value
                ? Center(child: CircularProgressIndicator())
                : controller.articles.isNotEmpty
                ? NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification scrollInfo) {
                    if (scrollInfo.metrics.pixels ==
                        scrollInfo.metrics.maxScrollExtent) {
                      controller
                          .loadMoreArticles(); // Load more data when user reaches bottom
                    }
                    return false;
                  },
                  child: ListView.separated(
                    separatorBuilder: (ctx, idx) => SizedBox(height: 10.h),
                    itemCount:
                        controller.articles.length + 1, // Add 1 for loader
                    itemBuilder: (ctx, idx) {
                      if (idx == controller.articles.length) {
                        return Obx(
                          () =>
                              controller.isLoadingMoreData.value
                                  ? Center(
                                    child: CircularProgressIndicator(),
                                  ) // Show loading at bottom
                                  : SizedBox.shrink(),
                        );
                      }
                      return articleCard(controller.articles[idx]);
                    },
                  ),
                )
                : Center(child: label(text: 'No article found')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.baseColor,
        foregroundColor: AppColors.whiteColor,
        onPressed:
            () =>
                !controller.isLoadingData.value
                    ? controller.handelCreateArticle()
                    : {},
        label: Row(
          children: [
            Icon(Icons.edit, size: 18.sp),
            SizedBox(width: 10.w),
            label(text: 'Create'),
          ],
        ),
      ),
    );
  }

  Widget articleCard(Article article) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.article_details, arguments: article.id),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.disableColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(text: article.title ?? 'Na', maxLine: 1),
                  SizedBox(height: 4.h),
                  body(text: article.description ?? 'Na', maxLine: 3),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      caption(text: "By: ${article.author ?? 'Na'}"),
                      caption(
                        text: AppUtils.formatDate(article.createdAt) ?? '__',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ).paddingAll(12.r),
      ).paddingSymmetric(horizontal: 12.w),
    );
  }
}
