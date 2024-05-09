import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomerNotificationRepository<R, T> {
  TaskEither<R, T> fetchAllCustomerNotifications({required Ref ref});
}