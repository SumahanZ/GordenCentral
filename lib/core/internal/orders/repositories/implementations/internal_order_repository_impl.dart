import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/orders/repositories/sources/internal_order_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/models/orderstatus.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchAllCustomerOrders =
    FutureProvider.autoDispose<fp.Either<ApiError, List<Order>>>((Ref ref) {
  final cartApi = ref.watch(internalOrderRepositoryProvider);
  final response = cartApi.fetchAllCustomerOrders(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchOrderStasuses =
    FutureProvider.autoDispose<fp.Either<ApiError, List<OrderStatus>>>((Ref ref) {
  final orderApi = ref.watch(internalOrderRepositoryProvider);
  final response = orderApi.fetchOrderStatuses(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final internalOrderRepositoryProvider = Provider(
    (ref) => InternalOrderRepositoryImpl(client: ref.watch(httpClient)));

class InternalOrderRepositoryImpl extends InternalOrderRepository {
  final http.Client _client;

  InternalOrderRepositoryImpl({required http.Client client}) : _client = client;

  @override
  fp.TaskEither cancelOrder({required Ref<Object?> ref, required int orderId}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL, ApiVariables.cancelOrderURL);

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
  fp.TaskEither<ApiError, List<Order>> fetchAllCustomerOrders(
      {required Ref<Object?> ref}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.fetchAllCustomerOrdersURL);
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

  //status can't be the same as the current status
  @override
  fp.TaskEither configureOrderLog(
      {required Ref<Object?> ref,
      required int orderId,
      required int statusId,
      String? logNote}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(ApiVariables.baseURL, ApiVariables.configureOrderURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {"orderId": orderId, "statusId": statusId, "logNote": logNote},
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
  fp.TaskEither<ApiError, List<OrderStatus>> fetchOrderStatuses(
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
          Uri.https(ApiVariables.baseURL, ApiVariables.fetchOrderStasusesURL);
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

            var ordersStasuses = List<OrderStatus>.from(
                response.where((e) => e != null).map((e) => OrderStatus.fromJson(e)));

            return fp.TaskEither.right(ordersStasuses);
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
