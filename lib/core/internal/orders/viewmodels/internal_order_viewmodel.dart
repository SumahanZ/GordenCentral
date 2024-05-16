// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/sources/pdf_generator_repository.dart';
import 'package:tugas_akhir_project/core/internal/orders/repositories/implementations/internal_order_repository_impl.dart';
import 'package:tugas_akhir_project/models/invoice.dart';

part 'internal_order_viewmodel.g.dart';

@riverpod
class InternalOrderViewModel extends _$InternalOrderViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> cancelOrder({required int orderId}) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(internalOrderRepositoryProvider)
          .cancelOrder(ref: ref, orderId: orderId)
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

  Future<void> downloadOpenPDF(List<Invoice> invoiceList) async {
    try {
      final file = await ref
          .read(pdfGeneratorRepositoryProvider)
          .generatePDF(invoiceList);

      await ref.read(pdfGeneratorRepositoryProvider).openFile(file);
      
    } catch (error) {
      print(error.toString());
      state = AsyncError(error, StackTrace.current);
    }
  }
}
