// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produk_color.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProdukColor _$ProdukColorFromJson(Map<String, dynamic> json) {
  return _ProdukColor.fromJson(json);
}

/// @nodoc
mixin _$ProdukColor {
  int get id => throw _privateConstructorUsedError;
  String get produkColorImageUrl => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProdukColorCopyWith<ProdukColor> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProdukColorCopyWith<$Res> {
  factory $ProdukColorCopyWith(
          ProdukColor value, $Res Function(ProdukColor) then) =
      _$ProdukColorCopyWithImpl<$Res, ProdukColor>;
  @useResult
  $Res call({int id, String produkColorImageUrl, String name});
}

/// @nodoc
class _$ProdukColorCopyWithImpl<$Res, $Val extends ProdukColor>
    implements $ProdukColorCopyWith<$Res> {
  _$ProdukColorCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? produkColorImageUrl = null,
    Object? name = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      produkColorImageUrl: null == produkColorImageUrl
          ? _value.produkColorImageUrl
          : produkColorImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProdukColorImplCopyWith<$Res>
    implements $ProdukColorCopyWith<$Res> {
  factory _$$ProdukColorImplCopyWith(
          _$ProdukColorImpl value, $Res Function(_$ProdukColorImpl) then) =
      __$$ProdukColorImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String produkColorImageUrl, String name});
}

/// @nodoc
class __$$ProdukColorImplCopyWithImpl<$Res>
    extends _$ProdukColorCopyWithImpl<$Res, _$ProdukColorImpl>
    implements _$$ProdukColorImplCopyWith<$Res> {
  __$$ProdukColorImplCopyWithImpl(
      _$ProdukColorImpl _value, $Res Function(_$ProdukColorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? produkColorImageUrl = null,
    Object? name = null,
  }) {
    return _then(_$ProdukColorImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      produkColorImageUrl: null == produkColorImageUrl
          ? _value.produkColorImageUrl
          : produkColorImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ProdukColorImpl implements _ProdukColor {
  _$ProdukColorImpl(
      {required this.id,
      required this.produkColorImageUrl,
      required this.name});

  factory _$ProdukColorImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProdukColorImplFromJson(json);

  @override
  final int id;
  @override
  final String produkColorImageUrl;
  @override
  final String name;

  @override
  String toString() {
    return 'ProdukColor(id: $id, produkColorImageUrl: $produkColorImageUrl, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdukColorImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.produkColorImageUrl, produkColorImageUrl) ||
                other.produkColorImageUrl == produkColorImageUrl) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, produkColorImageUrl, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdukColorImplCopyWith<_$ProdukColorImpl> get copyWith =>
      __$$ProdukColorImplCopyWithImpl<_$ProdukColorImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProdukColorImplToJson(
      this,
    );
  }
}

abstract class _ProdukColor implements ProdukColor {
  factory _ProdukColor(
      {required final int id,
      required final String produkColorImageUrl,
      required final String name}) = _$ProdukColorImpl;

  factory _ProdukColor.fromJson(Map<String, dynamic> json) =
      _$ProdukColorImpl.fromJson;

  @override
  int get id;
  @override
  String get produkColorImageUrl;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ProdukColorImplCopyWith<_$ProdukColorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
