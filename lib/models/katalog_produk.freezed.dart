// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'katalog_produk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

KatalogProduk _$KatalogProdukFromJson(Map<String, dynamic> json) {
  return _KatalogProduk.fromJson(json);
}

/// @nodoc
mixin _$KatalogProduk {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  int? get tokoId => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: KatalogProduk._tokoFromJson, toJson: KatalogProduk._tokoToJson)
  Toko? get toko => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: KatalogProduk._listProductsFromJson,
      toJson: KatalogProduk._listProductsToJson,
      name: "products")
  List<Produk> get produkList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $KatalogProdukCopyWith<KatalogProduk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $KatalogProdukCopyWith<$Res> {
  factory $KatalogProdukCopyWith(
          KatalogProduk value, $Res Function(KatalogProduk) then) =
      _$KatalogProdukCopyWithImpl<$Res, KatalogProduk>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      int? tokoId,
      @JsonKey(
          fromJson: KatalogProduk._tokoFromJson,
          toJson: KatalogProduk._tokoToJson)
      Toko? toko,
      @JsonKey(
          fromJson: KatalogProduk._listProductsFromJson,
          toJson: KatalogProduk._listProductsToJson,
          name: "products")
      List<Produk> produkList});

  $TokoCopyWith<$Res>? get toko;
}

/// @nodoc
class _$KatalogProdukCopyWithImpl<$Res, $Val extends KatalogProduk>
    implements $KatalogProdukCopyWith<$Res> {
  _$KatalogProdukCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? tokoId = freezed,
    Object? toko = freezed,
    Object? produkList = null,
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
      tokoId: freezed == tokoId
          ? _value.tokoId
          : tokoId // ignore: cast_nullable_to_non_nullable
              as int?,
      toko: freezed == toko
          ? _value.toko
          : toko // ignore: cast_nullable_to_non_nullable
              as Toko?,
      produkList: null == produkList
          ? _value.produkList
          : produkList // ignore: cast_nullable_to_non_nullable
              as List<Produk>,
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
}

/// @nodoc
abstract class _$$KatalogProdukImplCopyWith<$Res>
    implements $KatalogProdukCopyWith<$Res> {
  factory _$$KatalogProdukImplCopyWith(
          _$KatalogProdukImpl value, $Res Function(_$KatalogProdukImpl) then) =
      __$$KatalogProdukImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      int? tokoId,
      @JsonKey(
          fromJson: KatalogProduk._tokoFromJson,
          toJson: KatalogProduk._tokoToJson)
      Toko? toko,
      @JsonKey(
          fromJson: KatalogProduk._listProductsFromJson,
          toJson: KatalogProduk._listProductsToJson,
          name: "products")
      List<Produk> produkList});

  @override
  $TokoCopyWith<$Res>? get toko;
}

/// @nodoc
class __$$KatalogProdukImplCopyWithImpl<$Res>
    extends _$KatalogProdukCopyWithImpl<$Res, _$KatalogProdukImpl>
    implements _$$KatalogProdukImplCopyWith<$Res> {
  __$$KatalogProdukImplCopyWithImpl(
      _$KatalogProdukImpl _value, $Res Function(_$KatalogProdukImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? tokoId = freezed,
    Object? toko = freezed,
    Object? produkList = null,
  }) {
    return _then(_$KatalogProdukImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      tokoId: freezed == tokoId
          ? _value.tokoId
          : tokoId // ignore: cast_nullable_to_non_nullable
              as int?,
      toko: freezed == toko
          ? _value.toko
          : toko // ignore: cast_nullable_to_non_nullable
              as Toko?,
      produkList: null == produkList
          ? _value._produkList
          : produkList // ignore: cast_nullable_to_non_nullable
              as List<Produk>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$KatalogProdukImpl implements _KatalogProduk {
  _$KatalogProdukImpl(
      {this.id,
      this.name,
      this.tokoId,
      @JsonKey(
          fromJson: KatalogProduk._tokoFromJson,
          toJson: KatalogProduk._tokoToJson)
      this.toko,
      @JsonKey(
          fromJson: KatalogProduk._listProductsFromJson,
          toJson: KatalogProduk._listProductsToJson,
          name: "products")
      final List<Produk> produkList = const []})
      : _produkList = produkList;

  factory _$KatalogProdukImpl.fromJson(Map<String, dynamic> json) =>
      _$$KatalogProdukImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final int? tokoId;
  @override
  @JsonKey(
      fromJson: KatalogProduk._tokoFromJson, toJson: KatalogProduk._tokoToJson)
  final Toko? toko;
  final List<Produk> _produkList;
  @override
  @JsonKey(
      fromJson: KatalogProduk._listProductsFromJson,
      toJson: KatalogProduk._listProductsToJson,
      name: "products")
  List<Produk> get produkList {
    if (_produkList is EqualUnmodifiableListView) return _produkList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produkList);
  }

  @override
  String toString() {
    return 'KatalogProduk(id: $id, name: $name, tokoId: $tokoId, toko: $toko, produkList: $produkList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$KatalogProdukImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.tokoId, tokoId) || other.tokoId == tokoId) &&
            (identical(other.toko, toko) || other.toko == toko) &&
            const DeepCollectionEquality()
                .equals(other._produkList, _produkList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, tokoId, toko,
      const DeepCollectionEquality().hash(_produkList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$KatalogProdukImplCopyWith<_$KatalogProdukImpl> get copyWith =>
      __$$KatalogProdukImplCopyWithImpl<_$KatalogProdukImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$KatalogProdukImplToJson(
      this,
    );
  }
}

abstract class _KatalogProduk implements KatalogProduk {
  factory _KatalogProduk(
      {final int? id,
      final String? name,
      final int? tokoId,
      @JsonKey(
          fromJson: KatalogProduk._tokoFromJson,
          toJson: KatalogProduk._tokoToJson)
      final Toko? toko,
      @JsonKey(
          fromJson: KatalogProduk._listProductsFromJson,
          toJson: KatalogProduk._listProductsToJson,
          name: "products")
      final List<Produk> produkList}) = _$KatalogProdukImpl;

  factory _KatalogProduk.fromJson(Map<String, dynamic> json) =
      _$KatalogProdukImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  int? get tokoId;
  @override
  @JsonKey(
      fromJson: KatalogProduk._tokoFromJson, toJson: KatalogProduk._tokoToJson)
  Toko? get toko;
  @override
  @JsonKey(
      fromJson: KatalogProduk._listProductsFromJson,
      toJson: KatalogProduk._listProductsToJson,
      name: "products")
  List<Produk> get produkList;
  @override
  @JsonKey(ignore: true)
  _$$KatalogProdukImplCopyWith<_$KatalogProdukImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
