// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/image_storage_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/toko_information_request.dart';
import 'package:tugas_akhir_project/widgets/global_providers/enrolled_toko_state.dart';
part 'toko_information_viewmodel.g.dart';

@riverpod
class TokoInformationViewModel extends _$TokoInformationViewModel {
  @override
  FutureOr<void> build() {
    //get toko information here
    //call get request here and later when i perform side effects we can do ref.invalidateSelf so the build is run again
  }

  Future<void> createTokoInformation(
      {required TokoInformationRequest request}) async {
    try {
      String? imageUrl;
      final profileTokoRepository = ref.read(profileTokoProvider);
      state = const AsyncLoading();
      final imageStorageRepository = ref.read(imageStorageRepositoryProvider);
      if (request.profilePhotoURL != null) {
        imageUrl =
            await imageStorageRepository.uploadImage(request.profilePhotoURL!);
      }
      final task = await profileTokoRepository
          .createTokoInformation(
              request: request.copyWith(profilePhotoURL: imageUrl), ref: ref)
          .run();
      task.match((l) {
        ref.invalidateSelf();
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        ref.read(enrolledTokoStateProvider.notifier).update((state) => r);
        state = const AsyncValue.data(null);
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> configureBerandaToko(
      {required int tokoId, required List<String> imageUrls}) async {
    try {
      final List<String> cloudinaryImageUrls = [];
      final profileTokoRepository = ref.read(profileTokoProvider);
      state = const AsyncLoading();
      final imageStorageRepository = ref.read(imageStorageRepositoryProvider);
      if (imageUrls.isNotEmpty) {
        for (var imageUrl in imageUrls) {
          cloudinaryImageUrls
              .add(await imageStorageRepository.uploadImage(imageUrl));
        }
      }
      final task = await profileTokoRepository
          .configureBerandaToko(ref: ref, imageUrls: cloudinaryImageUrls)
          .run();
      task.match((l) {
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        if (!r) {
          return;
        }
        state = const AsyncValue.data(null);
      });
    } catch (error) {
      print(error.toString());
    }
  }
}
