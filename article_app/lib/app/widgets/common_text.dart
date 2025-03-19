import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget title({
  required String text,
  Color? textColor,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  int? maxLine,
}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: fontWeight ?? FontWeight.w600,
      fontSize: 18.sp,
      color: textColor,
    ),
    textAlign: textAlign,
    maxLines: maxLine,
  );
}

Widget label({
  required String text,
  Color? textColor,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  int? maxLine,
}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: fontWeight ?? FontWeight.w500,
      fontSize: 16.sp,
      color: textColor,
    ),
    textAlign: textAlign,
    maxLines: maxLine,
  );
}

Widget body({
  required String text,
  Color? textColor,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  int? maxLine,
}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: 14.sp,
      color: textColor,
    ),
    textAlign: textAlign,
    maxLines: maxLine,
  );
}

Widget caption({
  required String text,
  Color? textColor,
  TextAlign? textAlign,
  FontWeight? fontWeight,
  int? maxLine,
}) {
  return Text(
    text,
    style: TextStyle(
      fontWeight: fontWeight ?? FontWeight.w400,
      fontSize: 12.sp,
      color: textColor,
    ),
    textAlign: textAlign,
    maxLines: maxLine,
  );
}
