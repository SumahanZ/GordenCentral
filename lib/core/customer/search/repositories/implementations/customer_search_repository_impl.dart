import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/search/providers/customer_search_filters_provider.dart';
import 'package:tugas_akhir_project/core/customer/search/repositories/sources/customer_search_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/models/searchoptions.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchAllProductsSearch =
    FutureProvider.autoDispose<Either<ApiError, List<Produk>>>((Ref ref) {
  final searchApi = ref.watch(customerSearchRepositoryProvider);
  final response = searchApi.fetchAllProduk(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchSearchOption =
    FutureProvider.autoDispose<Either<ApiError, SearchOption>>((Ref ref) {
  final searchApi = ref.watch(customerSearchRepositoryProvider);
  final response = searchApi.fetchSearchFiltersOptions(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchFilteredProducts = FutureProvider.family
    .autoDispose<Either<ApiError, List<Produk>>, SearchFilter?>(
        (Ref ref, SearchFilter? filter) {
  final searchApi = ref.watch(customerSearchRepositoryProvider);
  final response =
      searchApi.fetchFilteredProducts(ref: ref, filter: filter).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final customerSearchRepositoryProvider = Provider(
    (ref) => CustomerSearchRepositoryImpl(client: ref.watch(httpClient)));

class CustomerSearchRepositoryImpl extends CustomerSearchRepository {
  final http.Client _client;

  CustomerSearchRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  TaskEither<ApiError, List<Produk>> fetchAllProduk(
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
          Uri.https(ApiVariables.baseURL, ApiVariables.fetchAllProdukSearchURL);
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
  TaskEither<ApiError, SearchOption> fetchSearchFiltersOptions(
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
          Uri.https(ApiVariables.baseURL, ApiVariables.fetchSearchOptionURL);
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
            var searchOption = SearchOption.fromJson(response);
            return TaskEither.right(searchOption);
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
  TaskEither<ApiError, List<Produk>> fetchFilteredProducts(
      {required Ref<Object?> ref, SearchFilter? filter}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.fetchFilteredProductsURL);
      final response = await _client.post(url,
          headers: requestHeaders,
          body: jsonEncode(
            {
              "name": filter?.name,
              "priceRange": filter?.priceRange,
              "ratingRange": filter?.ratingRange,
              "categoriesList": filter?.categoriesList,
              "selectionTokoId": filter?.selectedTokoId,
            },
          ));
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
