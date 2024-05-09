// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toko.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Toko _$TokoFromJson(Map<String, dynamic> json) {
  return _Toko.fromJson(json);
}

/// @nodoc
mixin _$Toko {
  int? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get phoneNumber => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get whatsAppURL => throw _privateConstructorUsedError;
  String? get profilePhotoURL => throw _privateConstructorUsedError;
  String? get inviteCode => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Toko._addressFromJson, toJson: Toko._addressToJson)
  Address? get address => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: Toko._listBerandaFromJson,
      toJson: Toko._listBerandaToJson,
      name: "promotionals")
  List<BerandaToko> get berandaToko => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TokoCopyWith<Toko> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TokoCopyWith<$Res> {
  factory $TokoCopyWith(Toko value, $Res Function(Toko) then) =
      _$TokoCopyWithImpl<$Res, Toko>;
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phoneNumber,
      String? bio,
      String? whatsAppURL,
      String? profilePhotoURL,
      String? inviteCode,
      @JsonKey(fromJson: Toko._addressFromJson, toJson: Toko._addressToJson)
      Address? address,
      @JsonKey(
          fromJson: Toko._listBerandaFromJson,
          toJson: Toko._listBerandaToJson,
          name: "promotionals")
      List<BerandaToko> berandaToko});

  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$TokoCopyWithImpl<$Res, $Val extends Toko>
    implements $TokoCopyWith<$Res> {
  _$TokoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
    Object? bio = freezed,
    Object? whatsAppURL = freezed,
    Object? profilePhotoURL = freezed,
    Object? inviteCode = freezed,
    Object? address = freezed,
    Object? berandaToko = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      whatsAppURL: freezed == whatsAppURL
          ? _value.whatsAppURL
          : whatsAppURL // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoURL: freezed == profilePhotoURL
          ? _value.profilePhotoURL
          : profilePhotoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteCode: freezed == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      berandaToko: null == berandaToko
          ? _value.berandaToko
          : berandaToko // ignore: cast_nullable_to_non_nullable
              as List<BerandaToko>,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AddressCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $AddressCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$TokoImplCopyWith<$Res> implements $TokoCopyWith<$Res> {
  factory _$$TokoImplCopyWith(
          _$TokoImpl value, $Res Function(_$TokoImpl) then) =
      __$$TokoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      String? name,
      String? phoneNumber,
      String? bio,
      String? whatsAppURL,
      String? profilePhotoURL,
      String? inviteCode,
      @JsonKey(fromJson: Toko._addressFromJson, toJson: Toko._addressToJson)
      Address? address,
      @JsonKey(
          fromJson: Toko._listBerandaFromJson,
          toJson: Toko._listBerandaToJson,
          name: "promotionals")
      List<BerandaToko> berandaToko});

  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$TokoImplCopyWithImpl<$Res>
    extends _$TokoCopyWithImpl<$Res, _$TokoImpl>
    implements _$$TokoImplCopyWith<$Res> {
  __$$TokoImplCopyWithImpl(_$TokoImpl _value, $Res Function(_$TokoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? phoneNumber = freezed,
    Object? bio = freezed,
    Object? whatsAppURL = freezed,
    Object? profilePhotoURL = freezed,
    Object? inviteCode = freezed,
    Object? address = freezed,
    Object? berandaToko = null,
  }) {
    return _then(_$TokoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      phoneNumber: freezed == phoneNumber
          ? _value.phoneNumber
          : phoneNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      whatsAppURL: freezed == whatsAppURL
          ? _value.whatsAppURL
          : whatsAppURL // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoURL: freezed == profilePhotoURL
          ? _value.profilePhotoURL
          : profilePhotoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      inviteCode: freezed == inviteCode
          ? _value.inviteCode
          : inviteCode // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
      berandaToko: null == berandaToko
          ? _value._berandaToko
          : berandaToko // ignore: cast_nullable_to_non_nullable
              as List<BerandaToko>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$TokoImpl implements _Toko {
  _$TokoImpl(
      {this.id,
      this.name,
      this.phoneNumber,
      this.bio,
      this.whatsAppURL,
      this.profilePhotoURL,
      this.inviteCode,
      @JsonKey(fromJson: Toko._addressFromJson, toJson: Toko._addressToJson)
      this.address,
      @JsonKey(
          fromJson: Toko._listBerandaFromJson,
          toJson: Toko._listBerandaToJson,
          name: "promotionals")
      final List<BerandaToko> berandaToko = const []})
      : _berandaToko = berandaToko;

  factory _$TokoImpl.fromJson(Map<String, dynamic> json) =>
      _$$TokoImplFromJson(json);

  @override
  final int? id;
  @override
  final String? name;
  @override
  final String? phoneNumber;
  @override
  final String? bio;
  @override
  final String? whatsAppURL;
  @override
  final String? profilePhotoURL;
  @override
  final String? inviteCode;
  @override
  @JsonKey(fromJson: Toko._addressFromJson, toJson: Toko._addressToJson)
  final Address? address;
  final List<BerandaToko> _berandaToko;
  @override
  @JsonKey(
      fromJson: Toko._listBerandaFromJson,
      toJson: Toko._listBerandaToJson,
      name: "promotionals")
  List<BerandaToko> get berandaToko {
    if (_berandaToko is EqualUnmodifiableListView) return _berandaToko;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_berandaToko);
  }

  @override
  String toString() {
    return 'Toko(id: $id, name: $name, phoneNumber: $phoneNumber, bio: $bio, whatsAppURL: $whatsAppURL, profilePhotoURL: $profilePhotoURL, inviteCode: $inviteCode, address: $address, berandaToko: $berandaToko)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TokoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.phoneNumber, phoneNumber) ||
                other.phoneNumber == phoneNumber) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.whatsAppURL, whatsAppURL) ||
                other.whatsAppURL == whatsAppURL) &&
            (identical(other.profilePhotoURL, profilePhotoURL) ||
                other.profilePhotoURL == profilePhotoURL) &&
            (identical(other.inviteCode, inviteCode) ||
                other.inviteCode == inviteCode) &&
            (identical(other.address, address) || other.address == address) &&
            const DeepCollectionEquality()
                .equals(other._berandaToko, _berandaToko));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      phoneNumber,
      bio,
      whatsAppURL,
      profilePhotoURL,
      inviteCode,
      address,
      const DeepCollectionEquality().hash(_berandaToko));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TokoImplCopyWith<_$TokoImpl> get copyWith =>
      __$$TokoImplCopyWithImpl<_$TokoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TokoImplToJson(
      this,
    );
  }
}

