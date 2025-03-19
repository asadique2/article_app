import 'package:article_app/app/themes/app_colors.dart';
import 'package:article_app/data/images.dart';
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
        itemBuilder:
            (ctx, idx) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.whiteColor,
                border: Border.all(color: AppColors.disableColor),
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.baseColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.r),
                        bottomLeft: Radius.circular(16.r),
                      ),
                    ),
                    height: 56.h,
                    width: 56.h,
                    child: Center(child: Text('S')),
                  ),
                  Column(children: [Text('data'), Text('data'), Text('data')]),
                ],
              ),
            ).paddingSymmetric(horizontal: 12.w),
        itemCount: 20,
      ),
    );
  }
}
