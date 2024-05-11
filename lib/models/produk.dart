import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tugas_akhir_project/models/category.dart';
import 'package:tugas_akhir_project/models/produk_color.dart';
import 'package:tugas_akhir_project/models/produk_combination.dart';
import 'package:tugas_akhir_project/models/produk_image.dart';
import 'package:tugas_akhir_project/models/produk_rating.dart';
import 'package:tugas_akhir_project/models/produk_size.dart';
import 'package:tugas_akhir_project/models/promo.dart';
import 'package:tugas_akhir_project/models/stok.dart';
import 'package:tugas_akhir_project/models/toko.dart';

part 'produk.freezed.dart';
part 'produk.g.dart';

//color
//sizes
//category
@freezed
class Produk with _$Produk {
  @JsonSerializable(explicitToJson: true)
  factory Produk({
    int? id,
    String? name,
    String? code,
    double? averageRating,
    int? totalRating,
    String? description,
    DateTime? createdAt,
    double? price,
    int? tokoId,
    @JsonKey(fromJson: Produk._tokoFromJson, toJson: Produk._tokoToJson)
    Toko? toko,
    @JsonKey(
        fromJson: Produk._stokFromJson,
        toJson: Produk._stokToJson,
        name: "stok")
    Stok? stok,
    // @JsonKey(
    //   fromJson: Produk._ratingFromJson,
    //   toJson: Produk._ratingToJson,
    // )
    // ProdukRating? rating,
    @JsonKey(fromJson: Produk._promoFromJson, toJson: Produk._promoToJson)
    Promo? promo,
    @JsonKey(
        fromJson: Produk._listImagesFromJson,
        toJson: Produk._listImagesToJson,
        name: "image")
    @Default([])
    List<ProdukImage> produkGlobalImages,
    @JsonKey(
        fromJson: Produk._listColorsFromJson,
        toJson: Produk._listColorsToJson,
        name: "color")
    @Default([])
    List<ProdukColor> produkColors,
    @JsonKey(
        fromJson: Produk._listSizesFromJson,
        toJson: Produk._listSizesToJson,
        name: "size")
    @Default([])
    List<ProdukSize> produkSizes,
    @JsonKey(
        fromJson: Produk._listCategoriesFromJson,
        toJson: Produk._listCategoriesToJson,
        name: "categories")
    @Default([])
    List<Category> produkCategories,
    @JsonKey(
        fromJson: Produk._listCombinationsFromJson,
        toJson: Produk._listCombinationsToJson,
        name: "combination")
    @Default([])
    List<ProdukCombination> produkCombination,
  }) = _Produk;

  factory Produk.fromJson(Map<String, dynamic> json) => _$ProdukFromJson(json);

  static Toko? _tokoFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Toko.fromJson(json);
  }

  static Map<String, dynamic>? _tokoToJson(Toko? toko) {
    if (toko == null) return null;

    return toko.toJson();
  }

  static Promo? _promoFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Promo.fromJson(json);
  }

  static Map<String, dynamic>? _promoToJson(Promo? promo) {
    if (promo == null) return null;

    return promo.toJson();
  }

  static Stok? _stokFromJson(Map<String, dynamic>? json) {
    if (json == null) return null;

    return Stok.fromJson(json);
  }

  static Map<String, dynamic>? _stokToJson(Stok? stok) {
    if (stok == null) return null;

    return stok.toJson();
  }

  // static ProdukRating? _ratingFromJson(Map<String, dynamic>? json) {
  //   if (json == null) return null;

  //   return ProdukRating.fromJson(json);
  // }

  // static Map<String, dynamic>? _ratingToJson(ProdukRating? rating) {
  //   if (rating == null) return null;

  //   return rating.toJson();
  // }

  static List<ProdukColor> _listColorsFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => ProdukColor.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listColorsToJson(
      List<ProdukColor> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }

  static List<ProdukSize> _listSizesFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => ProdukSize.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listSizesToJson(
      List<ProdukSize> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }

  static List<ProdukImage> _listImagesFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => ProdukImage.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listImagesToJson(
      List<ProdukImage> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }

  static List<Category> _listCategoriesFromJson(List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => Category.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listCategoriesToJson(
      List<Category> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }

  static List<ProdukCombination> _listCombinationsFromJson(
      List<dynamic>? json) {
    if (json == null || json.isEmpty) return [];

    return json.map((e) => ProdukCombination.fromJson(e)).toList();
  }

  static Map<String, dynamic>? _listCombinationsToJson(
      List<ProdukCombination> berandaProdukList) {
    if (berandaProdukList.isEmpty) return null;

    return {
      for (var i = 0; i < berandaProdukList.length; i++)
        '$i': berandaProdukList[i].toJson(),
    };
  }
}
