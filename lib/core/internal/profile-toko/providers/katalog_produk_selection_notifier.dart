import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/models/produk.dart';

part 'katalog_produk_selection_notifier.g.dart';

@riverpod
class KatalogProdukItemSelectionNotifier
    extends _$KatalogProdukItemSelectionNotifier {
  @override
  List<Produk> build() {
    return [];
  }

  void addToSelection(Produk produk) {
    final tempStateList = List<Produk>.from(state);
    tempStateList.add(produk);
    state = tempStateList;
  }

  void removeFromSelection(int index) {
    final tempStateList = List<Produk>.from(state);
    tempStateList.removeAt(index);
    state = tempStateList;
  }

  void configureSelection(List<Produk> produk) {
    state = produk;
  }
}
