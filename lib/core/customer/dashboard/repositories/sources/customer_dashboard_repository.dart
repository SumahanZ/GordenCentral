import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class CustomerDashboardRepository<R, T> {
  TaskEither<R, T> fetchMostPopularProducts({required Ref ref});
  TaskEither<R, T> fetchNewArrivalProducts({required Ref ref});
  TaskEither<R, T> fetchPromoProducts({required Ref ref});
  TaskEither<R, T> fetchOrderCompletedOngoingCount({required Ref ref});
}
