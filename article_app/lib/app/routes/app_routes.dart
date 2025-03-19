import 'package:article_app/app/modeule/article/binding/article_binding.dart';
import 'package:article_app/app/modeule/article/view/article_screen.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Routes {
  static const article = '/article';
  static const article_details = '/article/details';
  static const create_article = '/create/article';
}

class AppPages {
  static final pages = [
    GetPage(
      name: Routes.article,
      page: () => const ArticleScreen(),
      binding: ArticleBinding(),
    ),
  ];
}
