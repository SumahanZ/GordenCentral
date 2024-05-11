import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/wishlist/repositories/sources/customer_wishlist_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/wishlist.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchWishlist = FutureProvider
    .autoDispose<Either<ApiError, Wishlist?>>((ref) {
  final tokoApi = ref.watch(customerWishlistProvider);
  final response =
      tokoApi.fetchWishlist(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final customerWishlistProvider = Provider(
    (ref) => CustomerWishlistRepositoryImpl(client: ref.watch(httpClient)));

class CustomerWishlistRepositoryImpl extends CustomerWishlistRepository {
  final http.Client _client;

  CustomerWishlistRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  TaskEither<ApiError, Wishlist> fetchWishlist(
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
          Uri.https(ApiVariables.baseURL, ApiVariables.fetchWishlistCustomerURL);
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
            var wishlist = Wishlist.fromJson(response);
            return TaskEither.right(wishlist);
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
  TaskEither<ApiError, bool> removeProdukFromWishlist(
      {required Ref<Object?> ref, required int produkId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL,
          "${ApiVariables.removeProdukWishlistCustomerURL}/$produkId");

      final response = await _client.delete(
        url,
        headers: requestHeaders,
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
