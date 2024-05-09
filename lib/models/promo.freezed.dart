// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'promo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Promo _$PromoFromJson(Map<String, dynamic> json) {
  return _Promo.fromJson(json);
}

/// @nodoc
mixin _$Promo {
  int get id => throw _privateConstructorUsedError;
  int? get discountPercent => throw _privateConstructorUsedError;
  DateTime? get expiredAt => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Promo._produkFromJson, toJson: Promo._produkToJson)
  Produk? get produk => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PromoCopyWith<Promo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PromoCopyWith<$Res> {
  factory $PromoCopyWith(Promo value, $Res Function(Promo) then) =
      _$PromoCopyWithImpl<$Res, Promo>;
  @useResult
  $Res call(
      {int id,
      int? discountPercent,
      DateTime? expiredAt,
      @JsonKey(fromJson: Promo._produkFromJson, toJson: Promo._produkToJson)
      Produk? produk});

  $ProdukCopyWith<$Res>? get produk;
}

/// @nodoc
class _$PromoCopyWithImpl<$Res, $Val extends Promo>
    implements $PromoCopyWith<$Res> {
  _$PromoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? discountPercent = freezed,
    Object? expiredAt = freezed,
    Object? produk = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      discountPercent: freezed == discountPercent
          ? _value.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int?,
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      produk: freezed == produk
          ? _value.produk
          : produk // ignore: cast_nullable_to_non_nullable
              as Produk?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProdukCopyWith<$Res>? get produk {
    if (_value.produk == null) {
      return null;
    }

    return $ProdukCopyWith<$Res>(_value.produk!, (value) {
      return _then(_value.copyWith(produk: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$PromoImplCopyWith<$Res> implements $PromoCopyWith<$Res> {
  factory _$$PromoImplCopyWith(
          _$PromoImpl value, $Res Function(_$PromoImpl) then) =
      __$$PromoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? discountPercent,
      DateTime? expiredAt,
      @JsonKey(fromJson: Promo._produkFromJson, toJson: Promo._produkToJson)
      Produk? produk});

  @override
  $ProdukCopyWith<$Res>? get produk;
}

/// @nodoc
class __$$PromoImplCopyWithImpl<$Res>
    extends _$PromoCopyWithImpl<$Res, _$PromoImpl>
    implements _$$PromoImplCopyWith<$Res> {
  __$$PromoImplCopyWithImpl(
      _$PromoImpl _value, $Res Function(_$PromoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? discountPercent = freezed,
    Object? expiredAt = freezed,
    Object? produk = freezed,
  }) {
    return _then(_$PromoImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      discountPercent: freezed == discountPercent
          ? _value.discountPercent
          : discountPercent // ignore: cast_nullable_to_non_nullable
              as int?,
      expiredAt: freezed == expiredAt
          ? _value.expiredAt
          : expiredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      produk: freezed == produk
          ? _value.produk
          : produk // ignore: cast_nullable_to_non_nullable
              as Produk?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$PromoImpl implements _Promo {
  _$PromoImpl(
      {required this.id,
      this.discountPercent,
      this.expiredAt,
      @JsonKey(fromJson: Promo._produkFromJson, toJson: Promo._produkToJson)
      this.produk});

  factory _$PromoImpl.fromJson(Map<String, dynamic> json) =>
      _$$PromoImplFromJson(json);

  @override
  final int id;
  @override
  final int? discountPercent;
  @override
  final DateTime? expiredAt;
  @override
  @JsonKey(fromJson: Promo._produkFromJson, toJson: Promo._produkToJson)
  final Produk? produk;

  @override
  String toString() {
    return 'Promo(id: $id, discountPercent: $discountPercent, expiredAt: $expiredAt, produk: $produk)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PromoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.discountPercent, discountPercent) ||
                other.discountPercent == discountPercent) &&
            (identical(other.expiredAt, expiredAt) ||
                other.expiredAt == expiredAt) &&
            (identical(other.produk, produk) || other.produk == produk));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, discountPercent, expiredAt, produk);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PromoImplCopyWith<_$PromoImpl> get copyWith =>
      __$$PromoImplCopyWithImpl<_$PromoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PromoImplToJson(
      this,
    );
  }
}

abstract class _Promo implements Promo {
  factory _Promo(
      {required final int id,
      final int? discountPercent,
      final DateTime? expiredAt,
      @JsonKey(fromJson: Promo._produkFromJson, toJson: Promo._produkToJson)
      final Produk? produk}) = _$PromoImpl;

  factory _Promo.fromJson(Map<String, dynamic> json) = _$PromoImpl.fromJson;

  @override
  int get id;
  @override
  int? get discountPercent;
  @override
  DateTime? get expiredAt;
  @override
  @JsonKey(fromJson: Promo._produkFromJson, toJson: Promo._produkToJson)
  Produk? get produk;
  @override
  @JsonKey(ignore: true)
  _$$PromoImplCopyWith<_$PromoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
