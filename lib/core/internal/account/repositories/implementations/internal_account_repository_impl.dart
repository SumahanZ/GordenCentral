import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/account/repositories/sources/internal_account_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/account_request.dart';
import 'package:tugas_akhir_project/models/user.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final internalAccountRepository = Provider(
    (ref) => InternalAccountRepositoryImpl(client: ref.watch(httpClient)));

class InternalAccountRepositoryImpl extends InternalAccountRepository {
  final http.Client _client;

  InternalAccountRepositoryImpl({
    required http.Client client,
  }) : _client = client;

  @override
  TaskEither<ApiError, User> editInternalInformation(
      {required AccountRequest request, required Ref ref}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };

      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.editInternalInformationURL);
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
}
