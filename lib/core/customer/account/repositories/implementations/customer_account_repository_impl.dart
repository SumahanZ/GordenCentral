import 'dart:convert';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/account/repositories/sources/customer_account_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/account_request.dart';
import 'package:tugas_akhir_project/models/address.dart';
import 'package:tugas_akhir_project/models/city.dart';
import 'package:tugas_akhir_project/models/province.dart';
import 'package:tugas_akhir_project/models/user.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchDeliveryInformation =
    FutureProvider.autoDispose<Either<ApiError, Address>>((AutoDisposeRef ref) {
  final customerApi = ref.watch(customerAccountRepository);
  final response = customerApi.fetchDeliveryInformationCustomer(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchProvinceslistFromAccount =
    FutureProvider.autoDispose<Either<ApiError, List<Province>>>((ref) {
  final accountApi = ref.watch(customerAccountRepository);
  final response = accountApi.getProvinces(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchCitieslistFromAccount = FutureProvider.family
    .autoDispose<Either<ApiError, List<City>>, int>((ref, int provinceId) {
  final accountApi = ref.watch(customerAccountRepository);
  final response = accountApi.getCities(ref: ref, provinceId: provinceId).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final customerAccountRepository = Provider(
    (ref) => CustomerAccountRepositoryImpl(client: ref.watch(httpClient)));

class CustomerAccountRepositoryImpl extends CustomerAccountRepository {
  final http.Client _client;

  CustomerAccountRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  TaskEither<ApiError, User> editCustomerInformation(
      {required AccountRequest request, required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };

      var url = Uri.http(
          ApiVariables.baseURL, ApiVariables.editCustomerInformationURL);
      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode({
          "email": request.email,
          "name": request.name,
          "password": request.password,
          "phoneNumber": request.phoneNumber,
          "profilePhotoUrl": request.profilePhotoUrl,
        }),
      );
      return response;
    }, (error, stackTrace) {
      print(error.toString());
      return RequestError(errorMessage: error.toString());
    }).flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var user = User.fromJson(response);
            return TaskEither.right(user);
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
  TaskEither<ApiError, bool> configureDeliveryInformation(
      {required String streetAddress,
      required int cityId,
      required String country,
      required String postalCode,
      required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(ApiVariables.baseURL,
          ApiVariables.configureCustomerDeliveryInformationURL);
      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "streetAddress": streetAddress,
            "cityId": cityId,
            "country": country,
            "postalCode": postalCode,
          },
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
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
  TaskEither<ApiError, Address> fetchDeliveryInformationCustomer(
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
          ApiVariables.fetchDeliveryInformationCustomerURL);
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
            var address = Address.fromJson(response);
            return TaskEither.right(address);
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
  TaskEither<ApiError, List<City>> getCities(
      {required Ref<Object?> ref, required int provinceId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(
          ApiVariables.baseURL, "${ApiVariables.getCitiesURL}/$provinceId");
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
            var cities = List<City>.from(
                response.where((e) => e != null).map((e) => City.fromJson(e)));
            return TaskEither.right(cities);
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
  TaskEither<ApiError, List<Province>> getProvinces(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.http(ApiVariables.baseURL, ApiVariables.getProvincesURL);
      final response = await _client.get(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var provinces = List<Province>.from(response
                .where((e) => e != null)
                .map((e) => Province.fromJson(e)));
            return TaskEither.right(provinces);
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
