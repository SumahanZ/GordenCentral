import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

abstract class InternalAnalisisKeuanganRepository<R, T> {
  TaskEither<R, T> fetchGeneralInformation({required Ref ref});
  TaskEither<R, T> fetchRecentTransactions({required Ref ref});
  TaskEither<R, T> fetchSalesReport({required Ref ref});
}
