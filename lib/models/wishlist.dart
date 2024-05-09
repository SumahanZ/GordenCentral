import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/customer.dart';
import 'package:tugas_akhir_project/models/produk.dart';

part 'wishlist.freezed.dart';
part 'wishlist.g.dart';

//color
//sizes
//category
@freezed
class Wishlist with _$Wishlist {
  @JsonSerializable(explicitToJson: true)
  factory Wishlist({
    required int id,
    int? customerId,
    @JsonKey(fromJson: Wishlist._customerFromJson, toJson: Wishlist._customerToJson)
    Customer? customer,
    @JsonKey(
        fromJson: Wishlist._listProduksFromJson,
        toJson: Wishlist._listProduksToJson,
        name: "products")
    @Default([])
    List<Produk> produkList,
  }) = _Wishlist;

  factory Wishlist.fromJson(Map<String, dynamic> json) => _$WishlistFromJson(json);

  static Customer? _customerFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Customer.fromJson(json);
  }

  static Map<String, dynamic>? _customerToJson(Customer? customer) {
    if (customer == null) return null;

    return customer.toJson();
  }

  static List<Produk> _listProduksFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => Produk.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listProduksToJson(
      List<Produk> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }
}
