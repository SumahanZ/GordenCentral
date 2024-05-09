// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wishlist.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Wishlist _$WishlistFromJson(Map<String, dynamic> json) {
  return _Wishlist.fromJson(json);
}

/// @nodoc
mixin _$Wishlist {
  int get id => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Wishlist._customerFromJson, toJson: Wishlist._customerToJson)
  Customer? get customer => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Wishlist._listProduksFromJson,
      toJson: Wishlist._listProduksToJson,
      name: "products")
  List<Produk> get produkList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WishlistCopyWith<Wishlist> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WishlistCopyWith<$Res> {
  factory $WishlistCopyWith(Wishlist value, $Res Function(Wishlist) then) =
      _$WishlistCopyWithImpl<$Res, Wishlist>;
  @useResult
  $Res call(
      {int id,
      int? customerId,
      @JsonKey(
          fromJson: Wishlist._customerFromJson,
          toJson: Wishlist._customerToJson)
      Customer? customer,
      @JsonKey(
          fromJson: Wishlist._listProduksFromJson,
          toJson: Wishlist._listProduksToJson,
          name: "products")
      List<Produk> produkList});

  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class _$WishlistCopyWithImpl<$Res, $Val extends Wishlist>
    implements $WishlistCopyWith<$Res> {
  _$WishlistCopyWithImpl(this._value, this._then);

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
    Object? produkList = null,
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
      produkList: null == produkList
          ? _value.produkList
          : produkList // ignore: cast_nullable_to_non_nullable
              as List<Produk>,
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
abstract class _$$WishlistImplCopyWith<$Res>
    implements $WishlistCopyWith<$Res> {
  factory _$$WishlistImplCopyWith(
          _$WishlistImpl value, $Res Function(_$WishlistImpl) then) =
      __$$WishlistImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int? customerId,
      @JsonKey(
          fromJson: Wishlist._customerFromJson,
          toJson: Wishlist._customerToJson)
      Customer? customer,
      @JsonKey(
          fromJson: Wishlist._listProduksFromJson,
          toJson: Wishlist._listProduksToJson,
          name: "products")
      List<Produk> produkList});

  @override
  $CustomerCopyWith<$Res>? get customer;
}

/// @nodoc
class __$$WishlistImplCopyWithImpl<$Res>
    extends _$WishlistCopyWithImpl<$Res, _$WishlistImpl>
    implements _$$WishlistImplCopyWith<$Res> {
  __$$WishlistImplCopyWithImpl(
      _$WishlistImpl _value, $Res Function(_$WishlistImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerId = freezed,
    Object? customer = freezed,
    Object? produkList = null,
  }) {
    return _then(_$WishlistImpl(
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
      produkList: null == produkList
          ? _value._produkList
          : produkList // ignore: cast_nullable_to_non_nullable
              as List<Produk>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$WishlistImpl implements _Wishlist {
  _$WishlistImpl(
      {required this.id,
      this.customerId,
      @JsonKey(
          fromJson: Wishlist._customerFromJson,
          toJson: Wishlist._customerToJson)
      this.customer,
      @JsonKey(
          fromJson: Wishlist._listProduksFromJson,
          toJson: Wishlist._listProduksToJson,
          name: "products")
      final List<Produk> produkList = const []})
      : _produkList = produkList;

  factory _$WishlistImpl.fromJson(Map<String, dynamic> json) =>
      _$$WishlistImplFromJson(json);

  @override
  final int id;
  @override
  final int? customerId;
  @override
  @JsonKey(
      fromJson: Wishlist._customerFromJson, toJson: Wishlist._customerToJson)
  final Customer? customer;
  final List<Produk> _produkList;
  @override
  @JsonKey(
      fromJson: Wishlist._listProduksFromJson,
      toJson: Wishlist._listProduksToJson,
      name: "products")
  List<Produk> get produkList {
    if (_produkList is EqualUnmodifiableListView) return _produkList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_produkList);
  }

  @override
  String toString() {
    return 'Wishlist(id: $id, customerId: $customerId, customer: $customer, produkList: $produkList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WishlistImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            const DeepCollectionEquality()
                .equals(other._produkList, _produkList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, customerId, customer,
      const DeepCollectionEquality().hash(_produkList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WishlistImplCopyWith<_$WishlistImpl> get copyWith =>
      __$$WishlistImplCopyWithImpl<_$WishlistImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WishlistImplToJson(
      this,
    );
  }
}

abstract class _Wishlist implements Wishlist {
  factory _Wishlist(
      {required final int id,
      final int? customerId,
      @JsonKey(
          fromJson: Wishlist._customerFromJson,
          toJson: Wishlist._customerToJson)
      final Customer? customer,
      @JsonKey(
          fromJson: Wishlist._listProduksFromJson,
          toJson: Wishlist._listProduksToJson,
          name: "products")
      final List<Produk> produkList}) = _$WishlistImpl;

  factory _Wishlist.fromJson(Map<String, dynamic> json) =
      _$WishlistImpl.fromJson;

  @override
  int get id;
  @override
  int? get customerId;
  @override
  @JsonKey(
      fromJson: Wishlist._customerFromJson, toJson: Wishlist._customerToJson)
  Customer? get customer;
  @override
  @JsonKey(
      fromJson: Wishlist._listProduksFromJson,
      toJson: Wishlist._listProduksToJson,
      name: "products")
  List<Produk> get produkList;
  @override
  @JsonKey(ignore: true)
  _$$WishlistImplCopyWith<_$WishlistImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
