import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/models/account_request.dart';

abstract class CustomerAccountRepository<R, T> {
  TaskEither editCustomerInformation(
      {required AccountRequest request, required Ref ref});
  TaskEither configureDeliveryInformation(
      {required String streetAddress,
      required int cityId,
      required String country,
      required String postalCode,
      required Ref ref});
  TaskEither fetchDeliveryInformationCustomer({required Ref ref});
  TaskEither<R, T> getProvinces({required Ref ref});
  TaskEither<R, T> getCities({required Ref ref, required int provinceId});
}
