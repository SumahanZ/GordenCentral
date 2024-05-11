import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/browse-toko/repositories/sources/browse_toko_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/toko.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchTokos =
    FutureProvider.autoDispose<Either<ApiError, List<Toko>>>((ref) {
  final browseTokoApi = ref.watch(browseTokoRepositoryProvider);
  final response = browseTokoApi.fetchTokos(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final browseTokoRepositoryProvider =
    Provider((ref) => BrowseTokoRepositoryImpl(client: ref.watch(httpClient)));

class BrowseTokoRepositoryImpl extends BrowseTokoRepository {
  final http.Client _client;

  BrowseTokoRepositoryImpl({required http.Client client}) : _client = client;

  @override
  TaskEither<ApiError, List<Toko>> fetchTokos({required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL, ApiVariables.fetchTokosURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var tokos = List<Toko>.from(
                response.where((e) => e != null).map((e) => Toko.fromJson(e)));

            return TaskEither.right(tokos);
          } catch (error) {
            return TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }
}
