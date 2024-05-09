import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

final whatsAppCommunicatorRepositoryProvider = Provider(
    (ref) => WhatsAppCommunicatorRepository(client: ref.watch(httpClient)));

class WhatsAppCommunicatorRepository {
  final http.Client _client;

  WhatsAppCommunicatorRepository({required http.Client client})
      : _client = client;
  TaskEither<ApiError, bool> phoneNumberWhatsappValid(
      {required String phoneNumber}) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        'X-RapidAPI-Key': 'e85cc8b61amshaf53a61a499e530p166805jsn707d6481b727',
        'X-RapidAPI-Host': 'whatsapp-number-validator3.p.rapidapi.com'
      };
      var url = Uri.parse(
          'https://whatsapp-number-validator3.p.rapidapi.com/WhatsappNumberHasItWithToken');

      final response = await _client.post(
        url,
        headers: requestHeaders,
        body: jsonEncode(
          {"phone_number": phoneNumber},
        ),
      );
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()))
        .flatMap((value) {
      print(value.body);
      switch (value.statusCode) {
        case >= 200 && <= 299:
          try {
            if (jsonDecode(value.body.toString())["status"] == "invalid") {
              return TaskEither.right(false);
            } else {
              return TaskEither.right(true);
            }
            // return TaskEither.right(true);
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

  TaskEither<ApiError, bool> checkWhatsAppInstalled() {
    return TaskEither<ApiError, bool>.tryCatch(() async {
      final val = await WhatsappShare.isInstalled(package: Package.whatsapp);
      print(val);
      return val ?? false;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString()));
  }

  TaskEither<ApiError, bool> shareFilesWhatsApp(
      {required String whatsAppNumber,
      required bool isInstalled,
      required String filePath}) {
    return TaskEither<ApiError, bool>.tryCatch(() async {
      if (isInstalled) {
        Directory? directory;
        if (Platform.isAndroid) {
          directory = await getExternalStorageDirectory();
        } else {
          directory = await getApplicationDocumentsDirectory();
        }
        debugPrint('${directory?.path}$filePath');

        await WhatsappShare.shareFile(
          phone: whatsAppNumber,
          filePath: [filePath],
        );

        return true;
      } else {
        throw RequestError(
            errorMessage: "Whatsapp is not installed in this app");
      }
    }, (error, stackTrace) {
      print(error.toString());
      return RequestError(errorMessage: error.toString());
    });
  }

  TaskEither<ApiError, bool> shareFilesWhatsAppCheckInstalled(
      {required String whatsAppNumber, required String filePath}) {
    print(filePath);
    return checkWhatsAppInstalled().flatMap((isInstalled) {
      return isInstalled
          ? TaskEither.right(isInstalled)
          : TaskEither.left(
              RequestError(errorMessage: "WhatsApp is not installed"));
    }).flatMap((r) {
      return shareFilesWhatsApp(
          whatsAppNumber: whatsAppNumber.replaceAll("+", ""),
          isInstalled: r,
          filePath: filePath);
    });
  }
}
