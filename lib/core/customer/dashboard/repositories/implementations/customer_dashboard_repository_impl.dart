import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/dashboard/repositories/sources/customer_dashboard_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

part 'customer_dashboard_repository_impl.g.dart';

final fetchMostPopularProducts =
    FutureProvider.autoDispose<Either<ApiError, List<Produk>>>((ref) {
  final dashboardApi = ref.watch(customerDashboardRepositoryProvider);
  final response = dashboardApi.fetchMostPopularProducts(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchNewArrivalProducts =
    FutureProvider.autoDispose<Either<ApiError, List<Produk>>>((ref) {
  final dashboardApi = ref.watch(customerDashboardRepositoryProvider);
  final response = dashboardApi.fetchNewArrivalProducts(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchPromoProducts =
    FutureProvider.autoDispose<Either<ApiError, List<Produk>>>((ref) {
  final dashboardApi = ref.watch(customerDashboardRepositoryProvider);
  final response = dashboardApi.fetchPromoProducts(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchOrdersProcessingCompletedCount =
    FutureProvider.autoDispose<Either<ApiError, Map<String, dynamic>>>((ref) {
  final dashboardApi = ref.watch(customerDashboardRepositoryProvider);
  final response = dashboardApi.fetchOrderCompletedOngoingCount(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

@riverpod
Future<
    ({
      Either<ApiError, List<Produk>> popular,
      Either<ApiError, List<Produk>> newArrival,
      Either<ApiError, List<Produk>> promo,
      Either<ApiError, Map<String, dynamic>> counts
    })> fetchDashboardInformation(FetchDashboardInformationRef ref) async {
  final value1 = await ref.watch(fetchMostPopularProducts.future);
  final value2 = await ref.watch(fetchNewArrivalProducts.future);
  final value3 = await ref.watch(fetchPromoProducts.future);
  final value4 = await ref.watch(fetchOrdersProcessingCompletedCount.future);
  return (popular: value1, newArrival: value2, promo: value3, counts: value4);
}

final customerDashboardRepositoryProvider = Provider(
    (ref) => CustomerDashboardRepositoryImpl(client: ref.watch(httpClient)));

class CustomerDashboardRepositoryImpl extends CustomerDashboardRepository {
  final http.Client _client;

  CustomerDashboardRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  TaskEither<ApiError, List<Produk>> fetchMostPopularProducts(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(
          ApiVariables.baseURL, ApiVariables.fetchMostPopularProductsURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var produks = List<Produk>.from(response
                .where((e) => e != null)
                .map((e) => Produk.fromJson(e)));

            return TaskEither.right(produks);
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

  @override
  TaskEither<ApiError, List<Produk>> fetchNewArrivalProducts(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(
          ApiVariables.baseURL, ApiVariables.fetchNewArrivalProductsURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var produks = List<Produk>.from(response
                .where((e) => e != null)
                .map((e) => Produk.fromJson(e)));

            return TaskEither.right(produks);
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

  @override
  TaskEither<ApiError, Map<String, dynamic>> fetchOrderCompletedOngoingCount(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(ApiVariables.baseURL,
          ApiVariables.fetchOrderCompletedOngoingCountURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
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

  @override
  TaskEither<ApiError, List<Produk>> fetchPromoProducts(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.http(ApiVariables.baseURL, ApiVariables.fetchPromoProductsURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());

            var produks = List<Produk>.from(response
                .where((e) => e != null)
                .map((e) => Produk.fromJson(e)));

            return TaskEither.right(produks);
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
