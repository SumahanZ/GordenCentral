// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/customer/toko/repositories/implementations/customer_toko_repository_impl.dart';
part 'customer_toko_viewmodel.g.dart';

@riverpod
class CustomerTokoViewModel extends _$CustomerTokoViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> addProdukToWishlist({required int produkId}) async {
    try {
      final profileTokoRepository = ref.read(customerTokoProvider);
      state = const AsyncLoading();

      final task = await profileTokoRepository
          .addProdukToWishlist(ref: ref, produkId: produkId)
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

  Future<bool> addToCart(
      {required int produkVariationId, required int itemQuantity}) async {
    try {
      bool shouldBeHandle = false;
      final profileTokoRepository = ref.read(customerTokoProvider);
      state = const AsyncLoading();

      final task = await profileTokoRepository
          .addProdukVariationToCart(
              ref: ref,
              produkVariationId: produkVariationId,
              itemQuantity: itemQuantity)
          .run();
      task.match((l) {
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        shouldBeHandle = r.shouldBeHandled;
        state = const AsyncValue.data(null);
      });

      if (shouldBeHandle) {
        return false;
      } else {
        return true;
      }
    } catch (error) {
      print(error.toString());
      return true;
    }
  }

  Future<void> addToCartFromModal(
      {required int produkVariationId, required int itemQuantity}) async {
    try {
      final profileTokoRepository = ref.read(customerTokoProvider);
      state = const AsyncLoading();

      final task = await profileTokoRepository
          .addProdukVariationToCartFromModal(
              ref: ref,
              produkVariationId: produkVariationId,
              itemQuantity: itemQuantity)
          .run();
      task.match((l) {
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        state = const AsyncValue.data(null);
      });
    } catch (error) {
      print(error.toString());
    }
  }
}
