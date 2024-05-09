import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/models/produk.dart';

part 'product_stok_selection_notifier.g.dart';

@Riverpod(keepAlive: true)
class ProductStokSelectionNotifier extends _$ProductStokSelectionNotifier {
  @override
  Produk? build() {
    return null;
  }

  void selectProduk(Produk produk) {
    state = produk;
  }

  void unselectProduk() {
    state = null;
  }
}
