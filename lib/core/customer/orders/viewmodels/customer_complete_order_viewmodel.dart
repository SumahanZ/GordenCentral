// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/customer/orders/repositories/implementations/customer_order_repository_impl.dart';

part 'customer_complete_order_viewmodel.g.dart';

@riverpod
class CustomerCompleteOrderViewModel extends _$CustomerCompleteOrderViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> completeOrderCustomer({required int orderId, required List<Map<String, dynamic>> produkIdRatingList}) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(customerOrderRepositoryProvider)
          .completeOrderCustomer(ref: ref, orderId: orderId, produkIdRatingList: produkIdRatingList)
          .run();
          
      task.match((l) {
        print(l.message);
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        state = const AsyncData(null);
      });
    } catch (error) {
      print(error.toString());
      state = AsyncError(error, StackTrace.current);
    }
  }
}
