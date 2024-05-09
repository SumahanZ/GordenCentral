// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/customer/wishlist/repositories/implementations/customer_wishlist_repository_impl.dart';
part 'customer_wishlist_viewmodel.g.dart';

@riverpod
class CustomerWishlistViewModel extends _$CustomerWishlistViewModel {
  @override
  FutureOr<void> build() {
    //get toko information here
    //call get request here and later when i perform side effects we can do ref.invalidateSelf so the build is run again
  }

  Future<void> removeProdukFromWishlist({required int produkId}) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(customerWishlistProvider)
          .removeProdukFromWishlist(ref: ref, produkId: produkId)
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
