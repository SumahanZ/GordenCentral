import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/dashboard/repositories/sources/internal_dashboard_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchOrdersProcessingCompletedCountInternal =
    FutureProvider.autoDispose<Either<ApiError, Map<String, dynamic>>>((ref) {
  final dashboardApi = ref.watch(internalDashboardRepositoryProvider);
  final response =
      dashboardApi.fetchCompletedOngoingOrdersCount(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final internalDashboardRepositoryProvider = Provider(
    (ref) => InternalDashboardRepositoryImpl(client: ref.watch(httpClient)));

class InternalDashboardRepositoryImpl extends InternalDashboardRepository {
  final http.Client _client;

  InternalDashboardRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  TaskEither<ApiError, Map<String, dynamic>> fetchCompletedOngoingOrdersCount(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL,
          ApiVariables.fetchCompleteOngoingOrdersInternalURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            return TaskEither.right(response as Map<String, dynamic>);
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
