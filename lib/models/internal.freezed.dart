// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'internal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Internal _$InternalFromJson(Map<String, dynamic> json) {
  return _Internal.fromJson(json);
}

/// @nodoc
mixin _$Internal {
  int? get id => throw _privateConstructorUsedError;
  String? get userCode => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get profilePhotoURL => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Internal._userFromJson, toJson: Internal._userToJson)
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Internal._tokoFromJson, toJson: Internal._tokoToJson)
  Toko? get toko => throw _privateConstructorUsedError;
  String? get role => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InternalCopyWith<Internal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InternalCopyWith<$Res> {
  factory $InternalCopyWith(Internal value, $Res Function(Internal) then) =
      _$InternalCopyWithImpl<$Res, Internal>;
  @useResult
  $Res call(
      {int? id,
      String? userCode,
      String? status,
      String? profilePhotoURL,
      @JsonKey(fromJson: Internal._userFromJson, toJson: Internal._userToJson)
      User? user,
      @JsonKey(fromJson: Internal._tokoFromJson, toJson: Internal._tokoToJson)
      Toko? toko,
      String? role});

  $UserCopyWith<$Res>? get user;
  $TokoCopyWith<$Res>? get toko;
}

/// @nodoc
class _$InternalCopyWithImpl<$Res, $Val extends Internal>
    implements $InternalCopyWith<$Res> {
  _$InternalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userCode = freezed,
    Object? status = freezed,
    Object? profilePhotoURL = freezed,
    Object? user = freezed,
    Object? toko = freezed,
    Object? role = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userCode: freezed == userCode
          ? _value.userCode
          : userCode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoURL: freezed == profilePhotoURL
          ? _value.profilePhotoURL
          : profilePhotoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      toko: freezed == toko
          ? _value.toko
          : toko // ignore: cast_nullable_to_non_nullable
              as Toko?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
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
abstract class _$$InternalImplCopyWith<$Res>
    implements $InternalCopyWith<$Res> {
  factory _$$InternalImplCopyWith(
          _$InternalImpl value, $Res Function(_$InternalImpl) then) =
      __$$InternalImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? userCode,
      String? status,
      String? profilePhotoURL,
      @JsonKey(fromJson: Internal._userFromJson, toJson: Internal._userToJson)
      User? user,
      @JsonKey(fromJson: Internal._tokoFromJson, toJson: Internal._tokoToJson)
      Toko? toko,
      String? role});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $TokoCopyWith<$Res>? get toko;
}

/// @nodoc
class __$$InternalImplCopyWithImpl<$Res>
    extends _$InternalCopyWithImpl<$Res, _$InternalImpl>
    implements _$$InternalImplCopyWith<$Res> {
  __$$InternalImplCopyWithImpl(
      _$InternalImpl _value, $Res Function(_$InternalImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userCode = freezed,
    Object? status = freezed,
    Object? profilePhotoURL = freezed,
    Object? user = freezed,
    Object? toko = freezed,
    Object? role = freezed,
  }) {
    return _then(_$InternalImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      userCode: freezed == userCode
          ? _value.userCode
          : userCode // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoURL: freezed == profilePhotoURL
          ? _value.profilePhotoURL
          : profilePhotoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      toko: freezed == toko
          ? _value.toko
          : toko // ignore: cast_nullable_to_non_nullable
              as Toko?,
      role: freezed == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$InternalImpl extends _Internal {
  _$InternalImpl(
      {this.id,
      this.userCode,
      this.status,
      this.profilePhotoURL,
      @JsonKey(fromJson: Internal._userFromJson, toJson: Internal._userToJson)
      this.user,
      @JsonKey(fromJson: Internal._tokoFromJson, toJson: Internal._tokoToJson)
      this.toko,
      this.role})
      : super._();

  factory _$InternalImpl.fromJson(Map<String, dynamic> json) =>
      _$$InternalImplFromJson(json);

  @override
  final int? id;
  @override
  final String? userCode;
  @override
  final String? status;
  @override
  final String? profilePhotoURL;
  @override
  @JsonKey(fromJson: Internal._userFromJson, toJson: Internal._userToJson)
  final User? user;
  @override
  @JsonKey(fromJson: Internal._tokoFromJson, toJson: Internal._tokoToJson)
  final Toko? toko;
  @override
  final String? role;

  @override
  String toString() {
    return 'Internal(id: $id, userCode: $userCode, status: $status, profilePhotoURL: $profilePhotoURL, user: $user, toko: $toko, role: $role)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$InternalImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userCode, userCode) ||
                other.userCode == userCode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.profilePhotoURL, profilePhotoURL) ||
                other.profilePhotoURL == profilePhotoURL) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.toko, toko) || other.toko == toko) &&
            (identical(other.role, role) || other.role == role));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userCode, status, profilePhotoURL, user, toko, role);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$InternalImplCopyWith<_$InternalImpl> get copyWith =>
      __$$InternalImplCopyWithImpl<_$InternalImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$InternalImplToJson(
      this,
    );
  }
}

abstract class _Internal extends Internal {
  factory _Internal(
      {final int? id,
      final String? userCode,
      final String? status,
      final String? profilePhotoURL,
      @JsonKey(fromJson: Internal._userFromJson, toJson: Internal._userToJson)
      final User? user,
      @JsonKey(fromJson: Internal._tokoFromJson, toJson: Internal._tokoToJson)
      final Toko? toko,
      final String? role}) = _$InternalImpl;
  _Internal._() : super._();

  factory _Internal.fromJson(Map<String, dynamic> json) =
      _$InternalImpl.fromJson;

  @override
  int? get id;
  @override
  String? get userCode;
  @override
  String? get status;
  @override
  String? get profilePhotoURL;
  @override
  @JsonKey(fromJson: Internal._userFromJson, toJson: Internal._userToJson)
  User? get user;
  @override
  @JsonKey(fromJson: Internal._tokoFromJson, toJson: Internal._tokoToJson)
  Toko? get toko;
  @override
  String? get role;
  @override
  @JsonKey(ignore: true)
  _$$InternalImplCopyWith<_$InternalImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
