import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class InternalNotificationRepository<R, T> {
  TaskEither<R, T> fetchAllTokoNotifications({required Ref ref});
}