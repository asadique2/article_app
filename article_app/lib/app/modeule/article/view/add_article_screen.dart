import 'package:article_app/app/modeule/article/controller/add_article_controller.dart';
import 'package:article_app/app/themes/app_colors.dart';
import 'package:article_app/app/widgets/common_input_filed.dart';
import 'package:article_app/app/widgets/common_text.dart';
import 'package:article_app/app/widgets/custom_button.dart';
import 'package:article_app/utils/text_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddArticleScreen extends GetView<AddArticleController> {
  const AddArticleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isUpdating.value ? 'Update Article' : 'Create Article',
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            if (!controller.isUpdating.value) ...[
              title(text: 'Write and share your thoughts effortlessly'),
              SizedBox(height: 4.h),
              caption(
                text:
                    'Express your ideas, tell your story, or share valuable insights with the world. Start crafting engaging content that inspires, informs, or entertains. Your words matter—begin your article now and make an impact!',
              ),
              SizedBox(height: 30.h),
            ],
            CommonInputField(
              wrapper: controller.titleWrapper,
              labelText: 'Title',
            ),
            SizedBox(height: 20.h),
            CommonInputField(
              wrapper: controller.authorWrapper,
              labelText: 'Author',
            ),
            SizedBox(height: 20.h),
            CommonInputField(
              wrapper: controller.categoryWrapper,
              labelText: 'Category',
            ),
            SizedBox(height: 20.h),
            CommonInputField(
              wrapper: controller.descriptionWrapper,
              labelText: 'Description',
              maxLine: 5,
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: AppColors.whiteColor,
        color: AppColors.whiteColor,
        child: Obx(
          () => CustomButton(
            name: controller.isUpdating.value ? 'Update' : 'Submit',
            onTap: () => controller.handelButton(),
          ),
        ),
      ),
    );
  }
}
