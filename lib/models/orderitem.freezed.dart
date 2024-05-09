// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'orderitem.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  int get id => throw _privateConstructorUsedError;
  int? get amount => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: OrderItem._combinationFromJson,
      toJson: OrderItem._combinationToJson,
      name: "combination")
  ProdukCombination? get produkCombination =>
      throw _privateConstructorUsedError;
  @JsonKey(fromJson: OrderItem._orderFromJson, toJson: OrderItem._orderToJson)
  Order? get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call(
      {int id,
      int? amount,
      @JsonKey(
          fromJson: OrderItem._combinationFromJson,
          toJson: OrderItem._combinationToJson,
          name: "combination")
      ProdukCombination? produkCombination,
      @JsonKey(
          fromJson: OrderItem._orderFromJson, toJson: OrderItem._orderToJson)
      Order? order});

  $ProdukCombinationCopyWith<$Res>? get produkCombination;
  $OrderCopyWith<$Res>? get order;
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

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
    Object? order = freezed,
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
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order?,
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
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
          _$OrderItemImpl value, $Res Function(_$OrderItemImpl) then) =
      __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? amount,
      @JsonKey(
          fromJson: OrderItem._combinationFromJson,
          toJson: OrderItem._combinationToJson,
          name: "combination")
      ProdukCombination? produkCombination,
      @JsonKey(
          fromJson: OrderItem._orderFromJson, toJson: OrderItem._orderToJson)
      Order? order});

  @override
  $ProdukCombinationCopyWith<$Res>? get produkCombination;
  @override
  $OrderCopyWith<$Res>? get order;
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
      _$OrderItemImpl _value, $Res Function(_$OrderItemImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? amount = freezed,
    Object? produkCombination = freezed,
    Object? order = freezed,
  }) {
    return _then(_$OrderItemImpl(
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
      order: freezed == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as Order?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$OrderItemImpl implements _OrderItem {
  _$OrderItemImpl(
      {required this.id,
      this.amount,
      @JsonKey(
          fromJson: OrderItem._combinationFromJson,
          toJson: OrderItem._combinationToJson,
          name: "combination")
      this.produkCombination,
      @JsonKey(
          fromJson: OrderItem._orderFromJson, toJson: OrderItem._orderToJson)
      this.order});

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  final int id;
  @override
  final int? amount;
  @override
  @JsonKey(
      fromJson: OrderItem._combinationFromJson,
      toJson: OrderItem._combinationToJson,
      name: "combination")
  final ProdukCombination? produkCombination;
  @override
  @JsonKey(fromJson: OrderItem._orderFromJson, toJson: OrderItem._orderToJson)
  final Order? order;

  @override
  String toString() {
    return 'OrderItem(id: $id, amount: $amount, produkCombination: $produkCombination, order: $order)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.produkCombination, produkCombination) ||
                other.produkCombination == produkCombination) &&
            (identical(other.order, order) || other.order == order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, amount, produkCombination, order);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(
      this,
    );
  }
}

abstract class _OrderItem implements OrderItem {
  factory _OrderItem(
      {required final int id,
      final int? amount,
      @JsonKey(
          fromJson: OrderItem._combinationFromJson,
          toJson: OrderItem._combinationToJson,
          name: "combination")
      final ProdukCombination? produkCombination,
      @JsonKey(
          fromJson: OrderItem._orderFromJson, toJson: OrderItem._orderToJson)
      final Order? order}) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  int get id;
  @override
  int? get amount;
  @override
  @JsonKey(
      fromJson: OrderItem._combinationFromJson,
      toJson: OrderItem._combinationToJson,
      name: "combination")
  ProdukCombination? get produkCombination;
  @override
  @JsonKey(fromJson: OrderItem._orderFromJson, toJson: OrderItem._orderToJson)
  Order? get order;
  @override
  @JsonKey(ignore: true)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
