import 'package:article_app/app/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../app/model/generic_response.dart';
import '../app/model/response.dart';

class AppUtils {
  static String? formatDate(String? date) {
    if (date == null) {
      return null;
    }
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

  static showErrorMessage(RepoResponse<GenericResponse> response) {
    Fluttertoast.showToast(
      msg:
          response.error?.message ??
          response.data?.message ??
          'Something went wrong',
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: AppColors.warning,
      textColor: Colors.black,
      fontSize: 16.0,
    );
  }
}
