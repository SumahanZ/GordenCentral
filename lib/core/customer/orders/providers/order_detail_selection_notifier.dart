import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/models/order.dart';

part 'order_detail_selection_notifier.g.dart';

@Riverpod(keepAlive: true)
class OrderDetailSelectionNotifier extends _$OrderDetailSelectionNotifier {
  @override
  Order? build() {
    return null;
  }

  void selectOrder(Order order) {
    state = order;
  }
}
