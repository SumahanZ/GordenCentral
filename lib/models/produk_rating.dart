import 'package:freezed_annotation/freezed_annotation.dart';

part 'produk_rating.freezed.dart';
part 'produk_rating.g.dart';

@freezed
class ProdukRating with _$ProdukRating {
  @JsonSerializable(explicitToJson: true)
  factory ProdukRating({
    double? averageRating,
    int? totalRating,
  }) = _ProdukRating;

  factory ProdukRating.fromJson(Map<String, dynamic> json) =>
      _$ProdukRatingFromJson(json);
}
