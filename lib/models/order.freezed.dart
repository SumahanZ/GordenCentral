// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Order _$OrderFromJson(Map<String, dynamic> json) {
  return _Order.fromJson(json);
}

/// @nodoc
mixin _$Order {
  int get id => throw _privateConstructorUsedError;
  String get code => throw _privateConstructorUsedError;
  double get finalPriceTotal => throw _privateConstructorUsedError;
  double get discountAmountTotal => throw _privateConstructorUsedError;
  double get originalPriceTotal => throw _privateConstructorUsedError;
  String? get note => throw _privateConstructorUsedError;
  int? get customerId => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Order._customerFromJson, toJson: Order._customerToJson)
  Customer? get customer => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Order._statusFromJson, toJson: Order._statusToJson)
  OrderStatus? get status => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Order._tokoFromJson, toJson: Order._tokoToJson)
  Toko? get toko => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  DateTime? get updatedAt => throw _privateConstructorUsedError;
  DateTime? get completedAt => throw _privateConstructorUsedError;
  DateTime? get cancelledAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Order._listOrderItemsFromJson,
      toJson: Order._listOrderItemsToJson,
      name: "items")
  List<OrderItem> get orderItemList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderCopyWith<Order> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderCopyWith<$Res> {
  factory $OrderCopyWith(Order value, $Res Function(Order) then) =
      _$OrderCopyWithImpl<$Res, Order>;
  @useResult
  $Res call(
      {int id,
      String code,
      double finalPriceTotal,
      double discountAmountTotal,
      double originalPriceTotal,
      String? note,
      int? customerId,
      @JsonKey(fromJson: Order._customerFromJson, toJson: Order._customerToJson)
      Customer? customer,
      @JsonKey(fromJson: Order._statusFromJson, toJson: Order._statusToJson)
      OrderStatus? status,
      @JsonKey(fromJson: Order._tokoFromJson, toJson: Order._tokoToJson)
      Toko? toko,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? completedAt,
      DateTime? cancelledAt,
      @JsonKey(
          fromJson: Order._listOrderItemsFromJson,
          toJson: Order._listOrderItemsToJson,
          name: "items")
      List<OrderItem> orderItemList});

  $CustomerCopyWith<$Res>? get customer;
  $OrderStatusCopyWith<$Res>? get status;
  $TokoCopyWith<$Res>? get toko;
}

/// @nodoc
class _$OrderCopyWithImpl<$Res, $Val extends Order>
    implements $OrderCopyWith<$Res> {
  _$OrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? finalPriceTotal = null,
    Object? discountAmountTotal = null,
    Object? originalPriceTotal = null,
    Object? note = freezed,
    Object? customerId = freezed,
    Object? customer = freezed,
    Object? status = freezed,
    Object? toko = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? orderItemList = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      finalPriceTotal: null == finalPriceTotal
          ? _value.finalPriceTotal
          : finalPriceTotal // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmountTotal: null == discountAmountTotal
          ? _value.discountAmountTotal
          : discountAmountTotal // ignore: cast_nullable_to_non_nullable
              as double,
      originalPriceTotal: null == originalPriceTotal
          ? _value.originalPriceTotal
          : originalPriceTotal // ignore: cast_nullable_to_non_nullable
              as double,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus?,
      toko: freezed == toko
          ? _value.toko
          : toko // ignore: cast_nullable_to_non_nullable
              as Toko?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderItemList: null == orderItemList
          ? _value.orderItemList
          : orderItemList // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
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

  @override
  @pragma('vm:prefer-inline')
  $OrderStatusCopyWith<$Res>? get status {
    if (_value.status == null) {
      return null;
    }

    return $OrderStatusCopyWith<$Res>(_value.status!, (value) {
      return _then(_value.copyWith(status: value) as $Val);
    });
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
abstract class _$$OrderImplCopyWith<$Res> implements $OrderCopyWith<$Res> {
  factory _$$OrderImplCopyWith(
          _$OrderImpl value, $Res Function(_$OrderImpl) then) =
      __$$OrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String code,
      double finalPriceTotal,
      double discountAmountTotal,
      double originalPriceTotal,
      String? note,
      int? customerId,
      @JsonKey(fromJson: Order._customerFromJson, toJson: Order._customerToJson)
      Customer? customer,
      @JsonKey(fromJson: Order._statusFromJson, toJson: Order._statusToJson)
      OrderStatus? status,
      @JsonKey(fromJson: Order._tokoFromJson, toJson: Order._tokoToJson)
      Toko? toko,
      DateTime? createdAt,
      DateTime? updatedAt,
      DateTime? completedAt,
      DateTime? cancelledAt,
      @JsonKey(
          fromJson: Order._listOrderItemsFromJson,
          toJson: Order._listOrderItemsToJson,
          name: "items")
      List<OrderItem> orderItemList});

  @override
  $CustomerCopyWith<$Res>? get customer;
  @override
  $OrderStatusCopyWith<$Res>? get status;
  @override
  $TokoCopyWith<$Res>? get toko;
}