abstract class _Toko implements Toko {
  factory _Toko(
      {final int? id,
      final String? name,
      final String? phoneNumber,
      final String? bio,
      final String? whatsAppURL,
      final String? profilePhotoURL,
      final String? inviteCode,
      @JsonKey(fromJson: Toko._addressFromJson, toJson: Toko._addressToJson)
      final Address? address,
      @JsonKey(
          fromJson: Toko._listBerandaFromJson,
          toJson: Toko._listBerandaToJson,
          name: "promotionals")
      final List<BerandaToko> berandaToko}) = _$TokoImpl;

  factory _Toko.fromJson(Map<String, dynamic> json) = _$TokoImpl.fromJson;

  @override
  int? get id;
  @override
  String? get name;
  @override
  String? get phoneNumber;
  @override
  String? get bio;
  @override
  String? get whatsAppURL;
  @override
  String? get profilePhotoURL;
  @override
  String? get inviteCode;
  @override
  @JsonKey(fromJson: Toko._addressFromJson, toJson: Toko._addressToJson)
  Address? get address;
  @override
  @JsonKey(
      fromJson: Toko._listBerandaFromJson,
      toJson: Toko._listBerandaToJson,
      name: "promotionals")
  List<BerandaToko> get berandaToko;
  @override
  @JsonKey(ignore: true)
  _$$TokoImplCopyWith<_$TokoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
