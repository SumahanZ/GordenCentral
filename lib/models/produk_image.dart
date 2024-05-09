import 'package:freezed_annotation/freezed_annotation.dart';

part 'produk_image.freezed.dart';
part 'produk_image.g.dart';

@freezed
class ProdukImage with _$ProdukImage {
  @JsonSerializable(explicitToJson: true)
  factory ProdukImage({
    required int id,
    required String globalImageUrl,
  }) = _ProdukImage;

  factory ProdukImage.fromJson(Map<String, dynamic> json) =>
      _$ProdukImageFromJson(json);
}
