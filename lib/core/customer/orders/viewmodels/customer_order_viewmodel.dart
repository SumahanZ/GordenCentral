// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/customer/orders/repositories/implementations/customer_order_repository_impl.dart';

part 'customer_order_viewmodel.g.dart';

@riverpod
class CustomerOrderViewModel extends _$CustomerOrderViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> cancelOrderCustomer({required int orderId}) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(customerOrderRepositoryProvider)
          .cancelOrderCustomer(ref: ref, orderId: orderId)
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
