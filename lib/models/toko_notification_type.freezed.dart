// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toko_notification_type.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

TokoNotificationType _$TokoNotificationTypeFromJson(Map<String, dynamic> json) {
  return _TokoNotificationType.fromJson(json);
}

/// @nodoc
mixin _$TokoNotificationType {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokoNotificationTypeCopyWith<TokoNotificationType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokoNotificationTypeCopyWith<$Res> {
  factory $TokoNotificationTypeCopyWith(TokoNotificationType value,
          $Res Function(TokoNotificationType) then) =
      _$TokoNotificationTypeCopyWithImpl<$Res, TokoNotificationType>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$TokoNotificationTypeCopyWithImpl<$Res,
        $Val extends TokoNotificationType>
    implements $TokoNotificationTypeCopyWith<$Res> {
  _$TokoNotificationTypeCopyWithImpl(this._value, this._then);

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
abstract class _$$TokoNotificationTypeImplCopyWith<$Res>
    implements $TokoNotificationTypeCopyWith<$Res> {
  factory _$$TokoNotificationTypeImplCopyWith(_$TokoNotificationTypeImpl value,
          $Res Function(_$TokoNotificationTypeImpl) then) =
      __$$TokoNotificationTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$TokoNotificationTypeImplCopyWithImpl<$Res>
    extends _$TokoNotificationTypeCopyWithImpl<$Res, _$TokoNotificationTypeImpl>
    implements _$$TokoNotificationTypeImplCopyWith<$Res> {
  __$$TokoNotificationTypeImplCopyWithImpl(_$TokoNotificationTypeImpl _value,
      $Res Function(_$TokoNotificationTypeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$TokoNotificationTypeImpl(
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
class _$TokoNotificationTypeImpl implements _TokoNotificationType {
  _$TokoNotificationTypeImpl({required this.id, required this.name});

  factory _$TokoNotificationTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokoNotificationTypeImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'TokoNotificationType(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokoNotificationTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokoNotificationTypeImplCopyWith<_$TokoNotificationTypeImpl>
      get copyWith =>
          __$$TokoNotificationTypeImplCopyWithImpl<_$TokoNotificationTypeImpl>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokoNotificationTypeImplToJson(
      this,
    );
  }
}

abstract class _TokoNotificationType implements TokoNotificationType {
  factory _TokoNotificationType(
      {required final int id,
      required final String name}) = _$TokoNotificationTypeImpl;

  factory _TokoNotificationType.fromJson(Map<String, dynamic> json) =
      _$TokoNotificationTypeImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$TokoNotificationTypeImplCopyWith<_$TokoNotificationTypeImpl>
      get copyWith => throw _privateConstructorUsedError;
}
