import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/core/auth/providers/auth_personalization_provider.dart';
import 'package:tugas_akhir_project/models/toko_information_request.dart';

abstract class AuthRepository<R, T> {
  TaskEither<R, T> signUpPemilikPersonalization(
      {required TokoInformationRequest toko,
      required AuthPersonalization authPersonalization,
      required String deviceToken, 
      required Ref ref,
      required String role});
  TaskEither<R, T> signUpKaryawanPersonalization(
      {required String code,
      String? inviteCode,
      required AuthPersonalization authPersonalization,
      required String deviceToken,
      required Ref ref,
      required String role});
  TaskEither<R, T> signUpCustomerPersonalization(
      {required String streetAddress,
      required int cityId,
      required String deviceToken,
      required String country,
      required String postalCode,
      required AuthPersonalization authPersonalization,
      required Ref ref});
  TaskEither<R, T> login(
      {required String email, required String password, required String deviceToken, required Ref ref});
  TaskEither<R, T> getUserData({required Ref ref});
  TaskEither<R, T> getEnrolledToko({required Ref ref});
  TaskEither<R, T> getProvinces({required Ref ref});
  TaskEither<R, T> getCities({required Ref ref, required int provinceId});
  TaskEither<R,T> logOut({required Ref ref});
}
