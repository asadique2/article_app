import 'package:article_app/app/themes/app_colors.dart';
import 'package:article_app/app/widgets/common_input_filed.dart';
import 'package:article_app/app/widgets/common_text.dart';
import 'package:article_app/app/widgets/custom_button.dart';
import 'package:article_app/utils/text_field_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AddArticleScreen extends StatefulWidget {
  const AddArticleScreen({super.key});

  @override
  State<AddArticleScreen> createState() => _AddArticleScreenState();
}

class _AddArticleScreenState extends State<AddArticleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Article')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20.h),
            title(text: 'Write and share your thoughts effortlessly'),
            SizedBox(height: 4.h),
            caption(
              text:
                  'Express your ideas, tell your story, or share valuable insights with the world. Start crafting engaging content that inspires, informs, or entertains. Your words matter—begin your article now and make an impact!',
            ),
            SizedBox(height: 30.h),
            CommonInputField(wrapper: TextFieldWrapper(), labelText: 'Title'),
            SizedBox(height: 20.h),
            CommonInputField(wrapper: TextFieldWrapper(), labelText: 'Author'),
            SizedBox(height: 20.h),
            CommonInputField(
              wrapper: TextFieldWrapper(),
              labelText: 'Category',
            ),
            SizedBox(height: 20.h),
            CommonInputField(
              wrapper: TextFieldWrapper(),
              labelText: 'Description',
              maxLine: 5,
            ),
          ],
        ).paddingSymmetric(horizontal: 16.w),
      ),
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: AppColors.whiteColor,
        color: AppColors.whiteColor,
        child: CustomButton(name: 'Submit', onTap: () {}),
      ),
    );
  }
}
