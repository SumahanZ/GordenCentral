import 'dart:convert';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/orders/repositories/sources/customer_order_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchOrders =
    FutureProvider.autoDispose<fp.Either<ApiError, List<Order>>>((Ref ref) {
  final cartApi = ref.watch(customerOrderRepositoryProvider);
  final response = cartApi.fetchOrders(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchOrdersProduks = FutureProvider.family
    .autoDispose<fp.Either<ApiError, List<Produk>>, int>(
        (Ref ref, int orderId) {
  final cartApi = ref.watch(customerOrderRepositoryProvider);
  final response = cartApi.fetchOrdersProduk(ref: ref, orderId: orderId).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final customerOrderRepositoryProvider = Provider(
  (ref) => CustomerOrderRepositoryImpl(client: ref.watch(httpClient)),
);

class CustomerOrderRepositoryImpl extends CustomerOrderRepository {
  final http.Client _client;

  CustomerOrderRepositoryImpl({required http.Client client}) : _client = client;

  @override
  fp.TaskEither<ApiError, bool> cancelOrderCustomer({
    required Ref<Object?> ref,
    required int orderId,
  }) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.cancelOrderCustomerURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {"orderId": orderId},
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return fp.TaskEither.right(true);
          } catch (error) {
            return fp.TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return fp.TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  fp.TaskEither<ApiError, bool> completeOrderCustomer(
      {required Ref<Object?> ref,
      required int orderId,
      required List<Map<String, dynamic>> produkIdRatingList}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.completeOrderCustomerURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {"orderId": orderId, "produkIdRatingList": produkIdRatingList},
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            return fp.TaskEither.right(true);
          } catch (error) {
            return fp.TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return fp.TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  fp.TaskEither<ApiError, List<Order>> fetchOrders(
      {required Ref<Object?> ref}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url =
          Uri.https(ApiVariables.baseURL, ApiVariables.fetchOrdersCustomerURL);
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

            var orders = List<Order>.from(
                response.where((e) => e != null).map((e) => Order.fromJson(e)));

            return fp.TaskEither.right(orders);
          } catch (error) {
            return fp.TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return fp.TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }

  @override
  fp.TaskEither<ApiError, List<Produk>> fetchOrdersProduk(
      {required Ref<Object?> ref, required int orderId}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL,
          "${ApiVariables.fetchOrdersProdukURL}/$orderId");
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

            var products = List<Produk>.from(response
                .where((e) => e != null)
                .map((e) => Produk.fromJson(e)));

            return fp.TaskEither.right(products);
          } catch (error) {
            return fp.TaskEither.left(ResponseAPIError(
                responseStatusCode: 500,
                errorMessage: "Fail decoding JSON: $error"));
          }

        default:
          return fp.TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }
}
