import 'package:fpdart/fpdart.dart';
import 'package:riverpod/riverpod.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/models/toko_information_request.dart';

abstract class ProfileTokoRepository<R, T> {
  TaskEither<R, T> createTokoInformation(
      {required TokoInformationRequest request, required Ref ref});
  TaskEither<R, T> fetchTokoInformation({required Ref ref});
  TaskEither<R, T> configureBerandaToko(
      {required Ref ref, required List<String> imageUrls});
  TaskEither<R, T> fetchBerandaToko({
    required Ref ref,
  });
  TaskEither<R, T> fetchTokoProduk({required Ref ref});
  TaskEither<R, T> fetchKatalogProdukToko({required Ref ref});
  TaskEither<R, T> fetchKatalogProdukTokoPreview({required Ref ref});
  TaskEither<R, T> addKatalogProduk(
      {required Ref ref,
      required List<Produk> produkList,
      required String katalogProdukName});
  TaskEither<R, T> editKatalogProduk(
      {required Ref ref,
      required List<Produk> produkList,
      required String katalogProdukName,
      required int katalogId});
  TaskEither<R, T> fetchSingleKatalogProduk(
      {required Ref ref, required int katalogId});
  TaskEither<R, T> fetchProdukDetail({required Ref ref, required int produkId});
  TaskEither<R, T> editProduk(
      {required Ref ref,
      required int produkId,
      required ProductSaved productSaved});
  TaskEither<R, T> getProvinces({required Ref ref});
  TaskEither<R, T> getCities({required Ref ref, required int provinceId});
  TaskEither<R, T> fetchAvailablePromoItems({required Ref ref});
  TaskEither<R, T> addPromo(
      {required Ref ref,
      required int produkId,
      required String expiredAt,
      required int discountPercent});
  TaskEither<R, T> editPromo(
      {required Ref ref,
      required int promoId,
      required int produkId,
      required String expiredAt,
      required int discountPercent});
  TaskEither<R, T> removePromo({required Ref ref, required int promoId});
  TaskEither<R, T> fetchPromos({required Ref ref});
}
