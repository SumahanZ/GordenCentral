// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'produk_combination.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ProdukCombination _$ProdukCombinationFromJson(Map<String, dynamic> json) {
  return _ProdukCombination.fromJson(json);
}

/// @nodoc
mixin _$ProdukCombination {
  int get id => throw _privateConstructorUsedError;
  int get variantAmount => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: ProdukCombination._productFromJson,
      toJson: ProdukCombination._productToJson)
  Produk? get product => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: ProdukCombination._colorFromJson,
      toJson: ProdukCombination._colorToJson)
  ProdukColor? get color => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: ProdukCombination._sizeFromJson,
      toJson: ProdukCombination._sizeToJson)
  ProdukSize? get size => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProdukCombinationCopyWith<ProdukCombination> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProdukCombinationCopyWith<$Res> {
  factory $ProdukCombinationCopyWith(
          ProdukCombination value, $Res Function(ProdukCombination) then) =
      _$ProdukCombinationCopyWithImpl<$Res, ProdukCombination>;
  @useResult
  $Res call(
      {int id,
      int variantAmount,
      @JsonKey(
          fromJson: ProdukCombination._productFromJson,
          toJson: ProdukCombination._productToJson)
      Produk? product,
      @JsonKey(
          fromJson: ProdukCombination._colorFromJson,
          toJson: ProdukCombination._colorToJson)
      ProdukColor? color,
      @JsonKey(
          fromJson: ProdukCombination._sizeFromJson,
          toJson: ProdukCombination._sizeToJson)
      ProdukSize? size});

  $ProdukCopyWith<$Res>? get product;
  $ProdukColorCopyWith<$Res>? get color;
  $ProdukSizeCopyWith<$Res>? get size;
}

