import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/produk.dart';
part 'laporanbarangmasuk.freezed.dart';
part 'laporanbarangmasuk.g.dart';

@freezed
class LaporanBarangMasuk with _$LaporanBarangMasuk {
  @JsonSerializable(explicitToJson: true)
  factory LaporanBarangMasuk({
    int? id,
    String? amount,
    int? deliveryTime,
    DateTime? issuedFrom,
    DateTime? deliveredAt,
    @JsonKey(
        fromJson: LaporanBarangMasuk._productFromJson,
        toJson: LaporanBarangMasuk._productToJson)
    @Default([])
    List<Produk> produks,
  }) = _LaporanBarangMasuk;

  factory LaporanBarangMasuk.fromJson(Map<String, dynamic> json) =>
      _$LaporanBarangMasukFromJson(json);

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
