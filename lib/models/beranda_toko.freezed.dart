// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'beranda_toko.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

BerandaToko _$BerandaTokoFromJson(Map<String, dynamic> json) {
  return _BerandaToko.fromJson(json);
}

/// @nodoc
mixin _$BerandaToko {
  int? get id => throw _privateConstructorUsedError;
  String? get berandaImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BerandaTokoCopyWith<BerandaToko> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BerandaTokoCopyWith<$Res> {
  factory $BerandaTokoCopyWith(
          BerandaToko value, $Res Function(BerandaToko) then) =
      _$BerandaTokoCopyWithImpl<$Res, BerandaToko>;
  @useResult
  $Res call({int? id, String? berandaImageUrl});
}

/// @nodoc
class _$BerandaTokoCopyWithImpl<$Res, $Val extends BerandaToko>
    implements $BerandaTokoCopyWith<$Res> {
  _$BerandaTokoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? berandaImageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      berandaImageUrl: freezed == berandaImageUrl
          ? _value.berandaImageUrl
          : berandaImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$BerandaTokoImplCopyWith<$Res>
    implements $BerandaTokoCopyWith<$Res> {
  factory _$$BerandaTokoImplCopyWith(
          _$BerandaTokoImpl value, $Res Function(_$BerandaTokoImpl) then) =
      __$$BerandaTokoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? id, String? berandaImageUrl});
}

/// @nodoc
class __$$BerandaTokoImplCopyWithImpl<$Res>
    extends _$BerandaTokoCopyWithImpl<$Res, _$BerandaTokoImpl>
    implements _$$BerandaTokoImplCopyWith<$Res> {
  __$$BerandaTokoImplCopyWithImpl(
      _$BerandaTokoImpl _value, $Res Function(_$BerandaTokoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? berandaImageUrl = freezed,
  }) {
    return _then(_$BerandaTokoImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      berandaImageUrl: freezed == berandaImageUrl
          ? _value.berandaImageUrl
          : berandaImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$BerandaTokoImpl implements _BerandaToko {
  _$BerandaTokoImpl({this.id, this.berandaImageUrl});

  factory _$BerandaTokoImpl.fromJson(Map<String, dynamic> json) =>
      _$$BerandaTokoImplFromJson(json);

  @override
  final int? id;
  @override
  final String? berandaImageUrl;

  @override
  String toString() {
    return 'BerandaToko(id: $id, berandaImageUrl: $berandaImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BerandaTokoImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.berandaImageUrl, berandaImageUrl) ||
                other.berandaImageUrl == berandaImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, berandaImageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$BerandaTokoImplCopyWith<_$BerandaTokoImpl> get copyWith =>
      __$$BerandaTokoImplCopyWithImpl<_$BerandaTokoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BerandaTokoImplToJson(
      this,
    );
  }
}

abstract class _BerandaToko implements BerandaToko {
  factory _BerandaToko({final int? id, final String? berandaImageUrl}) =
      _$BerandaTokoImpl;

  factory _BerandaToko.fromJson(Map<String, dynamic> json) =
      _$BerandaTokoImpl.fromJson;

  @override
  int? get id;
  @override
  String? get berandaImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$BerandaTokoImplCopyWith<_$BerandaTokoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
