import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/laporanbarang/repositories/sources/internal_laporanbarang_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/laporanbarangkeluar.dart';
import 'package:tugas_akhir_project/models/laporanbarangmasuk.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

part 'internal_laporanbarang_repository_impl.g.dart';

final fetchLaporanGeneralInformation =
    FutureProvider.autoDispose<Either<ApiError, Map<String, dynamic>>>((ref) {
  final barangApi = ref.watch(internalLaporanBarangRepositoryProvider);
  final response = barangApi.fetchLaporanGeneralInformation(ref: ref).run();
  return response;
});

final fetchLaporanBarangKeluar =
    FutureProvider.autoDispose<Either<ApiError, List<LaporanBarangKeluar>>>(
        (ref) {
  final barangApi = ref.watch(internalLaporanBarangRepositoryProvider);
  final response = barangApi.fetchLaporanBarangKeluar(ref: ref).run();
  return response;
});

final fetchLaporanBarangMasuk =
    FutureProvider.autoDispose<Either<ApiError, List<LaporanBarangMasuk>>>(
        (ref) {
  final barangApi = ref.watch(internalLaporanBarangRepositoryProvider);
  final response = barangApi.fetchLaporanBarangMasuk(ref: ref).run();
  return response;
});

@riverpod
Future<
        ({
          Either<ApiError, Map<String, dynamic>> generalInformation,
          Either<ApiError, List<LaporanBarangKeluar>> laporanBarangKeluar,
          Either<ApiError, List<LaporanBarangMasuk>> laporanBarangMasuk
        })>
    fetchLaporanBarangInformation(FetchLaporanBarangInformationRef ref) async {
  final value1 = await ref.watch(fetchLaporanGeneralInformation.future);
  final value2 = await ref.watch(fetchLaporanBarangKeluar.future);
  final value3 = await ref.watch(fetchLaporanBarangMasuk.future);
  return (
    generalInformation: value1,
    laporanBarangKeluar: value2,
    laporanBarangMasuk: value3
  );
}

final internalLaporanBarangRepositoryProvider = Provider((ref) =>
    InternalLaporanBarangRepositoryImpl(client: ref.watch(httpClient)));

class InternalLaporanBarangRepositoryImpl
    extends InternalLaporanBarangRepository {
  final http.Client _client;

  InternalLaporanBarangRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  TaskEither<ApiError, List<LaporanBarangKeluar>> fetchLaporanBarangKeluar(
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
          ApiVariables.fetchLaporanBarangKeluarInternalURL);
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

            var barangKeluar = List<LaporanBarangKeluar>.from(response
                .where((e) => e != null)
                .map((e) => LaporanBarangKeluar.fromJson(e)));

            return TaskEither.right(barangKeluar);
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
  TaskEither<ApiError, List<LaporanBarangMasuk>> fetchLaporanBarangMasuk(
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
          ApiVariables.fetchLaporanBarangMasukInternalURL);
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

            var barangMasuk = List<LaporanBarangMasuk>.from(response
                .where((e) => e != null)
                .map((e) => LaporanBarangMasuk.fromJson(e)));

            return TaskEither.right(barangMasuk);
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
  TaskEither<ApiError, Map<String, dynamic>> fetchLaporanGeneralInformation(
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
          ApiVariables.baseURL, ApiVariables.fetchLaporanGeneralInformationURL);
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
}
