// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/auth/repositories/implementations/image_storage_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/repositories/implementations/produk_stok_repository_impl.dart';
part 'produk_stok_viewmodel.g.dart';

@riverpod
class ProdukStokViewModel extends _$ProdukStokViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> inputProduk(
      {required List<ProdukStok> produkStok,
      required ProductSaved productSaved,
      required String issuedAt,
      required String deliveredAt,
      required int deliveryTime,
      required int totalAmount}) async {
    try {
      final produkStokRepository = ref.read(produkStokRepositoryProvider);
      state = const AsyncLoading();
      final imagesColorUrl = await uploadProdukLocalImages(productSaved);
      final imagesGlobalUrl = await uploadProdukGlobalImages(productSaved);

      final alteredProductSaved = productSaved.copyWith(
        globalImageUrls: imagesGlobalUrl,
        productSelection: productSaved.productSelection.copyWith(
          colors: imagesColorUrl,
        ),
      );

      final task = await produkStokRepository
          .inputProduk(
              produkStok: produkStok,
              productSaved: alteredProductSaved,
              ref: ref,
              issuedAt: issuedAt,
              deliveredAt: deliveredAt,
              deliveryTime: deliveryTime,
              totalAmount: totalAmount)
          .run();
      task.match((l) {
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        if (!r) {
          return;
        }
        state = const AsyncData(null);
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
        if (imageUrl
            .startsWith("http://res.cloudinary.com/dkintlemd/image/upload/")) {
          imageUrls.add(imageUrl);
        } else {
          imageUrls.add(await imageStorageRepository.uploadImage(imageUrl));
        }
      }
    }
    return imageUrls;
  }

  Future<void> addProdukCategory({required String name}) async {
    try {
      final produkStokRepository = ref.read(produkStokRepositoryProvider);
      state = const AsyncLoading();

      final task = await produkStokRepository
          .addProdukCategory(name: name, ref: ref)
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

  Future<void> calculateSafetyStockReorderPoint() async {
    try {
      final produkStokRepository = ref.read(produkStokRepositoryProvider);
      state = const AsyncLoading();

      final task = await produkStokRepository
          .calculateSafetyStockAndReorderPoint(ref: ref)
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

  Future<void> checkSafetyStockReorderPoint() async {
    try {
      final produkStokRepository = ref.read(produkStokRepositoryProvider);
      final task = await produkStokRepository
          .checkSafetyStockAndReorderPoint(ref: ref)
          .run();

      task.match((l) {
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        if (!r) {
          return;
        }
      });
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> addStok(
      {required List<ProdukStok> produkStok,
      required int produkId,
      required String issuedAt,
      required String deliveredAt,
      required int deliveryTime,
      required int totalAmount}) async {
    try {
      final produkStokRepository = ref.read(produkStokRepositoryProvider);
      state = const AsyncLoading();

      final task = await produkStokRepository
          .addStok(
              produkStok: produkStok,
              produkId: produkId,
              ref: ref,
              issuedAt: issuedAt,
              deliveredAt: deliveredAt,
              deliveryTime: deliveryTime,
              totalAmount: totalAmount)
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
