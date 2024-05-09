import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tugas_akhir_project/models/cart.dart';

abstract class CustomerCartRepository<R, T> {
  TaskEither<R, T> fetchCart({required Ref ref});
  TaskEither<R, T> increaseCartItemQuantity({required Ref ref, required int cartItemId});
  TaskEither<R, T> decreaseCartItemQuantity({required Ref ref, required int cartItemId});
  TaskEither<R, T> createOrder({required Ref ref, required Cart cart, required double finalPriceTotal, required double discountAmountTotal, required double originalPriceTotal});
}
