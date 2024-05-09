// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/image_storage_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
part 'toko_produk_viewmodel.g.dart';

@riverpod
class TokoProdukViewModel extends _$TokoProdukViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> editProduk(
      {required int produkId, required ProductSaved productSaved}) async {
    try {
      final profileTokoRepository = ref.read(profileTokoProvider);
      state = const AsyncLoading();

      final imagesColorUrl = await uploadProdukLocalImages(productSaved);

      final imagesGlobalUrl = await uploadProdukGlobalImages(productSaved);

      final alteredProductSaved = productSaved.copyWith(
        globalImageUrls: imagesGlobalUrl,
        productSelection: productSaved.productSelection.copyWith(
          colors: imagesColorUrl,
        ),
      );

      final task = await profileTokoRepository
          .editProduk(
              ref: ref, produkId: produkId, productSaved: alteredProductSaved)
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

  Future<List<Map<String, String>>> uploadProdukLocalImages(
      ProductSaved productSaved) async {
    List<Map<String, String>> copiedProductSavedColors =
        productSaved.productSelection.colors;

    if (productSaved.productSelection.colors.isNotEmpty) {
      for (var i = 0; i < productSaved.productSelection.colors.length; i++) {
        String? url = "";
        final imageStorageRepository = ref.read(imageStorageRepositoryProvider);
        if (productSaved.productSelection.colors[i]["imagePath"]!
            .startsWith("http://res.cloudinary.com/dkintlemd/image/upload/")) {
          url = productSaved.productSelection.colors[i]["imagePath"];
        } else {
          url = await imageStorageRepository.uploadImage(
              productSaved.productSelection.colors[i]["imagePath"]!);
        }

        copiedProductSavedColors[i]["imagePath"] = url!;
      }
    }

    return copiedProductSavedColors;
  }

  Future<List<String>> uploadProdukGlobalImages(
      ProductSaved productSaved) async {
    List<String> imageUrls = [];
    if (productSaved.globalImageUrls.isNotEmpty) {
      for (var imageUrl in productSaved.globalImageUrls) {
        final imageStorageRepository = ref.read(imageStorageRepositoryProvider);
        imageUrls.add(await imageStorageRepository.uploadImage(imageUrl));
      }
    }
    return imageUrls;
  }
}
