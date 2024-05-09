// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer_notification_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CustomerNotificationType _$CustomerNotificationTypeFromJson(
    Map<String, dynamic> json) {
  return _CustomerNotificationType.fromJson(json);
}

/// @nodoc
mixin _$CustomerNotificationType {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerNotificationTypeCopyWith<CustomerNotificationType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerNotificationTypeCopyWith<$Res> {
  factory $CustomerNotificationTypeCopyWith(CustomerNotificationType value,
          $Res Function(CustomerNotificationType) then) =
      _$CustomerNotificationTypeCopyWithImpl<$Res, CustomerNotificationType>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$CustomerNotificationTypeCopyWithImpl<$Res,
        $Val extends CustomerNotificationType>
    implements $CustomerNotificationTypeCopyWith<$Res> {
  _$CustomerNotificationTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CustomerNotificationTypeImplCopyWith<$Res>
    implements $CustomerNotificationTypeCopyWith<$Res> {
  factory _$$CustomerNotificationTypeImplCopyWith(
          _$CustomerNotificationTypeImpl value,
          $Res Function(_$CustomerNotificationTypeImpl) then) =
      __$$CustomerNotificationTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$CustomerNotificationTypeImplCopyWithImpl<$Res>
    extends _$CustomerNotificationTypeCopyWithImpl<$Res,
        _$CustomerNotificationTypeImpl>
    implements _$$CustomerNotificationTypeImplCopyWith<$Res> {
  __$$CustomerNotificationTypeImplCopyWithImpl(
      _$CustomerNotificationTypeImpl _value,
      $Res Function(_$CustomerNotificationTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$CustomerNotificationTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$CustomerNotificationTypeImpl implements _CustomerNotificationType {
  _$CustomerNotificationTypeImpl({required this.id, required this.name});

  factory _$CustomerNotificationTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerNotificationTypeImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'CustomerNotificationType(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerNotificationTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerNotificationTypeImplCopyWith<_$CustomerNotificationTypeImpl>
      get copyWith => __$$CustomerNotificationTypeImplCopyWithImpl<
          _$CustomerNotificationTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerNotificationTypeImplToJson(
      this,
    );
  }
}

abstract class _CustomerNotificationType implements CustomerNotificationType {
  factory _CustomerNotificationType(
      {required final int id,
      required final String name}) = _$CustomerNotificationTypeImpl;

  factory _CustomerNotificationType.fromJson(Map<String, dynamic> json) =
      _$CustomerNotificationTypeImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$CustomerNotificationTypeImplCopyWith<_$CustomerNotificationTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}
