// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Produk _$ProdukFromJson(Map<String, dynamic> json) {
  return _Produk.fromJson(json);
}

/// @nodoc
mixin _$Produk {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get code => throw _privateConstructorUsedError;
  double? get averageRating => throw _privateConstructorUsedError;
  int? get totalRating => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  double? get price => throw _privateConstructorUsedError;
  int? get tokoId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Produk._tokoFromJson, toJson: Produk._tokoToJson)
  Toko? get toko => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Produk._stokFromJson, toJson: Produk._stokToJson, name: "stok")
  Stok? get stok => throw _privateConstructorUsedError; // @JsonKey(
//   fromJson: Produk._ratingFromJson,
//   toJson: Produk._ratingToJson,
// )
// ProdukRating? rating,
  @JsonKey(fromJson: Produk._promoFromJson, toJson: Produk._promoToJson)
  Promo? get promo => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Produk._listImagesFromJson,
      toJson: Produk._listImagesToJson,
      name: "image")
  List<ProdukImage> get produkGlobalImages =>
      throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Produk._listColorsFromJson,
      toJson: Produk._listColorsToJson,
      name: "color")
  List<ProdukColor> get produkColors => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Produk._listSizesFromJson,
      toJson: Produk._listSizesToJson,
      name: "size")
  List<ProdukSize> get produkSizes => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Produk._listCategoriesFromJson,
      toJson: Produk._listCategoriesToJson,
      name: "categories")
  List<Category> get produkCategories => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Produk._listCombinationsFromJson,
      toJson: Produk._listCombinationsToJson,
      name: "combination")
  List<ProdukCombination> get produkCombination =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProdukCopyWith<Produk> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProdukCopyWith<$Res> {
  factory $ProdukCopyWith(Produk value, $Res Function(Produk) then) =
      _$ProdukCopyWithImpl<$Res, Produk>;
  @useResult
  $Res call(
      {int? id,
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
      @JsonKey(fromJson: Produk._promoFromJson, toJson: Produk._promoToJson)
      Promo? promo,
      @JsonKey(
          fromJson: Produk._listImagesFromJson,
          toJson: Produk._listImagesToJson,
          name: "image")
      List<ProdukImage> produkGlobalImages,
      @JsonKey(
          fromJson: Produk._listColorsFromJson,
          toJson: Produk._listColorsToJson,
          name: "color")
      List<ProdukColor> produkColors,
      @JsonKey(
          fromJson: Produk._listSizesFromJson,
          toJson: Produk._listSizesToJson,
          name: "size")
      List<ProdukSize> produkSizes,
      @JsonKey(
          fromJson: Produk._listCategoriesFromJson,
          toJson: Produk._listCategoriesToJson,
          name: "categories")
      List<Category> produkCategories,
      @JsonKey(
          fromJson: Produk._listCombinationsFromJson,
          toJson: Produk._listCombinationsToJson,
          name: "combination")
      List<ProdukCombination> produkCombination});

  $TokoCopyWith<$Res>? get toko;
  $StokCopyWith<$Res>? get stok;
  $PromoCopyWith<$Res>? get promo;
}

