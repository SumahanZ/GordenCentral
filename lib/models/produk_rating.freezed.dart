// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produk_rating.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProdukRating _$ProdukRatingFromJson(Map<String, dynamic> json) {
  return _ProdukRating.fromJson(json);
}

/// @nodoc
mixin _$ProdukRating {
  double? get averageRating => throw _privateConstructorUsedError;
  int? get totalRating => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProdukRatingCopyWith<ProdukRating> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProdukRatingCopyWith<$Res> {
  factory $ProdukRatingCopyWith(
          ProdukRating value, $Res Function(ProdukRating) then) =
      _$ProdukRatingCopyWithImpl<$Res, ProdukRating>;
  @useResult
  $Res call({double? averageRating, int? totalRating});
}

/// @nodoc
class _$ProdukRatingCopyWithImpl<$Res, $Val extends ProdukRating>
    implements $ProdukRatingCopyWith<$Res> {
  _$ProdukRatingCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageRating = freezed,
    Object? totalRating = freezed,
  }) {
    return _then(_value.copyWith(
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRating: freezed == totalRating
          ? _value.totalRating
          : totalRating // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ProdukRatingImplCopyWith<$Res>
    implements $ProdukRatingCopyWith<$Res> {
  factory _$$ProdukRatingImplCopyWith(
          _$ProdukRatingImpl value, $Res Function(_$ProdukRatingImpl) then) =
      __$$ProdukRatingImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double? averageRating, int? totalRating});
}

/// @nodoc
class __$$ProdukRatingImplCopyWithImpl<$Res>
    extends _$ProdukRatingCopyWithImpl<$Res, _$ProdukRatingImpl>
    implements _$$ProdukRatingImplCopyWith<$Res> {
  __$$ProdukRatingImplCopyWithImpl(
      _$ProdukRatingImpl _value, $Res Function(_$ProdukRatingImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? averageRating = freezed,
    Object? totalRating = freezed,
  }) {
    return _then(_$ProdukRatingImpl(
      averageRating: freezed == averageRating
          ? _value.averageRating
          : averageRating // ignore: cast_nullable_to_non_nullable
              as double?,
      totalRating: freezed == totalRating
          ? _value.totalRating
          : totalRating // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ProdukRatingImpl implements _ProdukRating {
  _$ProdukRatingImpl({this.averageRating, this.totalRating});

  factory _$ProdukRatingImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProdukRatingImplFromJson(json);

  @override
  final double? averageRating;
  @override
  final int? totalRating;

  @override
  String toString() {
    return 'ProdukRating(averageRating: $averageRating, totalRating: $totalRating)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdukRatingImpl &&
            (identical(other.averageRating, averageRating) ||
                other.averageRating == averageRating) &&
            (identical(other.totalRating, totalRating) ||
                other.totalRating == totalRating));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, averageRating, totalRating);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdukRatingImplCopyWith<_$ProdukRatingImpl> get copyWith =>
      __$$ProdukRatingImplCopyWithImpl<_$ProdukRatingImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProdukRatingImplToJson(
      this,
    );
  }
}

abstract class _ProdukRating implements ProdukRating {
  factory _ProdukRating({final double? averageRating, final int? totalRating}) =
      _$ProdukRatingImpl;

  factory _ProdukRating.fromJson(Map<String, dynamic> json) =
      _$ProdukRatingImpl.fromJson;

  @override
  double? get averageRating;
  @override
  int? get totalRating;
  @override
  @JsonKey(ignore: true)
  _$$ProdukRatingImplCopyWith<_$ProdukRatingImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
