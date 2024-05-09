import 'package:freezed_annotation/freezed_annotation.dart';

part 'beranda_toko.freezed.dart';
part 'beranda_toko.g.dart';

@freezed
class BerandaToko with _$BerandaToko {
  @JsonSerializable(explicitToJson: true)
  factory BerandaToko({
    int? id,
    String? berandaImageUrl,
  }) = _BerandaToko;

  factory BerandaToko.fromJson(Map<String, dynamic> json) =>
      _$BerandaTokoFromJson(json);
}