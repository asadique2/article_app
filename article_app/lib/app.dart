import 'package:article_app/app/routes/app_routes.dart';
import 'package:article_app/app/themes/app_colors.dart';
import 'package:article_app/app_bindings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
        if (Get.isOverlaysOpen) Get.back();
      },
      child: ScreenUtilInit(
        designSize: Size(414, 896),
        child: GetMaterialApp(
          initialRoute: Routes.article,
          initialBinding: AppBinding(),
          getPages: AppPages.pages,
          theme: ThemeData(
            scaffoldBackgroundColor: AppColors.whiteColor,
            appBarTheme: AppBarTheme(
              backgroundColor: AppColors.whiteColor,
              surfaceTintColor: AppColors.baseColor,
            ),
          ),
        ),
      ),
    );
  }
}
