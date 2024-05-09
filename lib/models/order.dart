import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/customer.dart';
import 'package:tugas_akhir_project/models/orderitem.dart';
import 'package:tugas_akhir_project/models/orderstatus.dart';
import 'package:tugas_akhir_project/models/toko.dart';


part 'order.freezed.dart';
part 'order.g.dart';

@freezed
class Order with _$Order {
  @JsonSerializable(explicitToJson: true)
  factory Order({
    required int id,
    required String code,
    required double finalPriceTotal,
    required double discountAmountTotal,
    required double originalPriceTotal,
    String? note,
    int? customerId,
    @JsonKey(fromJson: Order._customerFromJson, toJson: Order._customerToJson)
    Customer? customer,
    @JsonKey(fromJson: Order._statusFromJson, toJson: Order._statusToJson)
    OrderStatus? status,
    @JsonKey(fromJson: Order._tokoFromJson, toJson: Order._tokoToJson)
    Toko? toko,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? completedAt,
    DateTime? cancelledAt,
    @JsonKey(
        fromJson: Order._listOrderItemsFromJson,
        toJson: Order._listOrderItemsToJson,
        name: "items")
    @Default([])
    List<OrderItem> orderItemList,
  }) = _Order;

  factory Order.fromJson(Map<String, dynamic> json) => _$OrderFromJson(json);

  static Customer? _customerFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Customer.fromJson(json);
  }

  static Map<String, dynamic>? _customerToJson(Customer? customer) {
    if (customer == null) return null;

    return customer.toJson();
  }

  static Toko? _tokoFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Toko.fromJson(json);
  }

  static Map<String, dynamic>? _tokoToJson(Toko? toko) {
    if (toko == null) return null;

    return toko.toJson();
  }

  static OrderStatus? _statusFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return OrderStatus.fromJson(json);
  }

  static Map<String, dynamic>? _statusToJson(OrderStatus? status) {
    if (status == null) return null;

    return status.toJson();
  }

  static List<OrderItem> _listOrderItemsFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => OrderItem.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listOrderItemsToJson(
      List<OrderItem> cartItemList) {
    if (cartItemList.isEmpty) return null;

    return {
      for (var i = 0; i < cartItemList.length; i++)
        '$i': cartItemList[i].toJson(),
    };
  }
}
