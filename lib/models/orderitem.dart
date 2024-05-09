import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/models/produk_combination.dart';

part 'orderitem.freezed.dart';
part 'orderitem.g.dart';

@freezed
class OrderItem with _$OrderItem {
  @JsonSerializable(explicitToJson: true)
  factory OrderItem({
    required int id,
    int? amount,
    @JsonKey(fromJson: OrderItem._combinationFromJson, toJson: OrderItem._combinationToJson, name: "combination")
    ProdukCombination? produkCombination,
    @JsonKey(fromJson: OrderItem._orderFromJson, toJson: OrderItem._orderToJson)
    Order? order,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);

  static ProdukCombination? _combinationFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return ProdukCombination.fromJson(json);
  }

  static Map<String, dynamic>? _combinationToJson(ProdukCombination? produk) {
    if (produk == null) return null;

    return produk.toJson();
  }

  static Order? _orderFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Order.fromJson(json);
  }

  static Map<String, dynamic>? _orderToJson(Order? order) {
    if (order == null) return null;

    return order.toJson();
  }
}