/// @nodoc
class __$$OrderImplCopyWithImpl<$Res>
    extends _$OrderCopyWithImpl<$Res, _$OrderImpl>
    implements _$$OrderImplCopyWith<$Res> {
  __$$OrderImplCopyWithImpl(
      _$OrderImpl _value, $Res Function(_$OrderImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? code = null,
    Object? finalPriceTotal = null,
    Object? discountAmountTotal = null,
    Object? originalPriceTotal = null,
    Object? note = freezed,
    Object? customerId = freezed,
    Object? customer = freezed,
    Object? status = freezed,
    Object? toko = freezed,
    Object? createdAt = freezed,
    Object? updatedAt = freezed,
    Object? completedAt = freezed,
    Object? cancelledAt = freezed,
    Object? orderItemList = null,
  }) {
    return _then(_$OrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      finalPriceTotal: null == finalPriceTotal
          ? _value.finalPriceTotal
          : finalPriceTotal // ignore: cast_nullable_to_non_nullable
              as double,
      discountAmountTotal: null == discountAmountTotal
          ? _value.discountAmountTotal
          : discountAmountTotal // ignore: cast_nullable_to_non_nullable
              as double,
      originalPriceTotal: null == originalPriceTotal
          ? _value.originalPriceTotal
          : originalPriceTotal // ignore: cast_nullable_to_non_nullable
              as double,
      note: freezed == note
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String?,
      customerId: freezed == customerId
          ? _value.customerId
          : customerId // ignore: cast_nullable_to_non_nullable
              as int?,
      customer: freezed == customer
          ? _value.customer
          : customer // ignore: cast_nullable_to_non_nullable
              as Customer?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus?,
      toko: freezed == toko
          ? _value.toko
          : toko // ignore: cast_nullable_to_non_nullable
              as Toko?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      updatedAt: freezed == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      completedAt: freezed == completedAt
          ? _value.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      cancelledAt: freezed == cancelledAt
          ? _value.cancelledAt
          : cancelledAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      orderItemList: null == orderItemList
          ? _value._orderItemList
          : orderItemList // ignore: cast_nullable_to_non_nullable
              as List<OrderItem>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$OrderImpl implements _Order {
  _$OrderImpl(
      {required this.id,
      required this.code,
      required this.finalPriceTotal,
      required this.discountAmountTotal,
      required this.originalPriceTotal,
      this.note,
      this.customerId,
      @JsonKey(fromJson: Order._customerFromJson, toJson: Order._customerToJson)
      this.customer,
      @JsonKey(fromJson: Order._statusFromJson, toJson: Order._statusToJson)
      this.status,
      @JsonKey(fromJson: Order._tokoFromJson, toJson: Order._tokoToJson)
      this.toko,
      this.createdAt,
      this.updatedAt,
      this.completedAt,
      this.cancelledAt,
      @JsonKey(
          fromJson: Order._listOrderItemsFromJson,
          toJson: Order._listOrderItemsToJson,
          name: "items")
      final List<OrderItem> orderItemList = const []})
      : _orderItemList = orderItemList;

  factory _$OrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderImplFromJson(json);

  @override
  final int id;
  @override
  final String code;
  @override
  final double finalPriceTotal;
  @override
  final double discountAmountTotal;
  @override
  final double originalPriceTotal;
  @override
  final String? note;
  @override
  final int? customerId;
  @override
  @JsonKey(fromJson: Order._customerFromJson, toJson: Order._customerToJson)
  final Customer? customer;
  @override
  @JsonKey(fromJson: Order._statusFromJson, toJson: Order._statusToJson)
  final OrderStatus? status;
  @override
  @JsonKey(fromJson: Order._tokoFromJson, toJson: Order._tokoToJson)
  final Toko? toko;
  @override
  final DateTime? createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? completedAt;
  @override
  final DateTime? cancelledAt;
  final List<OrderItem> _orderItemList;
  @override
  @JsonKey(
      fromJson: Order._listOrderItemsFromJson,
      toJson: Order._listOrderItemsToJson,
      name: "items")
  List<OrderItem> get orderItemList {
    if (_orderItemList is EqualUnmodifiableListView) return _orderItemList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderItemList);
  }

  @override
  String toString() {
    return 'Order(id: $id, code: $code, finalPriceTotal: $finalPriceTotal, discountAmountTotal: $discountAmountTotal, originalPriceTotal: $originalPriceTotal, note: $note, customerId: $customerId, customer: $customer, status: $status, toko: $toko, createdAt: $createdAt, updatedAt: $updatedAt, completedAt: $completedAt, cancelledAt: $cancelledAt, orderItemList: $orderItemList)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.finalPriceTotal, finalPriceTotal) ||
                other.finalPriceTotal == finalPriceTotal) &&
            (identical(other.discountAmountTotal, discountAmountTotal) ||
                other.discountAmountTotal == discountAmountTotal) &&
            (identical(other.originalPriceTotal, originalPriceTotal) ||
                other.originalPriceTotal == originalPriceTotal) &&
            (identical(other.note, note) || other.note == note) &&
            (identical(other.customerId, customerId) ||
                other.customerId == customerId) &&
            (identical(other.customer, customer) ||
                other.customer == customer) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.toko, toko) || other.toko == toko) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt) &&
            (identical(other.cancelledAt, cancelledAt) ||
                other.cancelledAt == cancelledAt) &&
            const DeepCollectionEquality()
                .equals(other._orderItemList, _orderItemList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      code,
      finalPriceTotal,
      discountAmountTotal,
      originalPriceTotal,
      note,
      customerId,
      customer,
      status,
      toko,
      createdAt,
      updatedAt,
      completedAt,
      cancelledAt,
      const DeepCollectionEquality().hash(_orderItemList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      __$$OrderImplCopyWithImpl<_$OrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderImplToJson(
      this,
    );
  }
}

