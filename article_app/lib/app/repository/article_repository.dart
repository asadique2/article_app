import 'package:article_app/data/urls.dart';

import '../../base/base_repository.dart';
import '../../utils/exception_handler.dart';
import '../model/generic_response.dart';
import '../model/response.dart';

class ArticleRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> getArticles() async {
    final response = await controller.get(path: URLs.getArticle);

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> getArticlesDetails(String id) async {
    final response = await controller.get(
      path: '${URLs.getArticleDetails}/$id',
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
