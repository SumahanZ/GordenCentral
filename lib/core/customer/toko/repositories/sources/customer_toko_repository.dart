import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomerTokoRepository<R, T> {
  TaskEither<R, T> fetchToko({required Ref ref, required int tokoId});
  TaskEither<R, T> fetchTokoKatalogProduk({required Ref ref, required int tokoId});
  TaskEither<R, T> fetchProdukDetail({required Ref ref, required int produkId, required int tokoId});
  TaskEither<R, T> addProdukToWishlist({required Ref ref, required int produkId});
  TaskEither<R, T> addProdukVariationToCart({required Ref ref, required int produkVariationId, required int itemQuantity});
  TaskEither<R, T> addProdukVariationToCartFromModal({required Ref ref, required int produkVariationId, required int itemQuantity});
}
