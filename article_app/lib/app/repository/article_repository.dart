import 'package:article_app/app/model/ArticleRequestModel.dart';
import 'package:article_app/data/urls.dart';

import '../../base/base_repository.dart';
import '../../utils/exception_handler.dart';
import '../model/generic_response.dart';
import '../model/response.dart';

class ArticleRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> getArticles(
    Map<String, dynamic> queryParams,
  ) async {
    final response = await controller.get(
      path: URLs.getArticle,
      query: queryParams,
    );

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

  Future<RepoResponse<GenericResponse>> createArticle({
    required ArticleRequestModel data,
  }) async {
    final response = await controller.post(
      path: URLs.createArticle,
      data: data.toJson(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }

  Future<RepoResponse<GenericResponse>> updateArticle({
    required ArticleRequestModel data,
    required String id,
  }) async {
    final response = await controller.patch(
      path: '${URLs.updateArticle}/$id',
      data: data.toJson(),
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
