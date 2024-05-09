import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomerWishlistRepository<R, T> {
  TaskEither<R, T> fetchWishlist({required Ref ref});
  TaskEither<R, T> removeProdukFromWishlist(
      {required Ref ref, required int produkId});
}
