import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/produk_combination.dart';

part 'cartitem.freezed.dart';
part 'cartitem.g.dart';

@freezed
class CartItem with _$CartItem {
  @JsonSerializable(explicitToJson: true)
  factory CartItem({
    required int id,
    int? amount,
    @JsonKey(fromJson: CartItem._combinationFromJson, toJson: CartItem._combinationToJson, name: "combination")
    ProdukCombination? produkCombination,
  }) = _CartItem;

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  static ProdukCombination? _combinationFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return ProdukCombination.fromJson(json);
  }

  static Map<String, dynamic>? _combinationToJson(ProdukCombination? produk) {
    if (produk == null) return null;

    return produk.toJson();
  }
}
