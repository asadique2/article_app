import 'package:article_app/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class AppUtils {
  static String? formatDate(String date) {
    try {
      DateTime dateTime = DateTime.parse(date);
      String formattedDate = DateFormat("dd MMM yyyy").format(dateTime);
      return formattedDate;
    } catch (e) {
      return null;
    }
  }

  static getBottomSheet({required List<Widget> children, bool? isDisable}) =>
      Get.bottomSheet(
        GestureDetector(
          onTap: () {},
          onVerticalDragStart: (v) {},
          child: ListView(
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            children: children,
          ),
        ),
        backgroundColor: AppColors.whiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        isScrollControlled: true,
        ignoreSafeArea: true,
        isDismissible: true,
        persistent: false,
      );
}
