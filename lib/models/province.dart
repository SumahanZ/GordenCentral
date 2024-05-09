import 'package:freezed_annotation/freezed_annotation.dart';

part 'province.freezed.dart';
part 'province.g.dart';

@freezed
class Province with _$Province {
  @JsonSerializable(explicitToJson: true)
  factory Province({
    required int id,
    required String name,
  }) = _Province;

  factory Province.fromJson(Map<String, dynamic> json) =>
      _$ProvinceFromJson(json);
}
