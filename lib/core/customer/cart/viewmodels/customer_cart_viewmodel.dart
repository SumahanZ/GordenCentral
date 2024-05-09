// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/implementations/customer_cart_repository_impl.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/sources/pdf_generator_repository.dart';
import 'package:tugas_akhir_project/core/customer/cart/repositories/sources/whatsapp_communicator_repository.dart';
import 'package:tugas_akhir_project/models/cart.dart';
import 'package:tugas_akhir_project/models/invoice.dart';
part 'customer_cart_viewmodel.g.dart';

@riverpod
class CustomerCartViewModel extends _$CustomerCartViewModel {
  @override
  FutureOr<void> build() {}

  Future<void> decreaseItemQuantityCartItem({required int cartItemId}) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(customerCartProvider)
          .decreaseCartItemQuantity(ref: ref, cartItemId: cartItemId)
          .run();
      task.match((l) {
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        state = const AsyncData(null);
      });
    } catch (error) {
      print(error.toString());
      state = AsyncError(error, StackTrace.current);
    }
  }

  Future<void> increaseItemQuantityCartItem({required int cartItemId}) async {
    try {
      state = const AsyncLoading();
      final task = await ref
          .read(customerCartProvider)
          .increaseCartItemQuantity(ref: ref, cartItemId: cartItemId)
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

  Future<void> createOrder(
      {required Cart cart,
      required String whatsAppNumber,
      required List<Invoice> invoiceList,
      required double finalPriceTotal,
      required double discountAmountTotal,
      required double originalPriceTotal}) async {
    try {
      state = const AsyncLoading();

      final task1 = await ref
          .read(customerCartProvider)
          .createOrder(
              ref: ref,
              cart: cart,
              finalPriceTotal: finalPriceTotal,
              discountAmountTotal: discountAmountTotal,
              originalPriceTotal: originalPriceTotal)
          .run();

      task1.match((l) {
        state = AsyncError(l, StackTrace.current);
      }, (r) async {
        final pdfFile = await ref
            .read(pdfGeneratorRepositoryProvider)
            .generatePDF(invoiceList);

        final task2 = await ref
            .read(whatsAppCommunicatorRepositoryProvider)
            .shareFilesWhatsAppCheckInstalled(
                whatsAppNumber: whatsAppNumber, filePath: pdfFile.path)
            .run();

        if (r) {
          task2.match((l) => state = AsyncError(l, StackTrace.current), (r) {});
        }

        state = const AsyncData(null);
      });
    } catch (error) {
      print(error.toString());
      state = AsyncError(error, StackTrace.current);
    }
  }
}
