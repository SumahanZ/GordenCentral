// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toko_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokoNotification _$TokoNotificationFromJson(Map<String, dynamic> json) {
  return _TokoNotification.fromJson(json);
}

/// @nodoc
mixin _$TokoNotification {
  int? get id => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: TokoNotification._typeFromJson,
      toJson: TokoNotification._typeToJson)
  TokoNotificationType? get tokonotificationtype =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokoNotificationCopyWith<TokoNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokoNotificationCopyWith<$Res> {
  factory $TokoNotificationCopyWith(
          TokoNotification value, $Res Function(TokoNotification) then) =
      _$TokoNotificationCopyWithImpl<$Res, TokoNotification>;
  @useResult
  $Res call(
      {int? id,
      String? description,
      DateTime? createdAt,
      @JsonKey(
          fromJson: TokoNotification._typeFromJson,
          toJson: TokoNotification._typeToJson)
      TokoNotificationType? tokonotificationtype});

  $TokoNotificationTypeCopyWith<$Res>? get tokonotificationtype;
}

/// @nodoc
class _$TokoNotificationCopyWithImpl<$Res, $Val extends TokoNotification>
    implements $TokoNotificationCopyWith<$Res> {
  _$TokoNotificationCopyWithImpl(this._value, this._then);

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
    Object? tokonotificationtype = freezed,
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
      tokonotificationtype: freezed == tokonotificationtype
          ? _value.tokonotificationtype
          : tokonotificationtype // ignore: cast_nullable_to_non_nullable
              as TokoNotificationType?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TokoNotificationTypeCopyWith<$Res>? get tokonotificationtype {
    if (_value.tokonotificationtype == null) {
      return null;
    }

    return $TokoNotificationTypeCopyWith<$Res>(_value.tokonotificationtype!,
        (value) {
      return _then(_value.copyWith(tokonotificationtype: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokoNotificationImplCopyWith<$Res>
    implements $TokoNotificationCopyWith<$Res> {
  factory _$$TokoNotificationImplCopyWith(_$TokoNotificationImpl value,
          $Res Function(_$TokoNotificationImpl) then) =
      __$$TokoNotificationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? description,
      DateTime? createdAt,
      @JsonKey(
          fromJson: TokoNotification._typeFromJson,
          toJson: TokoNotification._typeToJson)
      TokoNotificationType? tokonotificationtype});

  @override
  $TokoNotificationTypeCopyWith<$Res>? get tokonotificationtype;
}

/// @nodoc
class __$$TokoNotificationImplCopyWithImpl<$Res>
    extends _$TokoNotificationCopyWithImpl<$Res, _$TokoNotificationImpl>
    implements _$$TokoNotificationImplCopyWith<$Res> {
  __$$TokoNotificationImplCopyWithImpl(_$TokoNotificationImpl _value,
      $Res Function(_$TokoNotificationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? description = freezed,
    Object? createdAt = freezed,
    Object? tokonotificationtype = freezed,
  }) {
    return _then(_$TokoNotificationImpl(
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
      tokonotificationtype: freezed == tokonotificationtype
          ? _value.tokonotificationtype
          : tokonotificationtype // ignore: cast_nullable_to_non_nullable
              as TokoNotificationType?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TokoNotificationImpl implements _TokoNotification {
  _$TokoNotificationImpl(
      {this.id,
      this.description,
      this.createdAt,
      @JsonKey(
          fromJson: TokoNotification._typeFromJson,
          toJson: TokoNotification._typeToJson)
      this.tokonotificationtype});

  factory _$TokoNotificationImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokoNotificationImplFromJson(json);

  @override
  final int? id;
  @override
  final String? description;
  @override
  final DateTime? createdAt;
  @override
  @JsonKey(
      fromJson: TokoNotification._typeFromJson,
      toJson: TokoNotification._typeToJson)
  final TokoNotificationType? tokonotificationtype;

  @override
  String toString() {
    return 'TokoNotification(id: $id, description: $description, createdAt: $createdAt, tokonotificationtype: $tokonotificationtype)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokoNotificationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.tokonotificationtype, tokonotificationtype) ||
                other.tokonotificationtype == tokonotificationtype));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, description, createdAt, tokonotificationtype);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokoNotificationImplCopyWith<_$TokoNotificationImpl> get copyWith =>
      __$$TokoNotificationImplCopyWithImpl<_$TokoNotificationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokoNotificationImplToJson(
      this,
    );
  }
}

abstract class _TokoNotification implements TokoNotification {
  factory _TokoNotification(
          {final int? id,
          final String? description,
          final DateTime? createdAt,
          @JsonKey(
              fromJson: TokoNotification._typeFromJson,
              toJson: TokoNotification._typeToJson)
          final TokoNotificationType? tokonotificationtype}) =
      _$TokoNotificationImpl;

  factory _TokoNotification.fromJson(Map<String, dynamic> json) =
      _$TokoNotificationImpl.fromJson;

  @override
  int? get id;
  @override
  String? get description;
  @override
  DateTime? get createdAt;
  @override
  @JsonKey(
      fromJson: TokoNotification._typeFromJson,
      toJson: TokoNotification._typeToJson)
  TokoNotificationType? get tokonotificationtype;
  @override
  @JsonKey(ignore: true)
  _$$TokoNotificationImplCopyWith<_$TokoNotificationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
