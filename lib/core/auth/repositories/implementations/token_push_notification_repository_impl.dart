import 'dart:convert';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

//stream token
final onRefreshTokenStreamProvider = StreamProvider.autoDispose(
    (ref) => FirebaseMessaging.instance.onTokenRefresh);

final pushNotificationRepositoryProvider =
    Provider<PushNotificationRepositoryImpl>((ref) {
  return PushNotificationRepositoryImpl(client: ref.watch(httpClient));
});

class PushNotificationRepositoryImpl {
  final http.Client _client;

  PushNotificationRepositoryImpl({required http.Client client})
      : _client = client;
  Future<String?> getTokenDatabase(WidgetRef ref) async {
    try {
      final supported = await FirebaseMessaging.instance.isSupported();
      final token =
          supported ? await FirebaseMessaging.instance.getToken() : null;

      ref
          .read(sharedPreferenceRepositoryProvider)
          .saveCurrentDeviceToken(deviceToken: token);
      return token;
    } catch (e) {
      print(e.toString());
    }
    return null;
  }

  TaskEither<ApiError, bool> updateUserDeviceToken(
      {required Ref ref, required String deviceToken}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };

      var url =
          Uri.http(ApiVariables.baseURL, ApiVariables.updateUserDeviceTokenURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
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

  TaskEither<ApiError, bool> emptyDeviceToken(
      {required Ref ref, required String deviceToken}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };

      var url =
          Uri.http(ApiVariables.baseURL, ApiVariables.updateUserDeviceTokenURL);

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {
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
