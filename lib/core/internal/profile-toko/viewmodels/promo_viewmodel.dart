// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
part 'promo_viewmodel.g.dart';

@riverpod
class PromoViewModel extends _$PromoViewModel {
  @override
  FutureOr<void> build() {}

  //add promo
  Future<void> addPromo(
      {required int produkId,
      required String expiredAt,
      required int discountPercent}) async {
    try {
      final profileTokoRepository = ref.read(profileTokoProvider);
      state = const AsyncLoading();

      final task = await profileTokoRepository
          .addPromo(
              ref: ref,
              produkId: produkId,
              expiredAt: expiredAt,
              discountPercent: discountPercent)
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

  //edit promo
  Future<void> editPromo(
      {required int promoId,
      required int produkId,
      required String expiredAt,
      required int discountPercent}) async {
    try {
      final profileTokoRepository = ref.read(profileTokoProvider);
      state = const AsyncLoading();

      final task = await profileTokoRepository
          .editPromo(
              ref: ref,
              promoId: promoId,
              produkId: produkId,
              expiredAt: expiredAt,
              discountPercent: discountPercent)
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

  //remove promo
  Future<void> removePromo({required int promoId}) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(profileTokoProvider)
          .removePromo(ref: ref, promoId: promoId)
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
