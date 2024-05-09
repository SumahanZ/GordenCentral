import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/repositories/sources/produk_stok_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/category.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final produkStokRepositoryProvider =
    Provider((ref) => ProdukStokRepositoryImpl(client: ref.read(httpClient)));

final fetchProductCategory =
    FutureProvider.autoDispose<Either<ApiError, List<Category>>>((ref) {
  final produkStokApi = ref.watch(produkStokRepositoryProvider);
  final response = produkStokApi.fetchCategories(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchProducts =
    FutureProvider.autoDispose<Either<ApiError, List<Produk>>>((ref) {
  final produkStokApi = ref.watch(produkStokRepositoryProvider);
  final response = produkStokApi.fetchProduks(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchProductsTable =
    FutureProvider.autoDispose<Either<ApiError, List<Produk>>>((ref) {
  final produkStokApi = ref.watch(produkStokRepositoryProvider);
  final response = produkStokApi.fetchProduksTable(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchStockGeneralInformation =
    FutureProvider.autoDispose<Either<ApiError, Map<String, dynamic>>>((ref) {
  final produkStokApi = ref.watch(produkStokRepositoryProvider);
  final response =
      produkStokApi.fetchProdukStockOutOfStockCritical(ref: ref).run();
  return response;
});

class ProdukStokRepositoryImpl extends ProdukStokRepository {
  final http.Client _client;

  ProdukStokRepositoryImpl({required http.Client client}) : _client = client;

  @override
  TaskEither<ApiError, bool> inputProduk(
      {required List<ProdukStok> produkStok,
      required ProductSaved productSaved,
      required String issuedAt,
      required String deliveredAt,
      required int deliveryTime,
      required int totalAmount,
      required Ref ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.http(ApiVariables.baseURL, ApiVariables.inputStokProductURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "produkSaved": productSaved.toMap(),
            "produkStok": List<Map<String, dynamic>>.from(
                produkStok.map((e) => e.toMap())),
            "issuedAt": issuedAt,
            "deliveredAt": deliveredAt,
            "deliveryTime": deliveryTime,
            "totalAmount": totalAmount
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
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
  TaskEither<ApiError, bool> addProdukCategory(
      {required String name, required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.http(ApiVariables.baseURL, ApiVariables.addProdukCategoryURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "name": name,
          },
        ),
      );
      return response;
    }, (error, stackTrace) {
      print(error.toString());
      return RequestError(errorMessage: error.toString());
    }).flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            print(value.body);
            return TaskEither.right(true);
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
  TaskEither<ApiError, List<Category>> fetchCategories(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(ApiVariables.baseURL, ApiVariables.fetchCategoriesURL);
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

            var categories = List<Category>.from(response
                .where((e) => e != null)
                .map((e) => Category.fromJson(e)));

            return TaskEither.right(categories);
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
  TaskEither<ApiError, List<Produk>> fetchProduks({required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.http(ApiVariables.baseURL, ApiVariables.fetchProduksAddStokURL);
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
  TaskEither<ApiError, List<Produk>> fetchProduksTable(
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
          Uri.http(ApiVariables.baseURL, ApiVariables.fetchProduksAddStokURL);
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
  TaskEither<ApiError, bool> addStok(
      {required List<ProdukStok> produkStok,
      required int produkId,
      required String issuedAt,
      required String deliveredAt,
      required int deliveryTime,
      required int totalAmount,
      required Ref ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(ApiVariables.baseURL, ApiVariables.addStokProductURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "produkId": produkId,
            "produkStok": List<Map<String, dynamic>>.from(
                produkStok.map((e) => e.toMap())),
            "issuedAt": issuedAt,
            "deliveredAt": deliveredAt,
            "deliveryTime": deliveryTime,
            "totalAmount": totalAmount
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return TaskEither.right(true);
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
  TaskEither<ApiError, bool> calculateSafetyStockAndReorderPoint(
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
          ApiVariables.calculateSafetyStockReorderPointURL);

      final response = await _client.post(
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
            return TaskEither.right(true);
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
  TaskEither<ApiError, Map<String, dynamic>> fetchProdukStockOutOfStockCritical(
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
          ApiVariables.fetchOutOfStockAndCriticalProductCountURL);
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
            return TaskEither.right(response);
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
  TaskEither<ApiError, bool> checkSafetyStockAndReorderPoint(
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
          ApiVariables.baseURL, ApiVariables.checkSafetyStockReorderPointURL);

      final response = await _client.post(
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
            return TaskEither.right(true);
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
