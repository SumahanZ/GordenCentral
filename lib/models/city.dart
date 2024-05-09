import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/province.dart';

part 'city.freezed.dart';
part 'city.g.dart';

@freezed
class City with _$City {
  @JsonSerializable(explicitToJson: true)
  factory City({
    required int id,
    required String name,
    int? provinceId,
    @JsonKey(
        fromJson: City._provinceFromJson,
        toJson: City._provinceToJson,
        name: "province")
    Province? province,
  }) = _City;

  factory City.fromJson(Map<String, dynamic> json) => _$CityFromJson(json);

  static Province? _provinceFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Province.fromJson(json);
  }

  static Map<String, dynamic>? _provinceToJson(Province? province) {
    if (province == null) return null;

    return province.toJson();
  }
}
