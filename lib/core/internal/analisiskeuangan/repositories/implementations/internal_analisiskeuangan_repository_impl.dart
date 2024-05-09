import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart' as fp;
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/analisiskeuangan/repositories/sources/internal_analisiskeuangan_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

part 'internal_analisiskeuangan_repository_impl.g.dart';


@riverpod
Future<({fp.Either<ApiError, Map<String, dynamic>> generalInformation, fp.Either<ApiError, List<Order>> recentTransactions, fp.Either<ApiError, List<Order>> salesReport})> fetchAnalisisKeuanganInformation(FetchAnalisisKeuanganInformationRef ref) async {
  final value1 = await ref.watch(fetchGeneralInformationAnalisisKeuangan.future);
  final value2 = await ref.watch(fetchRecentTransactionsAnalisisKeuangan.future);
  final value3 = await ref.watch(fetchSalesReportAnalisisKeuangan.future);

  return (generalInformation: value1, recentTransactions: value2, salesReport: value3);
}

final fetchGeneralInformationAnalisisKeuangan =
    FutureProvider.autoDispose<fp.Either<ApiError, Map<String, dynamic>>>(
        (ref) {
  final internalKeuanganApi =
      ref.watch(internalAnalisisKeuanganRepositoryProvider);
  final response = internalKeuanganApi.fetchGeneralInformation(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchRecentTransactionsAnalisisKeuangan =
    FutureProvider.autoDispose<fp.Either<ApiError, List<Order>>>((ref) {
  final internalKeuanganApi =
      ref.watch(internalAnalisisKeuanganRepositoryProvider);
  final response = internalKeuanganApi.fetchRecentTransactions(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchSalesReportAnalisisKeuangan =
    FutureProvider.autoDispose<fp.Either<ApiError, List<Order>>>((ref) {
  final internalKeuanganApi =
      ref.watch(internalAnalisisKeuanganRepositoryProvider);
  final response = internalKeuanganApi.fetchSalesReport(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final internalAnalisisKeuanganRepositoryProvider = Provider((ref) =>
    InternalAnalisisKeuanganRepositoryImpl(client: ref.watch(httpClient)));

class InternalAnalisisKeuanganRepositoryImpl
    extends InternalAnalisisKeuanganRepository {
  final http.Client _client;

  InternalAnalisisKeuanganRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  fp.TaskEither<ApiError, Map<String, dynamic>> fetchGeneralInformation(
      {required Ref<Object?> ref}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(ApiVariables.baseURL,
          ApiVariables.fetchAnalisisKeuanganGeneralInformationURL);
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
            return fp.TaskEither.right(response as Map<String, dynamic>);
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
  fp.TaskEither<ApiError, List<Order>> fetchRecentTransactions(
      {required Ref<Object?> ref}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(ApiVariables.baseURL,
          ApiVariables.fetchAnalisisKeuanganRecentTransactionsURL);
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

            var barangKeluar = List<Order>.from(
                response.where((e) => e != null).map((e) => Order.fromJson(e)));

            return fp.TaskEither.right(barangKeluar);
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
  fp.TaskEither<ApiError, List<Order>> fetchSalesReport(
      {required Ref<Object?> ref}) {
    return fp.TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(ApiVariables.baseURL,
          ApiVariables.fetchAnalisisKeuanganSalesReportURL);
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

            var barangKeluar = List<Order>.from(
                response.where((e) => e != null).map((e) => Order.fromJson(e)));

            return fp.TaskEither.right(barangKeluar);
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