/// @nodoc
class _$ProdukCopyWithImpl<$Res, $Val extends Produk>
    implements $ProdukCopyWith<$Res> {
  _$ProdukCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? code = freezed,
    Object? averageRating = freezed,
    Object? totalRating = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? price = freezed,
    Object? tokoId = freezed,
    Object? toko = freezed,
    Object? stok = freezed,
    Object? promo = freezed,
    Object? produkGlobalImages = null,
    Object? produkColors = null,
    Object? produkSizes = null,
    Object? produkCategories = null,
    Object? produkCombination = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRating: freezed == totalRating
          ? _value.totalRating
          : totalRating // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      tokoId: freezed == tokoId
          ? _value.tokoId
          : tokoId // ignore: cast_nullable_to_non_nullable
              as int?,
      toko: freezed == toko
          ? _value.toko
          : toko // ignore: cast_nullable_to_non_nullable
              as Toko?,
      stok: freezed == stok
          ? _value.stok
          : stok // ignore: cast_nullable_to_non_nullable
              as Stok?,
      promo: freezed == promo
          ? _value.promo
          : promo // ignore: cast_nullable_to_non_nullable
              as Promo?,
      produkGlobalImages: null == produkGlobalImages
          ? _value.produkGlobalImages
          : produkGlobalImages // ignore: cast_nullable_to_non_nullable
              as List<ProdukImage>,
      produkColors: null == produkColors
          ? _value.produkColors
          : produkColors // ignore: cast_nullable_to_non_nullable
              as List<ProdukColor>,
      produkSizes: null == produkSizes
          ? _value.produkSizes
          : produkSizes // ignore: cast_nullable_to_non_nullable
              as List<ProdukSize>,
      produkCategories: null == produkCategories
          ? _value.produkCategories
          : produkCategories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      produkCombination: null == produkCombination
          ? _value.produkCombination
          : produkCombination // ignore: cast_nullable_to_non_nullable
              as List<ProdukCombination>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokoCopyWith<$Res>? get toko {
    if (_value.toko == null) {
      return null;
    }

    return $TokoCopyWith<$Res>(_value.toko!, (value) {
      return _then(_value.copyWith(toko: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $StokCopyWith<$Res>? get stok {
    if (_value.stok == null) {
      return null;
    }

    return $StokCopyWith<$Res>(_value.stok!, (value) {
      return _then(_value.copyWith(stok: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PromoCopyWith<$Res>? get promo {
    if (_value.promo == null) {
      return null;
    }

    return $PromoCopyWith<$Res>(_value.promo!, (value) {
      return _then(_value.copyWith(promo: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProdukImplCopyWith<$Res> implements $ProdukCopyWith<$Res> {
  factory _$$ProdukImplCopyWith(
          _$ProdukImpl value, $Res Function(_$ProdukImpl) then) =
      __$$ProdukImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
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
      @JsonKey(fromJson: Produk._promoFromJson, toJson: Produk._promoToJson)
      Promo? promo,
      @JsonKey(
          fromJson: Produk._listImagesFromJson,
          toJson: Produk._listImagesToJson,
          name: "image")
      List<ProdukImage> produkGlobalImages,
      @JsonKey(
          fromJson: Produk._listColorsFromJson,
          toJson: Produk._listColorsToJson,
          name: "color")
      List<ProdukColor> produkColors,
      @JsonKey(
          fromJson: Produk._listSizesFromJson,
          toJson: Produk._listSizesToJson,
          name: "size")
      List<ProdukSize> produkSizes,
      @JsonKey(
          fromJson: Produk._listCategoriesFromJson,
          toJson: Produk._listCategoriesToJson,
          name: "categories")
      List<Category> produkCategories,
      @JsonKey(
          fromJson: Produk._listCombinationsFromJson,
          toJson: Produk._listCombinationsToJson,
          name: "combination")
      List<ProdukCombination> produkCombination});

  @override
  $TokoCopyWith<$Res>? get toko;
  @override
  $StokCopyWith<$Res>? get stok;
  @override
  $PromoCopyWith<$Res>? get promo;
}

/// @nodoc
class __$$ProdukImplCopyWithImpl<$Res>
    extends _$ProdukCopyWithImpl<$Res, _$ProdukImpl>
    implements _$$ProdukImplCopyWith<$Res> {
  __$$ProdukImplCopyWithImpl(
      _$ProdukImpl _value, $Res Function(_$ProdukImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? code = freezed,
    Object? averageRating = freezed,
    Object? totalRating = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? price = freezed,
    Object? tokoId = freezed,
    Object? toko = freezed,
    Object? stok = freezed,
    Object? promo = freezed,
    Object? produkGlobalImages = null,
    Object? produkColors = null,
    Object? produkSizes = null,
    Object? produkCategories = null,
    Object? produkCombination = null,
  }) {
    return _then(_$ProdukImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      code: freezed == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String?,
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRating: freezed == totalRating
          ? _value.totalRating
          : totalRating // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double?,
      tokoId: freezed == tokoId
          ? _value.tokoId
          : tokoId // ignore: cast_nullable_to_non_nullable
              as int?,
      toko: freezed == toko
          ? _value.toko
          : toko // ignore: cast_nullable_to_non_nullable
              as Toko?,
      stok: freezed == stok
          ? _value.stok
          : stok // ignore: cast_nullable_to_non_nullable
              as Stok?,
      promo: freezed == promo
          ? _value.promo
          : promo // ignore: cast_nullable_to_non_nullable
              as Promo?,
      produkGlobalImages: null == produkGlobalImages
          ? _value._produkGlobalImages
          : produkGlobalImages // ignore: cast_nullable_to_non_nullable
              as List<ProdukImage>,
      produkColors: null == produkColors
          ? _value._produkColors
          : produkColors // ignore: cast_nullable_to_non_nullable
              as List<ProdukColor>,
      produkSizes: null == produkSizes
          ? _value._produkSizes
          : produkSizes // ignore: cast_nullable_to_non_nullable
              as List<ProdukSize>,
      produkCategories: null == produkCategories
          ? _value._produkCategories
          : produkCategories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
      produkCombination: null == produkCombination
          ? _value._produkCombination
          : produkCombination // ignore: cast_nullable_to_non_nullable
              as List<ProdukCombination>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ProdukImpl implements _Produk {
  _$ProdukImpl(
      {this.id,
      this.name,
      this.code,
      this.averageRating,
      this.totalRating,
      this.description,
      this.createdAt,
      this.price,
      this.tokoId,
      @JsonKey(fromJson: Produk._tokoFromJson, toJson: Produk._tokoToJson)
      this.toko,
      @JsonKey(
          fromJson: Produk._stokFromJson,
          toJson: Produk._stokToJson,
          name: "stok")
      this.stok,
      @JsonKey(fromJson: Produk._promoFromJson, toJson: Produk._promoToJson)
      this.promo,
      @JsonKey(
          fromJson: Produk._listImagesFromJson,
          toJson: Produk._listImagesToJson,
          name: "image")
      final List<ProdukImage> produkGlobalImages = const [],
      @JsonKey(
          fromJson: Produk._listColorsFromJson,
          toJson: Produk._listColorsToJson,
          name: "color")
      final List<ProdukColor> produkColors = const [],
      @JsonKey(
          fromJson: Produk._listSizesFromJson,
          toJson: Produk._listSizesToJson,
          name: "size")
      final List<ProdukSize> produkSizes = const [],
      @JsonKey(
          fromJson: Produk._listCategoriesFromJson,
          toJson: Produk._listCategoriesToJson,
          name: "categories")
      final List<Category> produkCategories = const [],
      @JsonKey(
          fromJson: Produk._listCombinationsFromJson,
          toJson: Produk._listCombinationsToJson,
          name: "combination")
      final List<ProdukCombination> produkCombination = const []})
      : _produkGlobalImages = produkGlobalImages,
        _produkColors = produkColors,
        _produkSizes = produkSizes,
        _produkCategories = produkCategories,
        _produkCombination = produkCombination;

  factory _$ProdukImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProdukImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? code;
  @override
  final double? averageRating;
  @override
  final int? totalRating;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  final double? price;
  @override
  final int? tokoId;
  @override
  @JsonKey(fromJson: Produk._tokoFromJson, toJson: Produk._tokoToJson)
  final Toko? toko;
  @override
  @JsonKey(
      fromJson: Produk._stokFromJson, toJson: Produk._stokToJson, name: "stok")
  final Stok? stok;
// @JsonKey(
//   fromJson: Produk._ratingFromJson,
//   toJson: Produk._ratingToJson,
// )
// ProdukRating? rating,
  @override
  @JsonKey(fromJson: Produk._promoFromJson, toJson: Produk._promoToJson)
  final Promo? promo;
  final List<ProdukImage> _produkGlobalImages;
  @override
  @JsonKey(
      fromJson: Produk._listImagesFromJson,
      toJson: Produk._listImagesToJson,
      name: "image")
  List<ProdukImage> get produkGlobalImages {
    if (_produkGlobalImages is EqualUnmodifiableListView)
      return _produkGlobalImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produkGlobalImages);
  }

  final List<ProdukColor> _produkColors;
  @override
  @JsonKey(
      fromJson: Produk._listColorsFromJson,
      toJson: Produk._listColorsToJson,
      name: "color")
  List<ProdukColor> get produkColors {
    if (_produkColors is EqualUnmodifiableListView) return _produkColors;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produkColors);
  }

  final List<ProdukSize> _produkSizes;
  @override
  @JsonKey(
      fromJson: Produk._listSizesFromJson,
      toJson: Produk._listSizesToJson,
      name: "size")
  List<ProdukSize> get produkSizes {
    if (_produkSizes is EqualUnmodifiableListView) return _produkSizes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produkSizes);
  }

  final List<Category> _produkCategories;
  @override
  @JsonKey(
      fromJson: Produk._listCategoriesFromJson,
      toJson: Produk._listCategoriesToJson,
      name: "categories")
  List<Category> get produkCategories {
    if (_produkCategories is EqualUnmodifiableListView)
      return _produkCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produkCategories);
  }

  final List<ProdukCombination> _produkCombination;
  @override
  @JsonKey(
      fromJson: Produk._listCombinationsFromJson,
      toJson: Produk._listCombinationsToJson,
      name: "combination")
  List<ProdukCombination> get produkCombination {
    if (_produkCombination is EqualUnmodifiableListView)
      return _produkCombination;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produkCombination);
  }

  @override
  String toString() {
    return 'Produk(id: $id, name: $name, code: $code, averageRating: $averageRating, totalRating: $totalRating, description: $description, createdAt: $createdAt, price: $price, tokoId: $tokoId, toko: $toko, stok: $stok, promo: $promo, produkGlobalImages: $produkGlobalImages, produkColors: $produkColors, produkSizes: $produkSizes, produkCategories: $produkCategories, produkCombination: $produkCombination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdukImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalRating, totalRating) ||
                other.totalRating == totalRating) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.tokoId, tokoId) || other.tokoId == tokoId) &&
            (identical(other.toko, toko) || other.toko == toko) &&
            (identical(other.stok, stok) || other.stok == stok) &&
            (identical(other.promo, promo) || other.promo == promo) &&
            const DeepCollectionEquality()
                .equals(other._produkGlobalImages, _produkGlobalImages) &&
            const DeepCollectionEquality()
                .equals(other._produkColors, _produkColors) &&
            const DeepCollectionEquality()
                .equals(other._produkSizes, _produkSizes) &&
            const DeepCollectionEquality()
                .equals(other._produkCategories, _produkCategories) &&
            const DeepCollectionEquality()
                .equals(other._produkCombination, _produkCombination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      code,
      averageRating,
      totalRating,
      description,
      createdAt,
      price,
      tokoId,
      toko,
      stok,
      promo,
      const DeepCollectionEquality().hash(_produkGlobalImages),
      const DeepCollectionEquality().hash(_produkColors),
      const DeepCollectionEquality().hash(_produkSizes),
      const DeepCollectionEquality().hash(_produkCategories),
      const DeepCollectionEquality().hash(_produkCombination));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdukImplCopyWith<_$ProdukImpl> get copyWith =>
      __$$ProdukImplCopyWithImpl<_$ProdukImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProdukImplToJson(
      this,
    );
  }
}

abstract class _Produk implements Produk {
  factory _Produk(
      {final int? id,
      final String? name,
      final String? code,
      final double? averageRating,
      final int? totalRating,
      final String? description,
      final DateTime? createdAt,
      final double? price,
      final int? tokoId,
      @JsonKey(fromJson: Produk._tokoFromJson, toJson: Produk._tokoToJson)
      final Toko? toko,
      @JsonKey(
          fromJson: Produk._stokFromJson,
          toJson: Produk._stokToJson,
          name: "stok")
      final Stok? stok,
      @JsonKey(fromJson: Produk._promoFromJson, toJson: Produk._promoToJson)
      final Promo? promo,
      @JsonKey(
          fromJson: Produk._listImagesFromJson,
          toJson: Produk._listImagesToJson,
          name: "image")
      final List<ProdukImage> produkGlobalImages,
      @JsonKey(
          fromJson: Produk._listColorsFromJson,
          toJson: Produk._listColorsToJson,
          name: "color")
      final List<ProdukColor> produkColors,
      @JsonKey(
          fromJson: Produk._listSizesFromJson,
          toJson: Produk._listSizesToJson,
          name: "size")
      final List<ProdukSize> produkSizes,
      @JsonKey(
          fromJson: Produk._listCategoriesFromJson,
          toJson: Produk._listCategoriesToJson,
          name: "categories")
      final List<Category> produkCategories,
      @JsonKey(
          fromJson: Produk._listCombinationsFromJson,
          toJson: Produk._listCombinationsToJson,
          name: "combination")
      final List<ProdukCombination> produkCombination}) = _$ProdukImpl;

  factory _Produk.fromJson(Map<String, dynamic> json) = _$ProdukImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get code;
  @override
  double? get averageRating;
  @override
  int? get totalRating;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  double? get price;
  @override
  int? get tokoId;
  @override
  @JsonKey(fromJson: Produk._tokoFromJson, toJson: Produk._tokoToJson)
  Toko? get toko;
  @override
  @JsonKey(
      fromJson: Produk._stokFromJson, toJson: Produk._stokToJson, name: "stok")
  Stok? get stok;
  @override // @JsonKey(
//   fromJson: Produk._ratingFromJson,
//   toJson: Produk._ratingToJson,
// )
// ProdukRating? rating,
  @JsonKey(fromJson: Produk._promoFromJson, toJson: Produk._promoToJson)
  Promo? get promo;
  @override
  @JsonKey(
      fromJson: Produk._listImagesFromJson,
      toJson: Produk._listImagesToJson,
      name: "image")
  List<ProdukImage> get produkGlobalImages;
  @override
  @JsonKey(
      fromJson: Produk._listColorsFromJson,
      toJson: Produk._listColorsToJson,
      name: "color")
  List<ProdukColor> get produkColors;
  @override
  @JsonKey(
      fromJson: Produk._listSizesFromJson,
      toJson: Produk._listSizesToJson,
      name: "size")
  List<ProdukSize> get produkSizes;
  @override
  @JsonKey(
      fromJson: Produk._listCategoriesFromJson,
      toJson: Produk._listCategoriesToJson,
      name: "categories")
  List<Category> get produkCategories;
  @override
  @JsonKey(
      fromJson: Produk._listCombinationsFromJson,
      toJson: Produk._listCombinationsToJson,
      name: "combination")
  List<ProdukCombination> get produkCombination;
  @override
  @JsonKey(ignore: true)
  _$$ProdukImplCopyWith<_$ProdukImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
