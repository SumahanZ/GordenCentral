// ignore_for_file: implementation_imports
import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/core/auth/providers/auth_personalization_provider.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/auth/repositories/sources/auth_repository.dart';
import 'package:tugas_akhir_project/models/city.dart';
import 'package:tugas_akhir_project/models/internal.dart';
import 'package:tugas_akhir_project/models/province.dart';
import 'package:tugas_akhir_project/models/toko.dart';
import 'package:tugas_akhir_project/models/toko_information_request.dart';
import 'package:tugas_akhir_project/models/user.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchProvinceslist =
    FutureProvider.autoDispose<Either<ApiError, List<Province>>>((ref) {
  final authApi = ref.watch(authRepositoryProvider);
  final response = authApi.getProvinces(ref: ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final fetchCitieslist = FutureProvider.family
    .autoDispose<Either<ApiError, List<City>>, int>((ref, int provinceId) {
  final authApi = ref.watch(authRepositoryProvider);
  final response = authApi.getCities(ref: ref, provinceId: provinceId).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final authRepositoryProvider = Provider<AuthRepositoryImpl>((ref) {
  return AuthRepositoryImpl(client: http.Client());
});

class AuthRepositoryImpl implements AuthRepository {
  final http.Client _client;

  AuthRepositoryImpl({
    required http.Client client,
  }) : _client = client;

  // @override
  // TaskEither<ApiError, User> signUpInternal(
  //     {required String name,
  //     required String password,
  //     required String email,
  //     required String role,
  //     required Ref ref}) {
  //   return TaskEither<ApiError, Response>.tryCatch(() async {
  //     Map<String, String> requestHeaders = {
  //       "Content-Type": "application/json; charset=UTF-8",
  //     };
  //     var url = Uri.http(ApiVariables.baseURL, ApiVariables.signUpInternalURL);
  //     final response = await _client.post(
  //       url,
  //       headers: requestHeaders,
  //       body: jsonEncode(
  //         {
  //           "name": name,
  //           "password": password,
  //           "email": email,
  //           "role": role,
  //         },
  //       ),
  //     );
  //     return response;
  //   }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
  //       .flatMap((value) {
  //     print(value.body);
  //     switch (value.statusCode) {
  //       case >= 200 && <= 299:
  //         var response = jsonDecode(value.body.toString());
  //         var user = User.fromJson(response);
  //         return TaskEither.right(user);
  //       default:
  //         return TaskEither.left(ResponseAPIError(
  //             responseStatusCode: value.statusCode,
  //             errorMessage: jsonDecode(value.body.toString())["error"]));
  //     }
  //   });
  // }

  // @override
  // TaskEither<ApiError, Internal> completeInternalPersonalization(
  //     {required String code,
  //     String? inviteCode,
  //     required String role,
  //     required Ref ref}) {
  //   return TaskEither<ApiError, Response>.tryCatch(() async {
  //     final token = await ref
  //         .read(sharedPreferenceRepositoryProvider)
  //         .getToken(key: "token");

  //     Map<String, String> requestHeaders = {
  //       "Content-Type": "application/json; charset=UTF-8",
  //       "token": token!,
  //     };

  //     var url = Uri.http(ApiVariables.baseURL,
  //         ApiVariables.completeInternalPersonalizationURL);
  //     final response = await _client.post(
  //       url,
  //       headers: requestHeaders,
  //       body: jsonEncode(
  //         {
  //           "userCode": code,
  //           "role": role,
  //           "inviteCode": inviteCode,
  //         },
  //       ),
  //     );
  //     return response;
  //   }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
  //       .flatMap((value) {
  //     switch (value.statusCode) {
  //       case >= 200 && <= 299:
  //         try {
  //           var response = jsonDecode(value.body.toString());
  //           var internal = Internal.fromJson(response);
  //           return TaskEither.right(internal);
  //         } catch (error) {
  //           return TaskEither.left(ResponseAPIError(
  //               responseStatusCode: 500,
  //               errorMessage: "Fail decoding JSON: $error"));
  //         }
  //       default:
  //         return TaskEither.left(ResponseAPIError(
  //             responseStatusCode: value.statusCode,
  //             errorMessage: jsonDecode(value.body.toString())["error"]));
  //     }
  //   });
  // }

  @override
  TaskEither<ApiError, User> signUpPemilikPersonalization(
      {required TokoInformationRequest toko,
      required AuthPersonalization authPersonalization,
      required Ref ref,
      required String deviceToken,
      required String role}) {
    return TaskEither<ApiError, Response>.tryCatch(() async {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var url = Uri.http(
          ApiVariables.baseURL, ApiVariables.completePemilikPersonalizationURL);
      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "name": authPersonalization.name,
            "password": authPersonalization.password,
            "email": authPersonalization.email,
            "role": role,
            "tokoId": toko.id,
            "tokoName": toko.name,
            "tokoPhoneNumber": toko.phoneNumber,
            "tokoProfilePhotoUrl": toko.profilePhotoURL,
            "tokoStreetAddress": toko.streetAddress,
            "cityId": toko.cityId,
            "tokoCountry": toko.country,
            "tokoPostalCode": toko.postalCode,
            "tokoBio": toko.bio,
            "tokoWhatsAppUrl": toko.whatsAppURL,
            "tokoInviteCode": toko.inviteCode,
            "deviceToken": deviceToken
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
  TaskEither<ApiError, User> signUpKaryawanPersonalization({
    required String code,
    String? inviteCode,
    required AuthPersonalization authPersonalization,
    required Ref ref,
    required String role,
    required String deviceToken,
  }) {
    return TaskEither<ApiError, Response>.tryCatch(() async {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var url = Uri.http(ApiVariables.baseURL,
          ApiVariables.completeKaryawanPersonalizationURL);
      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "name": authPersonalization.name,
            "password": authPersonalization.password,
            "email": authPersonalization.email,
            "role": role,
            "userCode": code,
            "inviteCode": inviteCode,
            "deviceToken": deviceToken
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
  TaskEither<ApiError, User> signUpCustomerPersonalization(
      {required String streetAddress,
      required int cityId,
      required String country,
      required String deviceToken,
      required String postalCode,
      required AuthPersonalization authPersonalization,
      required Ref ref}) {
    return TaskEither<ApiError, Response>.tryCatch(() async {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
      };
      var url = Uri.http(ApiVariables.baseURL,
          ApiVariables.completeCustomerPersonalizationURL);
      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
            "name": authPersonalization.name,
            "password": authPersonalization.password,
            "email": authPersonalization.email,
            "role": "customer",
            "streetAddress": streetAddress,
            "cityId": cityId,
            "country": country,
            "postalCode": postalCode,
            "deviceToken": deviceToken,
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
  TaskEither<ApiError, User> login(
      {required String email,
      required String password,
      required String deviceToken,
      required Ref ref}) {
    return TaskEither<ApiError, Response>.tryCatch(() async {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
      };

      var url = Uri.http(ApiVariables.baseURL, ApiVariables.loginURL);
      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {"email": email, "password": password, "deviceToken": deviceToken},
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            var response = jsonDecode(value.body.toString());
            var customer = User.fromJson(response);
            return TaskEither.right(customer);
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
  TaskEither<ApiError, User?> getUserData({required Ref ref}) {
    return TaskEither<ApiError, Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");

      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!,
      };

      var url = Uri.http(ApiVariables.baseURL, ApiVariables.getUserInfoURL);
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
  TaskEither<ApiError, Internal?> getEnrolledToko({required Ref<Object?> ref}) {
    return TaskEither<ApiError, Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");

      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!,
      };

      var url = Uri.http(ApiVariables.baseURL, ApiVariables.getEnrolledTokoURL);
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
            var internal = Internal.fromJson(response);
            return TaskEither.right(internal);
          } catch (error) {
            return TaskEither.left(
              ResponseAPIError(
                  responseStatusCode: 500,
                  errorMessage: "Fail decoding JSON: $error"),
            );
          }
        default:
          return TaskEither.left(
            ResponseAPIError(
                responseStatusCode: value.statusCode,
                errorMessage: jsonDecode(value.body.toString())["error"]),
          );
      }
    });
  }

  @override
  TaskEither<ApiError, List<City>> getCities(
      {required Ref<Object?> ref, required int provinceId}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      var url = Uri.http(
          ApiVariables.baseURL, "${ApiVariables.getCitiesURL}/$provinceId");
      final response = await _client.get(
        url,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
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
      var url = Uri.http(ApiVariables.baseURL, ApiVariables.getProvincesURL);
      final response = await _client.get(
        url,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
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

  @override
  TaskEither<ApiError, bool> logOut({required Ref<Object?> ref}) {
    return TaskEither<ApiError, Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };

      var url = Uri.http(ApiVariables.baseURL, ApiVariables.logoutURL);
      final response = await _client.post(
        url,
        headers: requestHeaders,
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
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

class DivisionService {
  double divide(int dividend, int divisor) {
    if (divisor == 0) {
      return 0;
    }
    final quotient = dividend / divisor;
    return quotient;
  }
}
