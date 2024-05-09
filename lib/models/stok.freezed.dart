// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'stok.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Stok _$StokFromJson(Map<String, dynamic> json) {
  return _Stok.fromJson(json);
}

/// @nodoc
mixin _$Stok {
  int get id => throw _privateConstructorUsedError;
  int? get totalAmount => throw _privateConstructorUsedError;
  int? get safetyStock => throw _privateConstructorUsedError;
  int? get reorderPoint => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StokCopyWith<Stok> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StokCopyWith<$Res> {
  factory $StokCopyWith(Stok value, $Res Function(Stok) then) =
      _$StokCopyWithImpl<$Res, Stok>;
  @useResult
  $Res call(
      {int id,
      int? totalAmount,
      int? safetyStock,
      int? reorderPoint,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class _$StokCopyWithImpl<$Res, $Val extends Stok>
    implements $StokCopyWith<$Res> {
  _$StokCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? totalAmount = freezed,
    Object? safetyStock = freezed,
    Object? reorderPoint = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: freezed == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      safetyStock: freezed == safetyStock
          ? _value.safetyStock
          : safetyStock // ignore: cast_nullable_to_non_nullable
              as int?,
      reorderPoint: freezed == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as int?,
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
}

/// @nodoc
abstract class _$$StokImplCopyWith<$Res> implements $StokCopyWith<$Res> {
  factory _$$StokImplCopyWith(
          _$StokImpl value, $Res Function(_$StokImpl) then) =
      __$$StokImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? totalAmount,
      int? safetyStock,
      int? reorderPoint,
      DateTime? createdAt,
      DateTime? updatedAt});
}

/// @nodoc
class __$$StokImplCopyWithImpl<$Res>
    extends _$StokCopyWithImpl<$Res, _$StokImpl>
    implements _$$StokImplCopyWith<$Res> {
  __$$StokImplCopyWithImpl(_$StokImpl _value, $Res Function(_$StokImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? totalAmount = freezed,
    Object? safetyStock = freezed,
    Object? reorderPoint = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
  }) {
    return _then(_$StokImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      totalAmount: freezed == totalAmount
          ? _value.totalAmount
          : totalAmount // ignore: cast_nullable_to_non_nullable
              as int?,
      safetyStock: freezed == safetyStock
          ? _value.safetyStock
          : safetyStock // ignore: cast_nullable_to_non_nullable
              as int?,
      reorderPoint: freezed == reorderPoint
          ? _value.reorderPoint
          : reorderPoint // ignore: cast_nullable_to_non_nullable
              as int?,
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
class _$StokImpl implements _Stok {
  _$StokImpl(
      {required this.id,
      this.totalAmount,
      this.safetyStock,
      this.reorderPoint,
      this.createdAt,
      this.updatedAt});

  factory _$StokImpl.fromJson(Map<String, dynamic> json) =>
      _$$StokImplFromJson(json);

  @override
  final int id;
  @override
  final int? totalAmount;
  @override
  final int? safetyStock;
  @override
  final int? reorderPoint;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;

  @override
  String toString() {
    return 'Stok(id: $id, totalAmount: $totalAmount, safetyStock: $safetyStock, reorderPoint: $reorderPoint, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StokImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.safetyStock, safetyStock) ||
                other.safetyStock == safetyStock) &&
            (identical(other.reorderPoint, reorderPoint) ||
                other.reorderPoint == reorderPoint) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, totalAmount, safetyStock,
      reorderPoint, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StokImplCopyWith<_$StokImpl> get copyWith =>
      __$$StokImplCopyWithImpl<_$StokImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StokImplToJson(
      this,
    );
  }
}

abstract class _Stok implements Stok {
  factory _Stok(
      {required final int id,
      final int? totalAmount,
      final int? safetyStock,
      final int? reorderPoint,
      final DateTime? createdAt,
      final DateTime? updatedAt}) = _$StokImpl;

  factory _Stok.fromJson(Map<String, dynamic> json) = _$StokImpl.fromJson;

  @override
  int get id;
  @override
  int? get totalAmount;
  @override
  int? get safetyStock;
  @override
  int? get reorderPoint;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$StokImplCopyWith<_$StokImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
