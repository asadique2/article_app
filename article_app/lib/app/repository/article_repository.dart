import '../../base/base_repository.dart';

class AllRepository extends BaseRepository {
  Future<RepoResponse<GenericResponse>> updateUserData({
    required UserRegistrationUpdate requestData,
    required int? id,
    String? token,
  }) async {
    final response = await controller.put(
      path: "${URLs.userRegistration}$id/",
      data: requestData.toJson(),
      token: token,
    );

    return response is APIException
        ? RepoResponse(error: response)
        : RepoResponse(data: GenericResponse.fromJson(response));
  }
}
