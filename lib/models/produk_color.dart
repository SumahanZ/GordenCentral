import 'package:freezed_annotation/freezed_annotation.dart';

part 'produk_color.freezed.dart';
part 'produk_color.g.dart';

@freezed
class ProdukColor with _$ProdukColor {
  @JsonSerializable(explicitToJson: true)
  factory ProdukColor({
    required int id,
    required String produkColorImageUrl,
    required String name ,
  }) = _ProdukColor;

  factory ProdukColor.fromJson(Map<String, dynamic> json) =>
      _$ProdukColorFromJson(json);
}
