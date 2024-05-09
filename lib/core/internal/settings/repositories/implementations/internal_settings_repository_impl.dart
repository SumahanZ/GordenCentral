import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/settings/repositories/sources/internal_settings_repository.dart';
import 'package:tugas_akhir_project/models/internal.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchInternalInformation =
    FutureProvider.autoDispose<Either<ApiError, Internal>>(
        (AutoDisposeRef ref) {
  final internalApi = ref.watch(internalSettingsRepository);
  final response = internalApi.fetchInternalInformation(ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final internalSettingsRepository = Provider(
    (ref) => InternalSettingsRepositoryImpl(client: ref.watch(httpClient)));

class InternalSettingsRepositoryImpl extends InternalSettingsRepository {
  final http.Client _client;

  InternalSettingsRepositoryImpl({
    required http.Client client,
  }) : _client = client;

  @override
  TaskEither<ApiError, Internal> fetchInternalInformation(Ref ref) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");

      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };

      var url = Uri.http(
          ApiVariables.baseURL, ApiVariables.fetchInternalInformationURL);
      final response = await _client.get(url, headers: requestHeaders);
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          var response = jsonDecode(value.body.toString());
          var internal = Internal.fromJson(response);
          return TaskEither.right(internal);
        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }
}
