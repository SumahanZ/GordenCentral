// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/providers/auth_personalization_provider.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/auth_repository_impl.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/image_storage_repository_impl.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/shared_preference_repository_impl.dart';
import 'package:tugas_akhir_project/models/toko_information_request.dart';
import 'package:tugas_akhir_project/widgets/global_providers/enrolled_toko_state.dart';
import 'package:tugas_akhir_project/widgets/global_providers/user_state.dart';
import 'package:tugas_akhir_project/models/user.dart';
part 'auth_viewmodel.g.dart';

@riverpod
class AuthViewModel extends _$AuthViewModel {
  @override
  FutureOr<void> build() {}

  Future<User?> login(
      {required String password,
      required String email,
      required String deviceToken,
      bool fromTest = false}) async {
    User? user;
    final authRepository = ref.read(authRepositoryProvider);
    final localStorageRepository = ref.read(sharedPreferenceRepositoryProvider);
    state = const AsyncLoading<void>();
    final apiResult = await authRepository
        .login(
            password: password,
            email: email,
            deviceToken: deviceToken,
            ref: ref)
        .run();
    apiResult.match((l) => state = AsyncError(l, StackTrace.current), (r) {
      user = r;
      localStorageRepository.saveToken(token: r.token!);
      if (!fromTest) ref.read(userStateProvider.notifier).update((state) => r);
      //update enrolled toko here if it exists
      try {
        state = const AsyncData<void>(null);
      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
    return user;
  }

  Future<void> signUpCustomerPersonalization(
      {required AuthPersonalization authPersonalization,
      required String streetAddress,
      required int cityId,
      required String country,
      required String postalCode,
      required String deviceToken,
      bool fromTest = false}) async {
    final authRepository = ref.read(authRepositoryProvider);
    final localStorageRepository = ref.read(sharedPreferenceRepositoryProvider);
    state = const AsyncLoading<void>();

    final apiResult = await authRepository
        .signUpCustomerPersonalization(
            streetAddress: streetAddress,
            cityId: cityId,
            deviceToken: deviceToken,
            country: country,
            postalCode: postalCode,
            authPersonalization: authPersonalization,
            ref: ref)
        .run();
    apiResult.match((l) => state = AsyncError(l, StackTrace.current), (r) {
      localStorageRepository.saveToken(token: r.token!);
      if (!fromTest) ref.read(userStateProvider.notifier).update((state) => r);
      try {
        state = const AsyncData<void>(null);
      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
  }

  Future<void> signUpKaryawanPersonalization(
      {required AuthPersonalization authPersonalization,
      required String code,
      String? inviteCode,
      required String role,
      required String deviceToken,
      bool fromTest = false}) async {
    final authRepository = ref.read(authRepositoryProvider);
    final localStorageRepository = ref.read(sharedPreferenceRepositoryProvider);
    state = const AsyncLoading<void>();

    final apiResult = await authRepository
        .signUpKaryawanPersonalization(
            code: code,
            deviceToken: deviceToken,
            authPersonalization: authPersonalization,
            inviteCode: inviteCode,
            ref: ref,
            role: role)
        .run();
    apiResult.match((l) => state = AsyncError(l, StackTrace.current), (r) {
      localStorageRepository.saveToken(token: r.token!);
      if (!fromTest) ref.read(userStateProvider.notifier).update((state) => r);
      try {
        state = const AsyncData<void>(null);
      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
  }

  Future<void> signUpPemilikPersonalization(
      {required AuthPersonalization authPersonalization,
      required TokoInformationRequest toko,
      required String deviceToken,
      required String role,
      bool fromTest = false}) async {
    String? imageUrl;
    final authRepository = ref.read(authRepositoryProvider);
    final localStorageRepository = ref.read(sharedPreferenceRepositoryProvider);
    state = const AsyncLoading<void>();
    final imageStorageRepository = ref.read(imageStorageRepositoryProvider);
    if (toko.profilePhotoURL != null) {
      imageUrl =
          await imageStorageRepository.uploadImage(toko.profilePhotoURL!);
    }
    final apiResult = await authRepository
        .signUpPemilikPersonalization(
            toko: toko.copyWith(profilePhotoURL: imageUrl),
            authPersonalization: authPersonalization,
            deviceToken: deviceToken,
            ref: ref,
            role: role)
        .run();
    apiResult.match((l) => state = AsyncError(l, StackTrace.current), (r) {
      localStorageRepository.saveToken(token: r.token!);
      if (!fromTest) ref.read(userStateProvider.notifier).update((state) => r);
      try {
        state = const AsyncData<void>(null);
      } catch (error) {
        if (kDebugMode) {
          print(error.toString());
        }
      }
    });
  }

  // Future<void> signUpInternal({
  //   required String name,
  //   required String password,
  //   required String email,
  //   required String role,
  // }) async {
  //   final authRepository = ref.read(authRepositoryProvider);
  //   final localStorageRepository = ref.read(sharedPreferenceRepositoryProvider);
  //   state = const AsyncLoading();
  //   final apiResult = await authRepository
  //       .signUpInternal(
  //           name: name, password: password, email: email, role: role, ref: ref)
  //       .run();
  //   //CODE STARTING FROM HERE NOT RUN
  //   apiResult.match((l) => state = AsyncValue.error(l, StackTrace.current),
  //       (r) {
  //     localStorageRepository.saveToken(token: r.token!);
  //     ref.read(userStateProvider.notifier).update((state) => r);
  //     try {
  //       state = const AsyncData<void>(null);
  //     } catch (error) {
  //       if (kDebugMode) {
  //         print(error.toString());
  //       }
  //     }
  //   });
  // }

  // Future<void> completeCustomerPersonalization({
  //   required AuthPersonalization authPersonalization,
  //   required String streetAddress,
  //   required int cityId,
  //   required String country,
  //   required String postalCode,
  // }) async {
  //   final authRepository = ref.read(authRepositoryProvider);
  //   state = const AsyncLoading();
  //   final apiResult = await authRepository
  //       .completeCustomerPersonalization(
  //           streetAddress: streetAddress,
  //           cityId: cityId,
  //           country: country,
  //           postalCode: postalCode,
  //           ref: ref, authPersonalization: authPersonalization)
  //       .run();
  //   apiResult.match((l) => state = AsyncValue.error(l, StackTrace.current),
  //       (r) {
  //     // ref.read(userStateProvider.notifier).update((state) {
  //     //   return state?.copyWith(personalizationFinished: true);
  //     // });
  //     try {
  //       state = const AsyncData<void>(null);
  //     } catch (error) {
  //       if (kDebugMode) {
  //         print(error.toString());
  //       }
  //     }
  //   });
  // }

  // Future<void> completeInternalPersonalization({
  //   required String code,
  //   String? inviteCode,
  //   required String role,
  // }) async {
  //   final authRepository = ref.read(authRepositoryProvider);
  //   state = const AsyncLoading();
  //   final apiResult = await authRepository
  //       .completeInternalPersonalization(
  //           code: code, ref: ref, inviteCode: inviteCode, role: role)
  //       .run();
  //   apiResult.match((l) => state = AsyncValue.error(l, StackTrace.current),
  //       (r) {
  //     // ref.read(userStateProvider.notifier).update((state) {
  //     //   final newState = state?.copyWith(personalizationFinished: true);
  //     //   return newState;
  //     // });
  //     try {
  //       state = const AsyncData<void>(null);
  //     } catch (error) {
  //       if (kDebugMode) {
  //         print(error.toString());
  //       }
  //     }
  //   });
  // }

  Future<User?> getUserInformation() async {
    final authRepository = ref.read(authRepositoryProvider);
    state = const AsyncLoading();
    final apiResult = await authRepository.getUserData(ref: ref).run();
    final apiResultToko = await authRepository.getEnrolledToko(ref: ref).run();

    apiResult.match((l) => state = AsyncValue.error(l, StackTrace.current),
        (user) async {
      if (user?.type != "customer") {
        apiResultToko.match(
            (l) => state = AsyncValue.error(l, StackTrace.current), (toko) {
          toko != null
              ? ref
                  .read(enrolledTokoStateProvider.notifier)
                  .update((state) => toko)
              : null;
        });

        try {
          state = const AsyncData<void>(null);
        } catch (error) {
          if (kDebugMode) {
            print(error.toString());
          }
        }
      }
      ref.read(userStateProvider.notifier).update((state) => user);
      return user;
    });
    return null;
  }

  void logOut() async {
    final logOutResult =
        await ref.read(authRepositoryProvider).logOut(ref: ref).run();
    logOutResult.match((l) => print(l.message), (r) {
      ref.read(sharedPreferenceRepositoryProvider).deleteToken();
      ref.read(userStateProvider.notifier).update((state) => null);
      ref.read(enrolledTokoStateProvider.notifier).update((state) => null);
    });
  }
}
