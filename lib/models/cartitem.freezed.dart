// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cartitem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CartItem _$CartItemFromJson(Map<String, dynamic> json) {
  return _CartItem.fromJson(json);
}

/// @nodoc
mixin _$CartItem {
  int get id => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: CartItem._combinationFromJson,
      toJson: CartItem._combinationToJson,
      name: "combination")
  ProdukCombination? get produkCombination =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartItemCopyWith<CartItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartItemCopyWith<$Res> {
  factory $CartItemCopyWith(CartItem value, $Res Function(CartItem) then) =
      _$CartItemCopyWithImpl<$Res, CartItem>;
  @useResult
  $Res call(
      {int id,
      int? amount,
      @JsonKey(
          fromJson: CartItem._combinationFromJson,
          toJson: CartItem._combinationToJson,
          name: "combination")
      ProdukCombination? produkCombination});

  $ProdukCombinationCopyWith<$Res>? get produkCombination;
}

/// @nodoc
class _$CartItemCopyWithImpl<$Res, $Val extends CartItem>
    implements $CartItemCopyWith<$Res> {
  _$CartItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = freezed,
    Object? produkCombination = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      produkCombination: freezed == produkCombination
          ? _value.produkCombination
          : produkCombination // ignore: cast_nullable_to_non_nullable
              as ProdukCombination?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProdukCombinationCopyWith<$Res>? get produkCombination {
    if (_value.produkCombination == null) {
      return null;
    }

    return $ProdukCombinationCopyWith<$Res>(_value.produkCombination!, (value) {
      return _then(_value.copyWith(produkCombination: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartItemImplCopyWith<$Res>
    implements $CartItemCopyWith<$Res> {
  factory _$$CartItemImplCopyWith(
          _$CartItemImpl value, $Res Function(_$CartItemImpl) then) =
      __$$CartItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? amount,
      @JsonKey(
          fromJson: CartItem._combinationFromJson,
          toJson: CartItem._combinationToJson,
          name: "combination")
      ProdukCombination? produkCombination});

  @override
  $ProdukCombinationCopyWith<$Res>? get produkCombination;
}

/// @nodoc
class __$$CartItemImplCopyWithImpl<$Res>
    extends _$CartItemCopyWithImpl<$Res, _$CartItemImpl>
    implements _$$CartItemImplCopyWith<$Res> {
  __$$CartItemImplCopyWithImpl(
      _$CartItemImpl _value, $Res Function(_$CartItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = freezed,
    Object? produkCombination = freezed,
  }) {
    return _then(_$CartItemImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int?,
      produkCombination: freezed == produkCombination
          ? _value.produkCombination
          : produkCombination // ignore: cast_nullable_to_non_nullable
              as ProdukCombination?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CartItemImpl implements _CartItem {
  _$CartItemImpl(
      {required this.id,
      this.amount,
      @JsonKey(
          fromJson: CartItem._combinationFromJson,
          toJson: CartItem._combinationToJson,
          name: "combination")
      this.produkCombination});

  factory _$CartItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartItemImplFromJson(json);

  @override
  final int id;
  @override
  final int? amount;
  @override
  @JsonKey(
      fromJson: CartItem._combinationFromJson,
      toJson: CartItem._combinationToJson,
      name: "combination")
  final ProdukCombination? produkCombination;

  @override
  String toString() {
    return 'CartItem(id: $id, amount: $amount, produkCombination: $produkCombination)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.produkCombination, produkCombination) ||
                other.produkCombination == produkCombination));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, produkCombination);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      __$$CartItemImplCopyWithImpl<_$CartItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartItemImplToJson(
      this,
    );
  }
}

abstract class _CartItem implements CartItem {
  factory _CartItem(
      {required final int id,
      final int? amount,
      @JsonKey(
          fromJson: CartItem._combinationFromJson,
          toJson: CartItem._combinationToJson,
          name: "combination")
      final ProdukCombination? produkCombination}) = _$CartItemImpl;

  factory _CartItem.fromJson(Map<String, dynamic> json) =
      _$CartItemImpl.fromJson;

  @override
  int get id;
  @override
  int? get amount;
  @override
  @JsonKey(
      fromJson: CartItem._combinationFromJson,
      toJson: CartItem._combinationToJson,
      name: "combination")
  ProdukCombination? get produkCombination;
  @override
  @JsonKey(ignore: true)
  _$$CartItemImplCopyWith<_$CartItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
