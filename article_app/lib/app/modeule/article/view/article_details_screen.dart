import 'package:article_app/app/modeule/article/controller/article_details_controller.dart';
import 'package:article_app/app/widgets/common_text.dart';
import 'package:article_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../themes/app_colors.dart';

class ArticleDetailsScreen extends GetView<ArticleDetailsController> {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Article Details')),
      body: Obx(
        () =>
            controller.isLoadingData.value
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20.h),
                      title(
                        text: controller.articleDetails.value?.title ?? 'Na',
                        maxLine: 5,
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          caption(
                            text:
                                "By: ${controller.articleDetails.value?.author ?? 'Na'}",
                          ),
                          caption(
                            text:
                                AppUtils.formatDate(
                                  controller.articleDetails.value?.createdAt,
                                ) ??
                                '__',
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      label(text: 'Details'),
                      SizedBox(height: 10.h),
                      body(
                        text:
                            controller.articleDetails.value?.description ??
                            'Na',
                      ),
                    ],
                  ).paddingSymmetric(horizontal: 12.w),
                ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.baseColor,
        foregroundColor: AppColors.whiteColor,
        onPressed:
            () =>
                !controller.isLoadingData.value
                    ? controller.handelUpdate()
                    : {},
        label: Row(
          children: [
            Icon(Icons.edit, size: 18.sp),
            SizedBox(width: 10.w),
            label(text: 'Edit Article'),
          ],
        ),
      ),
    );
  }
}
