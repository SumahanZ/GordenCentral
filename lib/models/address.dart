import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/city.dart';

part 'address.freezed.dart';
part 'address.g.dart';

@freezed
class Address with _$Address {
  @JsonSerializable(explicitToJson: true)
  factory Address({
    required int id,
    required String streetAddress,
    @JsonKey(fromJson: Address._cityFromJson, toJson: Address._cityToJson)
    City? city,
    String? country,
    String? postalCode,
  }) = _Address;

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);

  static City? _cityFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return City.fromJson(json);
  }

  static Map<String, dynamic>? _cityToJson(City? city) {
    if (city == null) return null;

    return city.toJson();
  }
}
