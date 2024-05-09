import 'package:freezed_annotation/freezed_annotation.dart';

part 'produk_size.freezed.dart';
part 'produk_size.g.dart';

@freezed
class ProdukSize with _$ProdukSize {
  @JsonSerializable(explicitToJson: true)
  factory ProdukSize({
    required int id,
    required String name,
  }) = _ProdukSize;

  factory ProdukSize.fromJson(Map<String, dynamic> json) =>
      _$ProdukSizeFromJson(json);
}
