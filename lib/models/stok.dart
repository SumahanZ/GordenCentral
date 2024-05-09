import 'package:freezed_annotation/freezed_annotation.dart';

part 'stok.freezed.dart';
part 'stok.g.dart';

@freezed
class Stok with _$Stok {
  @JsonSerializable(explicitToJson: true)
  factory Stok({
    required int id,
    int? totalAmount,
    int? safetyStock,
    int? reorderPoint,
    DateTime? createdAt,
    DateTime? updatedAt
  }) = _Stok;

  factory Stok.fromJson(Map<String, dynamic> json) =>
      _$StokFromJson(json);
}
