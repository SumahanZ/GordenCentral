import 'dart:convert';
import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/settings/repositories/sources/customer_setting_repository.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/customer.dart';
import 'package:tugas_akhir_project/utils/constants/api_variables.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';

final fetchCustomerInformation =
    FutureProvider.autoDispose<Either<ApiError, Customer>>(
        (AutoDisposeRef ref) {
  final customerApi = ref.watch(customerSettingsRepository);
  final response = customerApi.fetchCustomerInformation(ref).run();
  // ref.cacheFor(const Duration(hours: 2));
  return response;
});

final customerSettingsRepository = Provider(
    (ref) => CustomerSettingsRepositoryImpl(client: ref.watch(httpClient)));

class CustomerSettingsRepositoryImpl extends CustomerSettingsRepository {
  final http.Client _client;

  CustomerSettingsRepositoryImpl({required http.Client client})
      : _client = client;

  @override
  TaskEither<ApiError, Customer> fetchCustomerInformation(Ref<Object?> ref) {
    return TaskEither<ApiError, http.Response>.tryCatch(() async {
      final token = await ref
          .read(sharedPreferenceRepositoryProvider)
          .getToken(key: "token");

      Map<String, String> requestHeaders = {
        "Content-Type": "application/json; charset=UTF-8",
        "token": token!
      };

      var url = Uri.https(
          ApiVariables.baseURL, ApiVariables.fetchCustomerInformationURL);
      final response = await _client.get(url, headers: requestHeaders);
      return response;
    }, (error, stackTrace) => RequestError(errorMessage: error.toString())).flatMap((value) {
      switch (value.statusCode) {
        case >= 200 && <= 299:
          var response = jsonDecode(value.body.toString());
          var customer = Customer.fromJson(response);
          return TaskEither.right(customer);
        default:
          return TaskEither.left(ResponseAPIError(
              responseStatusCode: value.statusCode,
              errorMessage: jsonDecode(value.body.toString())["error"]));
      }
    });
  }
}
