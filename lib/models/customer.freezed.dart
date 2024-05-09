// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'customer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Customer _$CustomerFromJson(Map<String, dynamic> json) {
  return _Customer.fromJson(json);
}

/// @nodoc
mixin _$Customer {
  int get id => throw _privateConstructorUsedError;
  String? get customerCode => throw _privateConstructorUsedError;
  String? get profilePhotoURL => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Customer._userFromJson, toJson: Customer._userToJson)
  User? get user => throw _privateConstructorUsedError;
  @JsonKey(fromJson: Customer._addressFromJson, toJson: Customer._addressToJson)
  Address? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CustomerCopyWith<Customer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CustomerCopyWith<$Res> {
  factory $CustomerCopyWith(Customer value, $Res Function(Customer) then) =
      _$CustomerCopyWithImpl<$Res, Customer>;
  @useResult
  $Res call(
      {int id,
      String? customerCode,
      String? profilePhotoURL,
      @JsonKey(fromJson: Customer._userFromJson, toJson: Customer._userToJson)
      User? user,
      @JsonKey(
          fromJson: Customer._addressFromJson, toJson: Customer._addressToJson)
      Address? address});

  $UserCopyWith<$Res>? get user;
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class _$CustomerCopyWithImpl<$Res, $Val extends Customer>
    implements $CustomerCopyWith<$Res> {
  _$CustomerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerCode = freezed,
    Object? profilePhotoURL = freezed,
    Object? user = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      customerCode: freezed == customerCode
          ? _value.customerCode
          : customerCode // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoURL: freezed == profilePhotoURL
          ? _value.profilePhotoURL
          : profilePhotoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
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
abstract class _$$CustomerImplCopyWith<$Res>
    implements $CustomerCopyWith<$Res> {
  factory _$$CustomerImplCopyWith(
          _$CustomerImpl value, $Res Function(_$CustomerImpl) then) =
      __$$CustomerImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String? customerCode,
      String? profilePhotoURL,
      @JsonKey(fromJson: Customer._userFromJson, toJson: Customer._userToJson)
      User? user,
      @JsonKey(
          fromJson: Customer._addressFromJson, toJson: Customer._addressToJson)
      Address? address});

  @override
  $UserCopyWith<$Res>? get user;
  @override
  $AddressCopyWith<$Res>? get address;
}

/// @nodoc
class __$$CustomerImplCopyWithImpl<$Res>
    extends _$CustomerCopyWithImpl<$Res, _$CustomerImpl>
    implements _$$CustomerImplCopyWith<$Res> {
  __$$CustomerImplCopyWithImpl(
      _$CustomerImpl _value, $Res Function(_$CustomerImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? customerCode = freezed,
    Object? profilePhotoURL = freezed,
    Object? user = freezed,
    Object? address = freezed,
  }) {
    return _then(_$CustomerImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      customerCode: freezed == customerCode
          ? _value.customerCode
          : customerCode // ignore: cast_nullable_to_non_nullable
              as String?,
      profilePhotoURL: freezed == profilePhotoURL
          ? _value.profilePhotoURL
          : profilePhotoURL // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as User?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as Address?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CustomerImpl extends _Customer {
  _$CustomerImpl(
      {required this.id,
      this.customerCode,
      this.profilePhotoURL,
      @JsonKey(fromJson: Customer._userFromJson, toJson: Customer._userToJson)
      this.user,
      @JsonKey(
          fromJson: Customer._addressFromJson, toJson: Customer._addressToJson)
      this.address})
      : super._();

  factory _$CustomerImpl.fromJson(Map<String, dynamic> json) =>
      _$$CustomerImplFromJson(json);

  @override
  final int id;
  @override
  final String? customerCode;
  @override
  final String? profilePhotoURL;
  @override
  @JsonKey(fromJson: Customer._userFromJson, toJson: Customer._userToJson)
  final User? user;
  @override
  @JsonKey(fromJson: Customer._addressFromJson, toJson: Customer._addressToJson)
  final Address? address;

  @override
  String toString() {
    return 'Customer(id: $id, customerCode: $customerCode, profilePhotoURL: $profilePhotoURL, user: $user, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CustomerImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.customerCode, customerCode) ||
                other.customerCode == customerCode) &&
            (identical(other.profilePhotoURL, profilePhotoURL) ||
                other.profilePhotoURL == profilePhotoURL) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, customerCode, profilePhotoURL, user, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      __$$CustomerImplCopyWithImpl<_$CustomerImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CustomerImplToJson(
      this,
    );
  }
}

abstract class _Customer extends Customer {
  factory _Customer(
      {required final int id,
      final String? customerCode,
      final String? profilePhotoURL,
      @JsonKey(fromJson: Customer._userFromJson, toJson: Customer._userToJson)
      final User? user,
      @JsonKey(
          fromJson: Customer._addressFromJson, toJson: Customer._addressToJson)
      final Address? address}) = _$CustomerImpl;
  _Customer._() : super._();

  factory _Customer.fromJson(Map<String, dynamic> json) =
      _$CustomerImpl.fromJson;

  @override
  int get id;
  @override
  String? get customerCode;
  @override
  String? get profilePhotoURL;
  @override
  @JsonKey(fromJson: Customer._userFromJson, toJson: Customer._userToJson)
  User? get user;
  @override
  @JsonKey(fromJson: Customer._addressFromJson, toJson: Customer._addressToJson)
  Address? get address;
  @override
  @JsonKey(ignore: true)
  _$$CustomerImplCopyWith<_$CustomerImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
