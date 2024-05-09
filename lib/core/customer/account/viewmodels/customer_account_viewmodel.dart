// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/image_storage_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/account/repositories/implementations/customer_account_repository_impl.dart';
import 'package:tugas_akhir_project/widgets/global_providers/user_state.dart';
import 'package:tugas_akhir_project/models/account_request.dart';
part 'customer_account_viewmodel.g.dart';

@riverpod
class CustomerAccountViewModel extends _$CustomerAccountViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> editProfileInformation({required AccountRequest request}) async {
    try {
      String? imageUrl;
      final imageStorageRepository = ref.read(imageStorageRepositoryProvider);
      state = const AsyncLoading();
      if (request.profilePhotoUrl != null) {
        imageUrl =
            await imageStorageRepository.uploadImage(request.profilePhotoUrl!);
      }
      final task = await ref
          .read(customerAccountRepository)
          .editCustomerInformation(
              request: request.copyWith(profilePhotoUrl: imageUrl), ref: ref)
          .run();
      task.match((l) {
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        ref.read(userStateProvider.notifier).update((state) => state?.copyWith(
              name: r.name,
              phoneNumber: r.email,
              password: r.password,
            ));
        state = const AsyncData(null);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> configureDeliveryInformationCustomer({
    required String streetAddress,
    required int cityId,
    required String country,
    required String postalCode,
  }) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(customerAccountRepository)
          .configureDeliveryInformation(
              streetAddress: streetAddress,
              cityId: cityId,
              country: country,
              postalCode: postalCode,
              ref: ref)
          .run();
      task.match((l) {
        print(l.message);
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        state = const AsyncData(null);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  // final authRepository = ref.read(authRepositoryProvider);
  //   state = const AsyncLoading();
  //   final apiResult = await authRepository
  //       .completeCustomerPersonalization(
  //           streetAddress: streetAddress,
  //           city: city,
  //           country: country,
  //           postalCode: postalCode,
  //           ref: ref)
  //       .run();
  //   //CODE STARTING FROM HERE NOT RUN
  //   apiResult.match((l) => state = AsyncValue.error(l, StackTrace.current),
  //       (r) {
  //     ref
  //         .read(userStateProvider.notifier)
  //         .update((state) => state?.copyWith(personalizationFinished: true));
  //     try {
  //       state = const AsyncData<void>(null);
  //     } catch (error) {
  //       if (kDebugMode) {
  //         print(error.toString());
  //       }
  //     }
  //   });
}
