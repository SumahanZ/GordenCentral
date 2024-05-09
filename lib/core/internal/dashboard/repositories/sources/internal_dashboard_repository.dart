import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class InternalDashboardRepository<R, T> {
  TaskEither<R, T> fetchCompletedOngoingOrdersCount({required Ref ref});
}