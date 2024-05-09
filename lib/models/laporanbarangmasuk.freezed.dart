// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laporanbarangmasuk.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LaporanBarangMasuk _$LaporanBarangMasukFromJson(Map<String, dynamic> json) {
  return _LaporanBarangMasuk.fromJson(json);
}

/// @nodoc
mixin _$LaporanBarangMasuk {
  int? get id => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  int? get deliveryTime => throw _privateConstructorUsedError;
  DateTime? get issuedFrom => throw _privateConstructorUsedError;
  DateTime? get deliveredAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: LaporanBarangMasuk._productFromJson,
      toJson: LaporanBarangMasuk._productToJson)
  List<Produk> get produks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LaporanBarangMasukCopyWith<LaporanBarangMasuk> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaporanBarangMasukCopyWith<$Res> {
  factory $LaporanBarangMasukCopyWith(
          LaporanBarangMasuk value, $Res Function(LaporanBarangMasuk) then) =
      _$LaporanBarangMasukCopyWithImpl<$Res, LaporanBarangMasuk>;
  @useResult
  $Res call(
      {int? id,
      String? amount,
      int? deliveryTime,
      DateTime? issuedFrom,
      DateTime? deliveredAt,
      @JsonKey(
          fromJson: LaporanBarangMasuk._productFromJson,
          toJson: LaporanBarangMasuk._productToJson)
      List<Produk> produks});
}

/// @nodoc
class _$LaporanBarangMasukCopyWithImpl<$Res, $Val extends LaporanBarangMasuk>
    implements $LaporanBarangMasukCopyWith<$Res> {
  _$LaporanBarangMasukCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? deliveryTime = freezed,
    Object? issuedFrom = freezed,
    Object? deliveredAt = freezed,
    Object? produks = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryTime: freezed == deliveryTime
          ? _value.deliveryTime
          : deliveryTime // ignore: cast_nullable_to_non_nullable
              as int?,
      issuedFrom: freezed == issuedFrom
          ? _value.issuedFrom
          : issuedFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      produks: null == produks
          ? _value.produks
          : produks // ignore: cast_nullable_to_non_nullable
              as List<Produk>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LaporanBarangMasukImplCopyWith<$Res>
    implements $LaporanBarangMasukCopyWith<$Res> {
  factory _$$LaporanBarangMasukImplCopyWith(_$LaporanBarangMasukImpl value,
          $Res Function(_$LaporanBarangMasukImpl) then) =
      __$$LaporanBarangMasukImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? amount,
      int? deliveryTime,
      DateTime? issuedFrom,
      DateTime? deliveredAt,
      @JsonKey(
          fromJson: LaporanBarangMasuk._productFromJson,
          toJson: LaporanBarangMasuk._productToJson)
      List<Produk> produks});
}

/// @nodoc
class __$$LaporanBarangMasukImplCopyWithImpl<$Res>
    extends _$LaporanBarangMasukCopyWithImpl<$Res, _$LaporanBarangMasukImpl>
    implements _$$LaporanBarangMasukImplCopyWith<$Res> {
  __$$LaporanBarangMasukImplCopyWithImpl(_$LaporanBarangMasukImpl _value,
      $Res Function(_$LaporanBarangMasukImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? deliveryTime = freezed,
    Object? issuedFrom = freezed,
    Object? deliveredAt = freezed,
    Object? produks = null,
  }) {
    return _then(_$LaporanBarangMasukImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      deliveryTime: freezed == deliveryTime
          ? _value.deliveryTime
          : deliveryTime // ignore: cast_nullable_to_non_nullable
              as int?,
      issuedFrom: freezed == issuedFrom
          ? _value.issuedFrom
          : issuedFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deliveredAt: freezed == deliveredAt
          ? _value.deliveredAt
          : deliveredAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      produks: null == produks
          ? _value._produks
          : produks // ignore: cast_nullable_to_non_nullable
              as List<Produk>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LaporanBarangMasukImpl implements _LaporanBarangMasuk {
  _$LaporanBarangMasukImpl(
      {this.id,
      this.amount,
      this.deliveryTime,
      this.issuedFrom,
      this.deliveredAt,
      @JsonKey(
          fromJson: LaporanBarangMasuk._productFromJson,
          toJson: LaporanBarangMasuk._productToJson)
      final List<Produk> produks = const []})
      : _produks = produks;

  factory _$LaporanBarangMasukImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaporanBarangMasukImplFromJson(json);

  @override
  final int? id;
  @override
  final String? amount;
  @override
  final int? deliveryTime;
  @override
  final DateTime? issuedFrom;
  @override
  final DateTime? deliveredAt;
  final List<Produk> _produks;
  @override
  @JsonKey(
      fromJson: LaporanBarangMasuk._productFromJson,
      toJson: LaporanBarangMasuk._productToJson)
  List<Produk> get produks {
    if (_produks is EqualUnmodifiableListView) return _produks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produks);
  }

  @override
  String toString() {
    return 'LaporanBarangMasuk(id: $id, amount: $amount, deliveryTime: $deliveryTime, issuedFrom: $issuedFrom, deliveredAt: $deliveredAt, produks: $produks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaporanBarangMasukImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.deliveryTime, deliveryTime) ||
                other.deliveryTime == deliveryTime) &&
            (identical(other.issuedFrom, issuedFrom) ||
                other.issuedFrom == issuedFrom) &&
            (identical(other.deliveredAt, deliveredAt) ||
                other.deliveredAt == deliveredAt) &&
            const DeepCollectionEquality().equals(other._produks, _produks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, deliveryTime,
      issuedFrom, deliveredAt, const DeepCollectionEquality().hash(_produks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LaporanBarangMasukImplCopyWith<_$LaporanBarangMasukImpl> get copyWith =>
      __$$LaporanBarangMasukImplCopyWithImpl<_$LaporanBarangMasukImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaporanBarangMasukImplToJson(
      this,
    );
  }
}

abstract class _LaporanBarangMasuk implements LaporanBarangMasuk {
  factory _LaporanBarangMasuk(
      {final int? id,
      final String? amount,
      final int? deliveryTime,
      final DateTime? issuedFrom,
      final DateTime? deliveredAt,
      @JsonKey(
          fromJson: LaporanBarangMasuk._productFromJson,
          toJson: LaporanBarangMasuk._productToJson)
      final List<Produk> produks}) = _$LaporanBarangMasukImpl;

  factory _LaporanBarangMasuk.fromJson(Map<String, dynamic> json) =
      _$LaporanBarangMasukImpl.fromJson;

  @override
  int? get id;
  @override
  String? get amount;
  @override
  int? get deliveryTime;
  @override
  DateTime? get issuedFrom;
  @override
  DateTime? get deliveredAt;
  @override
  @JsonKey(
      fromJson: LaporanBarangMasuk._productFromJson,
      toJson: LaporanBarangMasuk._productToJson)
  List<Produk> get produks;
  @override
  @JsonKey(ignore: true)
  _$$LaporanBarangMasukImplCopyWith<_$LaporanBarangMasukImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
