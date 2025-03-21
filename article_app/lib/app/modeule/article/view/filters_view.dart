import 'package:article_app/app/modeule/article/controller/article_controller.dart';
import 'package:article_app/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../widgets/custom_button.dart';

class FilterPage extends GetView<ArticleController> {
  const FilterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Filter Articles")),
      body: Row(
        children: [
          // Left Side (Fixed Filters)
          Container(
            width: 120,
            child: ListView.builder(
              itemCount: controller.filterOptions.length,
              itemBuilder: (context, index) {
                return Obx(
                  () => ListTile(
                    title: Text(controller.filterOptions[index]),
                    tileColor:
                        controller.selectedFilter.value ==
                                controller.filterOptions[index]
                            ? AppColors.baseColor
                            : AppColors.whiteColor,
                    onTap: () {
                      controller.selectedFilter.value =
                          controller.filterOptions[index];
                    },
                  ),
                );
              },
            ),
          ),

          // Right Side (Selectable Values)
          Expanded(
            child: Obx(
              () => ListView.builder(
                itemCount: controller.activeList.length,
                itemBuilder: (context, index) {
                  String item = controller.activeList[index];
                  return Obx(
                    () => CheckboxListTile(
                      title: Text(item),
                      value: controller.selectedList.contains(item),
                      onChanged: (bool? selected) {
                        controller.toggleSelection(item);
                      },
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),

      // Apply Button
      bottomNavigationBar: BottomAppBar(
        surfaceTintColor: AppColors.whiteColor,
        color: AppColors.whiteColor,
        child: Row(
          children: [
            Expanded(
              child: CustomButton(
                name: 'Clear',
                onTap: () => controller.clearSelectedFilter(),
                isFilled: false,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CustomButton(
                name: 'Filter',
                onTap: () async {
                  controller.applyFilters();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
