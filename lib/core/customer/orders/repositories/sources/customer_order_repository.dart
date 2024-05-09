import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomerOrderRepository<R, T> {
  TaskEither<R, T> fetchOrders({required Ref ref});
  TaskEither<R, T> fetchOrdersProduk({required Ref ref, required int orderId});
  TaskEither<R, T> completeOrderCustomer({required Ref ref, required int orderId, required List<Map<String, dynamic>> produkIdRatingList});
  TaskEither<R, T> cancelOrderCustomer({required Ref ref, required int orderId});
}