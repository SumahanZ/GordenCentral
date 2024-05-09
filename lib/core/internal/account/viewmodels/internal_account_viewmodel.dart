// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/image_storage_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/account/repositories/implementations/internal_account_repository_impl.dart';
import 'package:tugas_akhir_project/widgets/global_providers/user_state.dart';
import 'package:tugas_akhir_project/models/account_request.dart';
part 'internal_account_viewmodel.g.dart';

@riverpod
class InternalAccountViewModel extends _$InternalAccountViewModel {
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
          .read(internalAccountRepository)
          .editInternalInformation(
              request: request.copyWith(profilePhotoUrl: imageUrl), ref: ref)
          .run();
      task.match((l) {
        print(l.message);
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
}
