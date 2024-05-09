import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:tugas_akhir_project/core/customer/search/providers/customer_search_filters_provider.dart';

abstract class CustomerSearchRepository<R, T> {
  TaskEither<R, T> fetchAllProduk({required Ref ref});
  TaskEither<R, T> fetchSearchFiltersOptions({required Ref ref});
  TaskEither<R, T> fetchFilteredProducts({required Ref ref, SearchFilter filter});
}