// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/produk.dart';
part 'katalog_produk_viewmodel.g.dart';

@riverpod
class KatalogProdukViewModel extends _$KatalogProdukViewModel {
  @override
  FutureOr<void> build() {
    //get toko information here
    //call get request here and later when i perform side effects we can do ref.invalidateSelf so the build is run again
  }

  Future<void> addKatalogProduk(
      {required List<Produk> produkList,
      required String katalogProdukName}) async {
    try {
      final profileTokoRepository = ref.read(profileTokoProvider);
      state = const AsyncLoading();

      final task = await profileTokoRepository
          .addKatalogProduk(
              ref: ref,
              produkList: produkList,
              katalogProdukName: katalogProdukName)
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

  Future<void> editKatalogProduk(
      {required List<Produk> produkList,
      required String katalogProdukName,
      required int katalogId}) async {
    try {
      final profileTokoRepository = ref.read(profileTokoProvider);
      state = const AsyncLoading();

      final task = await profileTokoRepository
          .editKatalogProduk(
              ref: ref,
              produkList: produkList,
              katalogProdukName: katalogProdukName,
              katalogId: katalogId)
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
