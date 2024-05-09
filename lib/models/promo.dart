import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/produk.dart';

part 'promo.freezed.dart';
part 'promo.g.dart';

@freezed
class Promo with _$Promo {
  @JsonSerializable(explicitToJson: true)
  factory Promo({
    required int id,
    int? discountPercent,
    DateTime? expiredAt,
    @JsonKey(fromJson: Promo._produkFromJson, toJson: Promo._produkToJson)
    Produk? produk,
  }) = _Promo;

  factory Promo.fromJson(Map<String, dynamic> json) => _$PromoFromJson(json);

  static Produk? _produkFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Produk.fromJson(json);
  }

  static Map<String, dynamic>? _produkToJson(Produk? produk) {
    if (produk == null) return null;

    return produk.toJson();
  }
}
