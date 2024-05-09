// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produk_image.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProdukImage _$ProdukImageFromJson(Map<String, dynamic> json) {
  return _ProdukImage.fromJson(json);
}

/// @nodoc
mixin _$ProdukImage {
  int get id => throw _privateConstructorUsedError;
  String get globalImageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProdukImageCopyWith<ProdukImage> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProdukImageCopyWith<$Res> {
  factory $ProdukImageCopyWith(
          ProdukImage value, $Res Function(ProdukImage) then) =
      _$ProdukImageCopyWithImpl<$Res, ProdukImage>;
  @useResult
  $Res call({int id, String globalImageUrl});
}

/// @nodoc
class _$ProdukImageCopyWithImpl<$Res, $Val extends ProdukImage>
    implements $ProdukImageCopyWith<$Res> {
  _$ProdukImageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? globalImageUrl = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      globalImageUrl: null == globalImageUrl
          ? _value.globalImageUrl
          : globalImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProdukImageImplCopyWith<$Res>
    implements $ProdukImageCopyWith<$Res> {
  factory _$$ProdukImageImplCopyWith(
          _$ProdukImageImpl value, $Res Function(_$ProdukImageImpl) then) =
      __$$ProdukImageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String globalImageUrl});
}

/// @nodoc
class __$$ProdukImageImplCopyWithImpl<$Res>
    extends _$ProdukImageCopyWithImpl<$Res, _$ProdukImageImpl>
    implements _$$ProdukImageImplCopyWith<$Res> {
  __$$ProdukImageImplCopyWithImpl(
      _$ProdukImageImpl _value, $Res Function(_$ProdukImageImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? globalImageUrl = null,
  }) {
    return _then(_$ProdukImageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      globalImageUrl: null == globalImageUrl
          ? _value.globalImageUrl
          : globalImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ProdukImageImpl implements _ProdukImage {
  _$ProdukImageImpl({required this.id, required this.globalImageUrl});

  factory _$ProdukImageImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProdukImageImplFromJson(json);

  @override
  final int id;
  @override
  final String globalImageUrl;

  @override
  String toString() {
    return 'ProdukImage(id: $id, globalImageUrl: $globalImageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdukImageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.globalImageUrl, globalImageUrl) ||
                other.globalImageUrl == globalImageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, globalImageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdukImageImplCopyWith<_$ProdukImageImpl> get copyWith =>
      __$$ProdukImageImplCopyWithImpl<_$ProdukImageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProdukImageImplToJson(
      this,
    );
  }
}

abstract class _ProdukImage implements ProdukImage {
  factory _ProdukImage(
      {required final int id,
      required final String globalImageUrl}) = _$ProdukImageImpl;

  factory _ProdukImage.fromJson(Map<String, dynamic> json) =
      _$ProdukImageImpl.fromJson;

  @override
  int get id;
  @override
  String get globalImageUrl;
  @override
  @JsonKey(ignore: true)
  _$$ProdukImageImplCopyWith<_$ProdukImageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
