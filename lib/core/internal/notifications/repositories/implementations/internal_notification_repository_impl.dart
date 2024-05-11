import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/notifications/repositories/sources/internal_notification_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/toko_notification.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchAllTokoNotifications =
    FutureProvider.autoDispose<Either<ApiError, List<TokoNotification>>>(
        (Ref ref) {
  final notificationApi = ref.watch(internalTokoNotificationProvider);
  final response = notificationApi.fetchAllTokoNotifications(ref: ref).run();
  return response;
});

final internalTokoNotificationProvider = Provider(
    (ref) => InternalNotificationRepositoryImpl(client: ref.watch(httpClient)));

class InternalNotificationRepositoryImpl
    extends InternalNotificationRepository {
  final http.Client _client;

  InternalNotificationRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  TaskEither<ApiError, List<TokoNotification>> fetchAllTokoNotifications(
      {required Ref<Object?> ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };
      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.fetchTokoNotificationsURL);
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

            var notifications = List<TokoNotification>.from(response
                .where((e) => e != null)
                .map((e) => TokoNotification.fromJson(e)));

            return TaskEither.right(notifications);
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
