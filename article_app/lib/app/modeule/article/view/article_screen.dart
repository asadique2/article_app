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
      appBar: AppBar(title: Image.asset(AppImages.logo)),
      drawer: Drawer(),
      body: ListView.separated(
        separatorBuilder: (ctx, idx) => SizedBox(height: 10.h),
        itemBuilder: (ctx, idx) => articleCard(),
        itemCount: 20,
      ),
    );
  }

  Widget articleCard() {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.article_details),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.whiteColor,
          border: Border.all(color: AppColors.disableColor),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: AppColors.baseColor,
                borderRadius: BorderRadius.circular(8.r),
              ),
              height: 56.h,
              width: 56.h,
              child: Center(child: Text('S')),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  title(text: 'Granactive Retinoid 5%'),
                  SizedBox(height: 4.h),
                  body(
                    text:
                        'This water-free solution contains a 5% concentration of retinoid.',
                    maxLine: 4,
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      caption(text: "By: Jane Smith"),
                      caption(
                        text:
                            AppUtils.formatDate("2025-03-07T10:12:11.199Z") ??
                            '__',
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
