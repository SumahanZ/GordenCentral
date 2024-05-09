// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cart.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Cart _$CartFromJson(Map<String, dynamic> json) {
  return _Cart.fromJson(json);
}

/// @nodoc
mixin _$Cart {
  int get id => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Cart._customerFromJson, toJson: Cart._customerToJson)
  Customer? get customer => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Cart._listCartItemsFromJson,
      toJson: Cart._listCartItemsToJson,
      name: "items")
  List<CartItem> get cartItemList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CartCopyWith<Cart> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CartCopyWith<$Res> {
  factory $CartCopyWith(Cart value, $Res Function(Cart) then) =
      _$CartCopyWithImpl<$Res, Cart>;
  @useResult
  $Res call(
      {int id,
      int? customerId,
      @JsonKey(fromJson: Cart._customerFromJson, toJson: Cart._customerToJson)
      Customer? customer,
      @JsonKey(
          fromJson: Cart._listCartItemsFromJson,
          toJson: Cart._listCartItemsToJson,
          name: "items")
      List<CartItem> cartItemList});

  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class _$CartCopyWithImpl<$Res, $Val extends Cart>
    implements $CartCopyWith<$Res> {
  _$CartCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = freezed,
    Object? customer = freezed,
    Object? cartItemList = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      cartItemList: null == cartItemList
          ? _value.cartItemList
          : cartItemList // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerCopyWith<$Res>? get customer {
    if (_value.customer == null) {
      return null;
    }

    return $CustomerCopyWith<$Res>(_value.customer!, (value) {
      return _then(_value.copyWith(customer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CartImplCopyWith<$Res> implements $CartCopyWith<$Res> {
  factory _$$CartImplCopyWith(
          _$CartImpl value, $Res Function(_$CartImpl) then) =
      __$$CartImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? customerId,
      @JsonKey(fromJson: Cart._customerFromJson, toJson: Cart._customerToJson)
      Customer? customer,
      @JsonKey(
          fromJson: Cart._listCartItemsFromJson,
          toJson: Cart._listCartItemsToJson,
          name: "items")
      List<CartItem> cartItemList});

  @override
  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$CartImplCopyWithImpl<$Res>
    extends _$CartCopyWithImpl<$Res, _$CartImpl>
    implements _$$CartImplCopyWith<$Res> {
  __$$CartImplCopyWithImpl(_$CartImpl _value, $Res Function(_$CartImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = freezed,
    Object? customer = freezed,
    Object? cartItemList = null,
  }) {
    return _then(_$CartImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      cartItemList: null == cartItemList
          ? _value._cartItemList
          : cartItemList // ignore: cast_nullable_to_non_nullable
              as List<CartItem>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CartImpl implements _Cart {
  _$CartImpl(
      {required this.id,
      this.customerId,
      @JsonKey(fromJson: Cart._customerFromJson, toJson: Cart._customerToJson)
      this.customer,
      @JsonKey(
          fromJson: Cart._listCartItemsFromJson,
          toJson: Cart._listCartItemsToJson,
          name: "items")
      final List<CartItem> cartItemList = const []})
      : _cartItemList = cartItemList;

  factory _$CartImpl.fromJson(Map<String, dynamic> json) =>
      _$$CartImplFromJson(json);

  @override
  final int id;
  @override
  final int? customerId;
  @override
  @JsonKey(fromJson: Cart._customerFromJson, toJson: Cart._customerToJson)
  final Customer? customer;
  final List<CartItem> _cartItemList;
  @override
  @JsonKey(
      fromJson: Cart._listCartItemsFromJson,
      toJson: Cart._listCartItemsToJson,
      name: "items")
  List<CartItem> get cartItemList {
    if (_cartItemList is EqualUnmodifiableListView) return _cartItemList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cartItemList);
  }

  @override
  String toString() {
    return 'Cart(id: $id, customerId: $customerId, customer: $customer, cartItemList: $cartItemList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CartImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality()
                .equals(other._cartItemList, _cartItemList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, customerId, customer,
      const DeepCollectionEquality().hash(_cartItemList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CartImplCopyWith<_$CartImpl> get copyWith =>
      __$$CartImplCopyWithImpl<_$CartImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CartImplToJson(
      this,
    );
  }
}

abstract class _Cart implements Cart {
  factory _Cart(
      {required final int id,
      final int? customerId,
      @JsonKey(fromJson: Cart._customerFromJson, toJson: Cart._customerToJson)
      final Customer? customer,
      @JsonKey(
          fromJson: Cart._listCartItemsFromJson,
          toJson: Cart._listCartItemsToJson,
          name: "items")
      final List<CartItem> cartItemList}) = _$CartImpl;

  factory _Cart.fromJson(Map<String, dynamic> json) = _$CartImpl.fromJson;

  @override
  int get id;
  @override
  int? get customerId;
  @override
  @JsonKey(fromJson: Cart._customerFromJson, toJson: Cart._customerToJson)
  Customer? get customer;
  @override
  @JsonKey(
      fromJson: Cart._listCartItemsFromJson,
      toJson: Cart._listCartItemsToJson,
      name: "items")
  List<CartItem> get cartItemList;
  @override
  @JsonKey(ignore: true)
  _$$CartImplCopyWith<_$CartImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
