// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produk_size.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProdukSize _$ProdukSizeFromJson(Map<String, dynamic> json) {
  return _ProdukSize.fromJson(json);
}

/// @nodoc
mixin _$ProdukSize {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProdukSizeCopyWith<ProdukSize> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProdukSizeCopyWith<$Res> {
  factory $ProdukSizeCopyWith(
          ProdukSize value, $Res Function(ProdukSize) then) =
      _$ProdukSizeCopyWithImpl<$Res, ProdukSize>;
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class _$ProdukSizeCopyWithImpl<$Res, $Val extends ProdukSize>
    implements $ProdukSizeCopyWith<$Res> {
  _$ProdukSizeCopyWithImpl(this._value, this._then);

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
abstract class _$$ProdukSizeImplCopyWith<$Res>
    implements $ProdukSizeCopyWith<$Res> {
  factory _$$ProdukSizeImplCopyWith(
          _$ProdukSizeImpl value, $Res Function(_$ProdukSizeImpl) then) =
      __$$ProdukSizeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String name});
}

/// @nodoc
class __$$ProdukSizeImplCopyWithImpl<$Res>
    extends _$ProdukSizeCopyWithImpl<$Res, _$ProdukSizeImpl>
    implements _$$ProdukSizeImplCopyWith<$Res> {
  __$$ProdukSizeImplCopyWithImpl(
      _$ProdukSizeImpl _value, $Res Function(_$ProdukSizeImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
  }) {
    return _then(_$ProdukSizeImpl(
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
class _$ProdukSizeImpl implements _ProdukSize {
  _$ProdukSizeImpl({required this.id, required this.name});

  factory _$ProdukSizeImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProdukSizeImplFromJson(json);

  @override
  final int id;
  @override
  final String name;

  @override
  String toString() {
    return 'ProdukSize(id: $id, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdukSizeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdukSizeImplCopyWith<_$ProdukSizeImpl> get copyWith =>
      __$$ProdukSizeImplCopyWithImpl<_$ProdukSizeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProdukSizeImplToJson(
      this,
    );
  }
}

abstract class _ProdukSize implements ProdukSize {
  factory _ProdukSize({required final int id, required final String name}) =
      _$ProdukSizeImpl;

  factory _ProdukSize.fromJson(Map<String, dynamic> json) =
      _$ProdukSizeImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  @JsonKey(ignore: true)
  _$$ProdukSizeImplCopyWith<_$ProdukSizeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
