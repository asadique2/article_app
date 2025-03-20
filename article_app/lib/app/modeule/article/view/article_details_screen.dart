import 'package:article_app/app/widgets/common_text.dart';
import 'package:article_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ArticleDetailsScreen extends StatelessWidget {
  const ArticleDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sadique')),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.h),
            title(
              text:
                  'Lorem Ipsum is simply dummy text of the printing and typesetting industry.',
              maxLine: 5,
            ),
            SizedBox(height: 10.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                caption(text: "By: Jane Smith"),
                caption(
                  text: AppUtils.formatDate("2025-03-07T10:12:11.199Z") ?? '__',
                ),
              ],
            ),
            SizedBox(height: 40.h),
            label(text: 'Details'),
            SizedBox(height: 10.h),
            body(
              text:
                  'This water-free solution contains a 5% concentration of retinoid.',
            ),
          ],
        ).paddingSymmetric(horizontal: 12.w),
      ),
    );
  }
}
