import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/cartitem.dart';
import 'package:tugas_akhir_project/models/customer.dart';

part 'cart.freezed.dart';
part 'cart.g.dart';

@freezed
class Cart with _$Cart {
  @JsonSerializable(explicitToJson: true)
  factory Cart({
    required int id,
    int? customerId,
    @JsonKey(fromJson: Cart._customerFromJson, toJson: Cart._customerToJson)
    Customer? customer,
    @JsonKey(
        fromJson: Cart._listCartItemsFromJson,
        toJson: Cart._listCartItemsToJson,
        name: "items")
    @Default([])
    List<CartItem> cartItemList,
  }) = _Cart;

  factory Cart.fromJson(Map<String, dynamic> json) => _$CartFromJson(json);

  static Customer? _customerFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Customer.fromJson(json);
  }

  static Map<String, dynamic>? _customerToJson(Customer? customer) {
    if (customer == null) return null;

    return customer.toJson();
  }

  static List<CartItem> _listCartItemsFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => CartItem.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listCartItemsToJson(
      List<CartItem> cartItemList) {
    if (cartItemList.isEmpty) return null;

    return {
      for (var i = 0; i < cartItemList.length; i++)
        '$i': cartItemList[i].toJson(),
    };
  }
}
