import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/models/produk_color.dart';
import 'package:tugas_akhir_project/models/produk_size.dart';

part 'produk_combination.freezed.dart';
part 'produk_combination.g.dart';

@freezed
class ProdukCombination with _$ProdukCombination {
  @JsonSerializable(explicitToJson: true)
  factory ProdukCombination({
    required int id,
    required int variantAmount,
    @JsonKey(
        fromJson: ProdukCombination._productFromJson,
        toJson: ProdukCombination._productToJson)
    Produk? product,
    @JsonKey(
        fromJson: ProdukCombination._colorFromJson,
        toJson: ProdukCombination._colorToJson)
    ProdukColor? color,
    @JsonKey(
        fromJson: ProdukCombination._sizeFromJson,
        toJson: ProdukCombination._sizeToJson)
    ProdukSize? size,
  }) = _ProdukCombination;

  factory ProdukCombination.fromJson(Map<String, dynamic> json) =>
      _$ProdukCombinationFromJson(json);

  static Produk? _productFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Produk.fromJson(json);
  }

  static Map<String, dynamic>? _productToJson(Produk? produk) {
    if (produk == null) return null;

    return produk.toJson();
  }

  static ProdukColor? _colorFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return ProdukColor.fromJson(json);
  }

  static Map<String, dynamic>? _colorToJson(ProdukColor? color) {
    if (color == null) return null;

    return color.toJson();
  }

  static ProdukSize? _sizeFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return ProdukSize.fromJson(json);
  }

  static Map<String, dynamic>? _sizeToJson(ProdukSize? size) {
    if (size == null) return null;

    return size.toJson();
  }
}
