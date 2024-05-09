import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/order.dart';
import 'package:tugas_akhir_project/models/produk.dart';
part 'laporanbarangkeluar.freezed.dart';
part 'laporanbarangkeluar.g.dart';

@freezed
class LaporanBarangKeluar with _$LaporanBarangKeluar {
  @JsonSerializable(explicitToJson: true)
  factory LaporanBarangKeluar({
    int? id,
    String? amount,
    int? orderId,
    @JsonKey(
        fromJson: LaporanBarangKeluar._orderFromJson,
        toJson: LaporanBarangKeluar._orderToJson)
    Order? order,
    @JsonKey(
        fromJson: LaporanBarangKeluar._productFromJson,
        toJson: LaporanBarangKeluar._productToJson)
    @Default([])
    List<Produk> produks,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) = _LaporanBarangKeluar;

  factory LaporanBarangKeluar.fromJson(Map<String, dynamic> json) =>
      _$LaporanBarangKeluarFromJson(json);

  static Order? _orderFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Order.fromJson(json);
  }

  static Map<String, dynamic>? _orderToJson(Order? order) {
    if (order == null) return null;

    return order.toJson();
  }

  static List<Produk> _productFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => Produk.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _productToJson(List<Produk> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }
}
