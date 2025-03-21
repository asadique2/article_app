import 'package:article_app/app/themes/app_colors.dart';
import 'package:article_app/app/widgets/common_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String name;
  final Function() onTap;
  final bool? isLoading;
  final bool? isFilled;
  const CustomButton({
    super.key,
    required this.name,
    required this.onTap,
    this.isLoading,
    this.isFilled,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: isFilled ?? true ? AppColors.baseColor : null,
          border: Border.all(color: AppColors.baseColor),
        ),
        child: Center(
          child:
              isLoading ?? false
                  ? CircularProgressIndicator(color: AppColors.whiteColor)
                  : boldBody(
                    text: name,
                    textColor:
                        isFilled ?? true
                            ? AppColors.whiteColor
                            : AppColors.baseColor,
                  ),
        ),
      ),
    );
  }
}
