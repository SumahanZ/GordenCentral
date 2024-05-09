import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/models/produk.dart';

part 'promo_item_selection_notifier.g.dart';

@Riverpod(keepAlive: true)
class PromoItemSelectionNotifier
    extends _$PromoItemSelectionNotifier {
  @override
  Produk? build() {
    return null;
  }

  void selectProduct(Produk produk) {
    state = produk;
  }

  void emptySelection() {
    state = null;
  }
}