/// @nodoc
class _$ProdukCombinationCopyWithImpl<$Res, $Val extends ProdukCombination>
    implements $ProdukCombinationCopyWith<$Res> {
  _$ProdukCombinationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? variantAmount = null,
    Object? product = freezed,
    Object? color = freezed,
    Object? size = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      variantAmount: null == variantAmount
          ? _value.variantAmount
          : variantAmount // ignore: cast_nullable_to_non_nullable
              as int,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Produk?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ProdukColor?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as ProdukSize?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ProdukCopyWith<$Res>? get product {
    if (_value.product == null) {
      return null;
    }

    return $ProdukCopyWith<$Res>(_value.product!, (value) {
      return _then(_value.copyWith(product: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProdukColorCopyWith<$Res>? get color {
    if (_value.color == null) {
      return null;
    }

    return $ProdukColorCopyWith<$Res>(_value.color!, (value) {
      return _then(_value.copyWith(color: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ProdukSizeCopyWith<$Res>? get size {
    if (_value.size == null) {
      return null;
    }

    return $ProdukSizeCopyWith<$Res>(_value.size!, (value) {
      return _then(_value.copyWith(size: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ProdukCombinationImplCopyWith<$Res>
    implements $ProdukCombinationCopyWith<$Res> {
  factory _$$ProdukCombinationImplCopyWith(_$ProdukCombinationImpl value,
          $Res Function(_$ProdukCombinationImpl) then) =
      __$$ProdukCombinationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      int variantAmount,
      @JsonKey(
          fromJson: ProdukCombination._productFromJson,
          toJson: ProdukCombination._productToJson)
      Produk? product,
      @JsonKey(
          fromJson: ProdukCombination._colorFromJson,
          toJson: ProdukCombination._colorToJson)
      ProdukColor? color,
      @JsonKey(
          fromJson: ProdukCombination._sizeFromJson,
          toJson: ProdukCombination._sizeToJson)
      ProdukSize? size});

  @override
  $ProdukCopyWith<$Res>? get product;
  @override
  $ProdukColorCopyWith<$Res>? get color;
  @override
  $ProdukSizeCopyWith<$Res>? get size;
}

/// @nodoc
class __$$ProdukCombinationImplCopyWithImpl<$Res>
    extends _$ProdukCombinationCopyWithImpl<$Res, _$ProdukCombinationImpl>
    implements _$$ProdukCombinationImplCopyWith<$Res> {
  __$$ProdukCombinationImplCopyWithImpl(_$ProdukCombinationImpl _value,
      $Res Function(_$ProdukCombinationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? variantAmount = null,
    Object? product = freezed,
    Object? color = freezed,
    Object? size = freezed,
  }) {
    return _then(_$ProdukCombinationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      variantAmount: null == variantAmount
          ? _value.variantAmount
          : variantAmount // ignore: cast_nullable_to_non_nullable
              as int,
      product: freezed == product
          ? _value.product
          : product // ignore: cast_nullable_to_non_nullable
              as Produk?,
      color: freezed == color
          ? _value.color
          : color // ignore: cast_nullable_to_non_nullable
              as ProdukColor?,
      size: freezed == size
          ? _value.size
          : size // ignore: cast_nullable_to_non_nullable
              as ProdukSize?,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$ProdukCombinationImpl implements _ProdukCombination {
  _$ProdukCombinationImpl(
      {required this.id,
      required this.variantAmount,
      @JsonKey(
          fromJson: ProdukCombination._productFromJson,
          toJson: ProdukCombination._productToJson)
      this.product,
      @JsonKey(
          fromJson: ProdukCombination._colorFromJson,
          toJson: ProdukCombination._colorToJson)
      this.color,
      @JsonKey(
          fromJson: ProdukCombination._sizeFromJson,
          toJson: ProdukCombination._sizeToJson)
      this.size});

  factory _$ProdukCombinationImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProdukCombinationImplFromJson(json);

  @override
  final int id;
  @override
  final int variantAmount;
  @override
  @JsonKey(
      fromJson: ProdukCombination._productFromJson,
      toJson: ProdukCombination._productToJson)
  final Produk? product;
  @override
  @JsonKey(
      fromJson: ProdukCombination._colorFromJson,
      toJson: ProdukCombination._colorToJson)
  final ProdukColor? color;
  @override
  @JsonKey(
      fromJson: ProdukCombination._sizeFromJson,
      toJson: ProdukCombination._sizeToJson)
  final ProdukSize? size;

  @override
  String toString() {
    return 'ProdukCombination(id: $id, variantAmount: $variantAmount, product: $product, color: $color, size: $size)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProdukCombinationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.variantAmount, variantAmount) ||
                other.variantAmount == variantAmount) &&
            (identical(other.product, product) || other.product == product) &&
            (identical(other.color, color) || other.color == color) &&
            (identical(other.size, size) || other.size == size));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, variantAmount, product, color, size);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ProdukCombinationImplCopyWith<_$ProdukCombinationImpl> get copyWith =>
      __$$ProdukCombinationImplCopyWithImpl<_$ProdukCombinationImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProdukCombinationImplToJson(
      this,
    );
  }
}

abstract class _ProdukCombination implements ProdukCombination {
  factory _ProdukCombination(
      {required final int id,
      required final int variantAmount,
      @JsonKey(
          fromJson: ProdukCombination._productFromJson,
          toJson: ProdukCombination._productToJson)
      final Produk? product,
      @JsonKey(
          fromJson: ProdukCombination._colorFromJson,
          toJson: ProdukCombination._colorToJson)
      final ProdukColor? color,
      @JsonKey(
          fromJson: ProdukCombination._sizeFromJson,
          toJson: ProdukCombination._sizeToJson)
      final ProdukSize? size}) = _$ProdukCombinationImpl;

  factory _ProdukCombination.fromJson(Map<String, dynamic> json) =
      _$ProdukCombinationImpl.fromJson;

  @override
  int get id;
  @override
  int get variantAmount;
  @override
  @JsonKey(
      fromJson: ProdukCombination._productFromJson,
      toJson: ProdukCombination._productToJson)
  Produk? get product;
  @override
  @JsonKey(
      fromJson: ProdukCombination._colorFromJson,
      toJson: ProdukCombination._colorToJson)
  ProdukColor? get color;
  @override
  @JsonKey(
      fromJson: ProdukCombination._sizeFromJson,
      toJson: ProdukCombination._sizeToJson)
  ProdukSize? get size;
  @override
  @JsonKey(ignore: true)
  _$$ProdukCombinationImplCopyWith<_$ProdukCombinationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
