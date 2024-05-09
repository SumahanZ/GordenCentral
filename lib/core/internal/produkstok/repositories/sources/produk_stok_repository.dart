import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_notifier.dart';

abstract class ProdukStokRepository<R, T> {
  TaskEither<R, T> inputProduk(
      {required List<ProdukStok> produkStok,
      required ProductSaved productSaved,
      required String issuedAt,
      required String deliveredAt,
      required int deliveryTime,
      required int totalAmount,
      required Ref ref});
  TaskEither<R, T> addProdukCategory({required String name, required Ref ref});
  TaskEither<R, T> fetchCategories({required Ref ref});
  TaskEither<R, T> fetchProduks({required Ref ref});
  TaskEither<R, T> fetchProduksTable({required Ref ref});
  TaskEither<R, T> fetchProdukStockOutOfStockCritical({required Ref ref});
  TaskEither<R, T> addStok(
      {required List<ProdukStok> produkStok,
      required int produkId,
      required String issuedAt,
      required String deliveredAt,
      required int deliveryTime,
      required int totalAmount,
      required Ref ref});
  TaskEither<R, T> calculateSafetyStockAndReorderPoint({required Ref ref});
  TaskEither<R, T> checkSafetyStockAndReorderPoint({required Ref ref});
}
