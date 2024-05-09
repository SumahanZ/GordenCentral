import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class InternalOrderRepository<R, T> {
  TaskEither<R, T> fetchAllCustomerOrders({required Ref ref});
  TaskEither<R, T> fetchOrderStatuses({required Ref ref});
  TaskEither<R, T> cancelOrder({required Ref ref, required int orderId});
  TaskEither<R, T> configureOrderLog(
      {required Ref<Object?> ref,
      required int orderId,
      required int statusId,
      String? logNote});
}
