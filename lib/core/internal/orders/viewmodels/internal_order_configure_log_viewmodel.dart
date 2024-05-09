// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/internal/orders/repositories/implementations/internal_order_repository_impl.dart';

part 'internal_order_configure_log_viewmodel.g.dart';

@riverpod
class InternalOrderConfigureLogViewModel extends _$InternalOrderConfigureLogViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> configureOrderLog(
      {required int orderId, required int statusId, String? logNote}) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(internalOrderRepositoryProvider)
          .configureOrderLog(
              ref: ref, orderId: orderId, statusId: statusId, logNote: logNote)
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
