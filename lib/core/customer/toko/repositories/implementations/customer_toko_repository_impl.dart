// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:convert';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/toko/repositories/sources/customer_toko_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/katalog_produk.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/models/toko.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

part 'customer_toko_repository_impl.g.dart';

final fetchToko = FutureProvider.family
    .autoDispose<Either<ApiError, Toko?>, int>((ref, int tokoId) {
  final tokoApi = ref.watch(customerTokoProvider);
  final response = tokoApi.fetchToko(ref: ref, tokoId: tokoId).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

@riverpod
Future<Either<ApiError, Produk?>> fetchProdukDetail(
    FetchProdukDetailRef ref, int tokoId, int produkId) async {
  final tokoApi = ref.watch(customerTokoProvider);
  final response = tokoApi
      .fetchProdukDetail(ref: ref, produkId: produkId, tokoId: tokoId)
      .run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
}

final fetchKatalogProdukToko = FutureProvider.family
    .autoDispose<Either<ApiError, List<KatalogProduk>>, int>((ref, int tokoId) {
  final tokoApi = ref.watch(customerTokoProvider);
  final response =
      tokoApi.fetchTokoKatalogProduk(ref: ref, tokoId: tokoId).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

@riverpod
Future<(Either<ApiError, Toko?>, Either<ApiError, List<KatalogProduk>>)>
    fetchTokoAllInformation(FetchTokoAllInformationRef ref, int tokoId) async {
  final value1 = await ref.watch(fetchToko(tokoId).future);
  final value2 = await ref.watch(fetchKatalogProdukToko(tokoId).future);
  return (value1, value2);
}

final customerTokoProvider = Provider(
    (ref) => CustomerTokoRepositoryImpl(client: ref.watch(httpClient)));

class CustomerTokoRepositoryImpl extends CustomerTokoRepository {
  final http.Client _client;

  CustomerTokoRepositoryImpl({required http.Client client}) : _client = client;

  @override
  TaskEither<ApiError, Toko> fetchToko(
      {required Ref ref, required int tokoId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, "${ApiVariables.fetchCustomerTokoURL}/$tokoId");
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
      // print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var toko = Toko.fromJson(response);
            return TaskEither.right(toko);
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
  TaskEither<ApiError, List<KatalogProduk>> fetchTokoKatalogProduk(
      {required Ref ref, required int tokoId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL,
          "${ApiVariables.fetchCustomerKatalogProdukTokoURL}/$tokoId");
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

            var katalogProduk = List<KatalogProduk>.from(response
                .where((e) => e != null)
                .map((e) => KatalogProduk.fromJson(e)));

            return TaskEither.right(katalogProduk);
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
  TaskEither<ApiError, Produk> fetchProdukDetail(
      {required Ref<Object?> ref, required int produkId, required int tokoId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL,
          "${ApiVariables.fetchCustomerProdukDetail}/$tokoId/$produkId");
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) {
      print(error);
      return RequestError(errorMessage: error.toString());
    }).flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var produk = Produk.fromJson(response);
            return TaskEither.right(produk);
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
  TaskEither<ApiError, bool> addProdukToWishlist(
      {required Ref ref, required int produkId}) {
        print(produkId);
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.addProdukWishlistCustomerURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "produkId": produkId,
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
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
  TaskEither<ApiError, PopupMessage> addProdukVariationToCart(
      {required Ref ref,
      required int produkVariationId,
      required int itemQuantity}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.http(ApiVariables.baseURL, ApiVariables.addProdukCartCustomerURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "produkVariationId": produkVariationId,
            "itemQuantity": itemQuantity
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            final popupMessage = PopupMessage(
                popupMessage: jsonDecode(value.body.toString())["msg"],
                shouldBeHandled: (jsonDecode(value.body.toString())["msg"]) ==
                        "POPUP CHANGE TOKO"
                    ? true
                    : false);
            return TaskEither.right(popupMessage);
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
  TaskEither<ApiError, bool> addProdukVariationToCartFromModal(
      {required Ref<Object?> ref,
      required int produkVariationId,
      required int itemQuantity}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.addProdukCartCustomerFromModalURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "produkVariationId": produkVariationId,
            "itemQuantity": itemQuantity
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
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
