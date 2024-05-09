import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/models/toko.dart';
part 'katalog_produk.freezed.dart';
part 'katalog_produk.g.dart';

@freezed
class KatalogProduk with _$KatalogProduk {
  @JsonSerializable(explicitToJson: true)
  factory KatalogProduk({
    int? id,
    String? name,
    int? tokoId,
    @JsonKey(
        fromJson: KatalogProduk._tokoFromJson,
        toJson: KatalogProduk._tokoToJson)
    Toko? toko,
    @JsonKey(
        fromJson: KatalogProduk._listProductsFromJson,
        toJson: KatalogProduk._listProductsToJson,
        name: "products")
    @Default([])
    List<Produk> produkList,
  }) = _KatalogProduk;

  factory KatalogProduk.fromJson(Map<String, dynamic> json) =>
      _$KatalogProdukFromJson(json);

  static Toko? _tokoFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Toko.fromJson(json);
  }

  static Map<String, dynamic>? _tokoToJson(Toko? toko) {
    if (toko == null) return null;

    return toko.toJson();
  }

  static List<Produk> _listProductsFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => Produk.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listProductsToJson(
      List<Produk> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }
}
