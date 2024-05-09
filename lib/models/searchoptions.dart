import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/category.dart';
import 'package:tugas_akhir_project/models/city.dart';
import 'package:tugas_akhir_project/models/toko.dart';

part 'searchoptions.freezed.dart';
part 'searchoptions.g.dart';

//color
//sizes
//category
@freezed
class SearchOption with _$SearchOption {
  @JsonSerializable(explicitToJson: true)
  factory SearchOption({
    double? maxProdukPriceAmount,
    @JsonKey(
      fromJson: SearchOption._locationsFromJson,
      toJson: SearchOption._locationToJson,
    )
    @Default([])
    List<City> availableLocations,
    @JsonKey(
      fromJson: SearchOption._tokosFromJson,
      toJson: SearchOption._tokosToJson,
    )
    @Default([])
    List<Toko> tokoList,
    @JsonKey(
      fromJson: SearchOption._categoriesFromJson,
      toJson: SearchOption._categoriesToJson,
    )
    @Default([])
    List<Category> categories,
  }) = _SearchOption;

  factory SearchOption.fromJson(Map<String, dynamic> json) =>
      _$SearchOptionFromJson(json);

  static List<City> _locationsFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => City.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _locationToJson(List<City> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }

  static List<Toko> _tokosFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => Toko.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _tokosToJson(List<Toko> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }

  static List<Category> _categoriesFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => Category.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _categoriesToJson(
      List<Category> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }
}
