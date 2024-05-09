// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'laporanbarangkeluar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LaporanBarangKeluar _$LaporanBarangKeluarFromJson(Map<String, dynamic> json) {
  return _LaporanBarangKeluar.fromJson(json);
}

/// @nodoc
mixin _$LaporanBarangKeluar {
  int? get id => throw _privateConstructorUsedError;
  String? get amount => throw _privateConstructorUsedError;
  int? get orderId => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: LaporanBarangKeluar._orderFromJson,
      toJson: LaporanBarangKeluar._orderToJson)
  Order? get order => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: LaporanBarangKeluar._productFromJson,
      toJson: LaporanBarangKeluar._productToJson)
  List<Produk> get produks => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LaporanBarangKeluarCopyWith<LaporanBarangKeluar> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LaporanBarangKeluarCopyWith<$Res> {
  factory $LaporanBarangKeluarCopyWith(
          LaporanBarangKeluar value, $Res Function(LaporanBarangKeluar) then) =
      _$LaporanBarangKeluarCopyWithImpl<$Res, LaporanBarangKeluar>;
  @useResult
  $Res call(
      {int? id,
      String? amount,
      int? orderId,
      @JsonKey(
          fromJson: LaporanBarangKeluar._orderFromJson,
          toJson: LaporanBarangKeluar._orderToJson)
      Order? order,
      @JsonKey(
          fromJson: LaporanBarangKeluar._productFromJson,
          toJson: LaporanBarangKeluar._productToJson)
      List<Produk> produks,
      DateTime? createdAt,
      DateTime? updatedAt});

  $OrderCopyWith<$Res>? get order;
}

/// @nodoc
class _$LaporanBarangKeluarCopyWithImpl<$Res, $Val extends LaporanBarangKeluar>
    implements $LaporanBarangKeluarCopyWith<$Res> {
  _$LaporanBarangKeluarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? orderId = freezed,
    Object? order = freezed,
    Object? produks = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
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
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order?,
      produks: null == produks
          ? _value.produks
          : produks // ignore: cast_nullable_to_non_nullable
              as List<Produk>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $OrderCopyWith<$Res>? get order {
    if (_value.order == null) {
      return null;
    }

    return $OrderCopyWith<$Res>(_value.order!, (value) {
      return _then(_value.copyWith(order: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$LaporanBarangKeluarImplCopyWith<$Res>
    implements $LaporanBarangKeluarCopyWith<$Res> {
  factory _$$LaporanBarangKeluarImplCopyWith(_$LaporanBarangKeluarImpl value,
          $Res Function(_$LaporanBarangKeluarImpl) then) =
      __$$LaporanBarangKeluarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? amount,
      int? orderId,
      @JsonKey(
          fromJson: LaporanBarangKeluar._orderFromJson,
          toJson: LaporanBarangKeluar._orderToJson)
      Order? order,
      @JsonKey(
          fromJson: LaporanBarangKeluar._productFromJson,
          toJson: LaporanBarangKeluar._productToJson)
      List<Produk> produks,
      DateTime? createdAt,
      DateTime? updatedAt});

  @override
  $OrderCopyWith<$Res>? get order;
}

/// @nodoc
class __$$LaporanBarangKeluarImplCopyWithImpl<$Res>
    extends _$LaporanBarangKeluarCopyWithImpl<$Res, _$LaporanBarangKeluarImpl>
    implements _$$LaporanBarangKeluarImplCopyWith<$Res> {
  __$$LaporanBarangKeluarImplCopyWithImpl(_$LaporanBarangKeluarImpl _value,
      $Res Function(_$LaporanBarangKeluarImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? orderId = freezed,
    Object? order = freezed,
    Object? produks = null,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$LaporanBarangKeluarImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      orderId: freezed == orderId
          ? _value.orderId
          : orderId // ignore: cast_nullable_to_non_nullable
              as int?,
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order?,
      produks: null == produks
          ? _value._produks
          : produks // ignore: cast_nullable_to_non_nullable
              as List<Produk>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$LaporanBarangKeluarImpl implements _LaporanBarangKeluar {
  _$LaporanBarangKeluarImpl(
      {this.id,
      this.amount,
      this.orderId,
      @JsonKey(
          fromJson: LaporanBarangKeluar._orderFromJson,
          toJson: LaporanBarangKeluar._orderToJson)
      this.order,
      @JsonKey(
          fromJson: LaporanBarangKeluar._productFromJson,
          toJson: LaporanBarangKeluar._productToJson)
      final List<Produk> produks = const [],
      this.createdAt,
      this.updatedAt})
      : _produks = produks;

  factory _$LaporanBarangKeluarImpl.fromJson(Map<String, dynamic> json) =>
      _$$LaporanBarangKeluarImplFromJson(json);

  @override
  final int? id;
  @override
  final String? amount;
  @override
  final int? orderId;
  @override
  @JsonKey(
      fromJson: LaporanBarangKeluar._orderFromJson,
      toJson: LaporanBarangKeluar._orderToJson)
  final Order? order;
  final List<Produk> _produks;
  @override
  @JsonKey(
      fromJson: LaporanBarangKeluar._productFromJson,
      toJson: LaporanBarangKeluar._productToJson)
  List<Produk> get produks {
    if (_produks is EqualUnmodifiableListView) return _produks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produks);
  }

  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'LaporanBarangKeluar(id: $id, amount: $amount, orderId: $orderId, order: $order, produks: $produks, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LaporanBarangKeluarImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.orderId, orderId) || other.orderId == orderId) &&
            (identical(other.order, order) || other.order == order) &&
            const DeepCollectionEquality().equals(other._produks, _produks) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, orderId, order,
      const DeepCollectionEquality().hash(_produks), createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LaporanBarangKeluarImplCopyWith<_$LaporanBarangKeluarImpl> get copyWith =>
      __$$LaporanBarangKeluarImplCopyWithImpl<_$LaporanBarangKeluarImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LaporanBarangKeluarImplToJson(
      this,
    );
  }
}

abstract class _LaporanBarangKeluar implements LaporanBarangKeluar {
  factory _LaporanBarangKeluar(
      {final int? id,
      final String? amount,
      final int? orderId,
      @JsonKey(
          fromJson: LaporanBarangKeluar._orderFromJson,
          toJson: LaporanBarangKeluar._orderToJson)
      final Order? order,
      @JsonKey(
          fromJson: LaporanBarangKeluar._productFromJson,
          toJson: LaporanBarangKeluar._productToJson)
      final List<Produk> produks,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$LaporanBarangKeluarImpl;

  factory _LaporanBarangKeluar.fromJson(Map<String, dynamic> json) =
      _$LaporanBarangKeluarImpl.fromJson;

  @override
  int? get id;
  @override
  String? get amount;
  @override
  int? get orderId;
  @override
  @JsonKey(
      fromJson: LaporanBarangKeluar._orderFromJson,
      toJson: LaporanBarangKeluar._orderToJson)
  Order? get order;
  @override
  @JsonKey(
      fromJson: LaporanBarangKeluar._productFromJson,
      toJson: LaporanBarangKeluar._productToJson)
  List<Produk> get produks;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$LaporanBarangKeluarImplCopyWith<_$LaporanBarangKeluarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