abstract class _Order implements Order {
  factory _Order(
      {required final int id,
      required final String code,
      required final double finalPriceTotal,
      required final double discountAmountTotal,
      required final double originalPriceTotal,
      final String? note,
      final int? customerId,
      @JsonKey(fromJson: Order._customerFromJson, toJson: Order._customerToJson)
      final Customer? customer,
      @JsonKey(fromJson: Order._statusFromJson, toJson: Order._statusToJson)
      final OrderStatus? status,
      @JsonKey(fromJson: Order._tokoFromJson, toJson: Order._tokoToJson)
      final Toko? toko,
      final DateTime? createdAt,
      final DateTime? updatedAt,
      final DateTime? completedAt,
      final DateTime? cancelledAt,
      @JsonKey(
          fromJson: Order._listOrderItemsFromJson,
          toJson: Order._listOrderItemsToJson,
          name: "items")
      final List<OrderItem> orderItemList}) = _$OrderImpl;

  factory _Order.fromJson(Map<String, dynamic> json) = _$OrderImpl.fromJson;

  @override
  int get id;
  @override
  String get code;
  @override
  double get finalPriceTotal;
  @override
  double get discountAmountTotal;
  @override
  double get originalPriceTotal;
  @override
  String? get note;
  @override
  int? get customerId;
  @override
  @JsonKey(fromJson: Order._customerFromJson, toJson: Order._customerToJson)
  Customer? get customer;
  @override
  @JsonKey(fromJson: Order._statusFromJson, toJson: Order._statusToJson)
  OrderStatus? get status;
  @override
  @JsonKey(fromJson: Order._tokoFromJson, toJson: Order._tokoToJson)
  Toko? get toko;
  @override
  DateTime? get createdAt;
  @override
  DateTime? get updatedAt;
  @override
  DateTime? get completedAt;
  @override
  DateTime? get cancelledAt;
  @override
  @JsonKey(
      fromJson: Order._listOrderItemsFromJson,
      toJson: Order._listOrderItemsToJson,
      name: "items")
  List<OrderItem> get orderItemList;
  @override
  @JsonKey(ignore: true)
  _$$OrderImplCopyWith<_$OrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
