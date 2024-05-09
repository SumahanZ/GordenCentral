// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerNotification _$CustomerNotificationFromJson(Map<String, dynamic> json) {
  return _CustomerNotification.fromJson(json);
}

/// @nodoc
mixin _$CustomerNotification {
  int? get id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: CustomerNotification._typeFromJson,
      toJson: CustomerNotification._typeToJson)
  CustomerNotificationType? get customernotificationtype =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerNotificationCopyWith<CustomerNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerNotificationCopyWith<$Res> {
  factory $CustomerNotificationCopyWith(CustomerNotification value,
          $Res Function(CustomerNotification) then) =
      _$CustomerNotificationCopyWithImpl<$Res, CustomerNotification>;
  @useResult
  $Res call(
      {int? id,
      String? description,
      DateTime? createdAt,
      @JsonKey(
          fromJson: CustomerNotification._typeFromJson,
          toJson: CustomerNotification._typeToJson)
      CustomerNotificationType? customernotificationtype});

  $CustomerNotificationTypeCopyWith<$Res>? get customernotificationtype;
}

/// @nodoc
class _$CustomerNotificationCopyWithImpl<$Res,
        $Val extends CustomerNotification>
    implements $CustomerNotificationCopyWith<$Res> {
  _$CustomerNotificationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? customernotificationtype = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customernotificationtype: freezed == customernotificationtype
          ? _value.customernotificationtype
          : customernotificationtype // ignore: cast_nullable_to_non_nullable
              as CustomerNotificationType?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CustomerNotificationTypeCopyWith<$Res>? get customernotificationtype {
    if (_value.customernotificationtype == null) {
      return null;
    }

    return $CustomerNotificationTypeCopyWith<$Res>(
        _value.customernotificationtype!, (value) {
      return _then(_value.copyWith(customernotificationtype: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CustomerNotificationImplCopyWith<$Res>
    implements $CustomerNotificationCopyWith<$Res> {
  factory _$$CustomerNotificationImplCopyWith(_$CustomerNotificationImpl value,
          $Res Function(_$CustomerNotificationImpl) then) =
      __$$CustomerNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? description,
      DateTime? createdAt,
      @JsonKey(
          fromJson: CustomerNotification._typeFromJson,
          toJson: CustomerNotification._typeToJson)
      CustomerNotificationType? customernotificationtype});

  @override
  $CustomerNotificationTypeCopyWith<$Res>? get customernotificationtype;
}

/// @nodoc
class __$$CustomerNotificationImplCopyWithImpl<$Res>
    extends _$CustomerNotificationCopyWithImpl<$Res, _$CustomerNotificationImpl>
    implements _$$CustomerNotificationImplCopyWith<$Res> {
  __$$CustomerNotificationImplCopyWithImpl(_$CustomerNotificationImpl _value,
      $Res Function(_$CustomerNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? customernotificationtype = freezed,
  }) {
    return _then(_$CustomerNotificationImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      customernotificationtype: freezed == customernotificationtype
          ? _value.customernotificationtype
          : customernotificationtype // ignore: cast_nullable_to_non_nullable
              as CustomerNotificationType?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CustomerNotificationImpl implements _CustomerNotification {
  _$CustomerNotificationImpl(
      {this.id,
      this.description,
      this.createdAt,
      @JsonKey(
          fromJson: CustomerNotification._typeFromJson,
          toJson: CustomerNotification._typeToJson)
      this.customernotificationtype});

  factory _$CustomerNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerNotificationImplFromJson(json);

  @override
  final int? id;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  @JsonKey(
      fromJson: CustomerNotification._typeFromJson,
      toJson: CustomerNotification._typeToJson)
  final CustomerNotificationType? customernotificationtype;

  @override
  String toString() {
    return 'CustomerNotification(id: $id, description: $description, createdAt: $createdAt, customernotificationtype: $customernotificationtype)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(
                    other.customernotificationtype, customernotificationtype) ||
                other.customernotificationtype == customernotificationtype));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, description, createdAt, customernotificationtype);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerNotificationImplCopyWith<_$CustomerNotificationImpl>
      get copyWith =>
          __$$CustomerNotificationImplCopyWithImpl<_$CustomerNotificationImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerNotificationImplToJson(
      this,
    );
  }
}

abstract class _CustomerNotification implements CustomerNotification {
  factory _CustomerNotification(
          {final int? id,
          final String? description,
          final DateTime? createdAt,
          @JsonKey(
              fromJson: CustomerNotification._typeFromJson,
              toJson: CustomerNotification._typeToJson)
          final CustomerNotificationType? customernotificationtype}) =
      _$CustomerNotificationImpl;

  factory _CustomerNotification.fromJson(Map<String, dynamic> json) =
      _$CustomerNotificationImpl.fromJson;

  @override
  int? get id;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(
      fromJson: CustomerNotification._typeFromJson,
      toJson: CustomerNotification._typeToJson)
  CustomerNotificationType? get customernotificationtype;
  @override
  @JsonKey(ignore: true)
  _$$CustomerNotificationImplCopyWith<_$CustomerNotificationImpl>
      get copyWith => throw _privateConstructorUsedError;
}
