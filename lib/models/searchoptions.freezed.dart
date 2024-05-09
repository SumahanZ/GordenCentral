// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'searchoptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchOption _$SearchOptionFromJson(Map<String, dynamic> json) {
  return _SearchOption.fromJson(json);
}

/// @nodoc
mixin _$SearchOption {
  double? get maxProdukPriceAmount => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: SearchOption._locationsFromJson,
      toJson: SearchOption._locationToJson)
  List<City> get availableLocations => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: SearchOption._tokosFromJson, toJson: SearchOption._tokosToJson)
  List<Toko> get tokoList => throw _privateConstructorUsedError;
  @JsonKey(
      fromJson: SearchOption._categoriesFromJson,
      toJson: SearchOption._categoriesToJson)
  List<Category> get categories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchOptionCopyWith<SearchOption> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchOptionCopyWith<$Res> {
  factory $SearchOptionCopyWith(
          SearchOption value, $Res Function(SearchOption) then) =
      _$SearchOptionCopyWithImpl<$Res, SearchOption>;
  @useResult
  $Res call(
      {double? maxProdukPriceAmount,
      @JsonKey(
          fromJson: SearchOption._locationsFromJson,
          toJson: SearchOption._locationToJson)
      List<City> availableLocations,
      @JsonKey(
          fromJson: SearchOption._tokosFromJson,
          toJson: SearchOption._tokosToJson)
      List<Toko> tokoList,
      @JsonKey(
          fromJson: SearchOption._categoriesFromJson,
          toJson: SearchOption._categoriesToJson)
      List<Category> categories});
}

/// @nodoc
class _$SearchOptionCopyWithImpl<$Res, $Val extends SearchOption>
    implements $SearchOptionCopyWith<$Res> {
  _$SearchOptionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxProdukPriceAmount = freezed,
    Object? availableLocations = null,
    Object? tokoList = null,
    Object? categories = null,
  }) {
    return _then(_value.copyWith(
      maxProdukPriceAmount: freezed == maxProdukPriceAmount
          ? _value.maxProdukPriceAmount
          : maxProdukPriceAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      availableLocations: null == availableLocations
          ? _value.availableLocations
          : availableLocations // ignore: cast_nullable_to_non_nullable
              as List<City>,
      tokoList: null == tokoList
          ? _value.tokoList
          : tokoList // ignore: cast_nullable_to_non_nullable
              as List<Toko>,
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchOptionImplCopyWith<$Res>
    implements $SearchOptionCopyWith<$Res> {
  factory _$$SearchOptionImplCopyWith(
          _$SearchOptionImpl value, $Res Function(_$SearchOptionImpl) then) =
      __$$SearchOptionImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {double? maxProdukPriceAmount,
      @JsonKey(
          fromJson: SearchOption._locationsFromJson,
          toJson: SearchOption._locationToJson)
      List<City> availableLocations,
      @JsonKey(
          fromJson: SearchOption._tokosFromJson,
          toJson: SearchOption._tokosToJson)
      List<Toko> tokoList,
      @JsonKey(
          fromJson: SearchOption._categoriesFromJson,
          toJson: SearchOption._categoriesToJson)
      List<Category> categories});
}

/// @nodoc
class __$$SearchOptionImplCopyWithImpl<$Res>
    extends _$SearchOptionCopyWithImpl<$Res, _$SearchOptionImpl>
    implements _$$SearchOptionImplCopyWith<$Res> {
  __$$SearchOptionImplCopyWithImpl(
      _$SearchOptionImpl _value, $Res Function(_$SearchOptionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxProdukPriceAmount = freezed,
    Object? availableLocations = null,
    Object? tokoList = null,
    Object? categories = null,
  }) {
    return _then(_$SearchOptionImpl(
      maxProdukPriceAmount: freezed == maxProdukPriceAmount
          ? _value.maxProdukPriceAmount
          : maxProdukPriceAmount // ignore: cast_nullable_to_non_nullable
              as double?,
      availableLocations: null == availableLocations
          ? _value._availableLocations
          : availableLocations // ignore: cast_nullable_to_non_nullable
              as List<City>,
      tokoList: null == tokoList
          ? _value._tokoList
          : tokoList // ignore: cast_nullable_to_non_nullable
              as List<Toko>,
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$SearchOptionImpl implements _SearchOption {
  _$SearchOptionImpl(
      {this.maxProdukPriceAmount,
      @JsonKey(
          fromJson: SearchOption._locationsFromJson,
          toJson: SearchOption._locationToJson)
      final List<City> availableLocations = const [],
      @JsonKey(
          fromJson: SearchOption._tokosFromJson,
          toJson: SearchOption._tokosToJson)
      final List<Toko> tokoList = const [],
      @JsonKey(
          fromJson: SearchOption._categoriesFromJson,
          toJson: SearchOption._categoriesToJson)
      final List<Category> categories = const []})
      : _availableLocations = availableLocations,
        _tokoList = tokoList,
        _categories = categories;

  factory _$SearchOptionImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchOptionImplFromJson(json);

  @override
  final double? maxProdukPriceAmount;
  final List<City> _availableLocations;
  @override
  @JsonKey(
      fromJson: SearchOption._locationsFromJson,
      toJson: SearchOption._locationToJson)
  List<City> get availableLocations {
    if (_availableLocations is EqualUnmodifiableListView)
      return _availableLocations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_availableLocations);
  }

  final List<Toko> _tokoList;
  @override
  @JsonKey(
      fromJson: SearchOption._tokosFromJson, toJson: SearchOption._tokosToJson)
  List<Toko> get tokoList {
    if (_tokoList is EqualUnmodifiableListView) return _tokoList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tokoList);
  }

  final List<Category> _categories;
  @override
  @JsonKey(
      fromJson: SearchOption._categoriesFromJson,
      toJson: SearchOption._categoriesToJson)
  List<Category> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  @override
  String toString() {
    return 'SearchOption(maxProdukPriceAmount: $maxProdukPriceAmount, availableLocations: $availableLocations, tokoList: $tokoList, categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchOptionImpl &&
            (identical(other.maxProdukPriceAmount, maxProdukPriceAmount) ||
                other.maxProdukPriceAmount == maxProdukPriceAmount) &&
            const DeepCollectionEquality()
                .equals(other._availableLocations, _availableLocations) &&
            const DeepCollectionEquality().equals(other._tokoList, _tokoList) &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      maxProdukPriceAmount,
      const DeepCollectionEquality().hash(_availableLocations),
      const DeepCollectionEquality().hash(_tokoList),
      const DeepCollectionEquality().hash(_categories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchOptionImplCopyWith<_$SearchOptionImpl> get copyWith =>
      __$$SearchOptionImplCopyWithImpl<_$SearchOptionImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchOptionImplToJson(
      this,
    );
  }
}

abstract class _SearchOption implements SearchOption {
  factory _SearchOption(
      {final double? maxProdukPriceAmount,
      @JsonKey(
          fromJson: SearchOption._locationsFromJson,
          toJson: SearchOption._locationToJson)
      final List<City> availableLocations,
      @JsonKey(
          fromJson: SearchOption._tokosFromJson,
          toJson: SearchOption._tokosToJson)
      final List<Toko> tokoList,
      @JsonKey(
          fromJson: SearchOption._categoriesFromJson,
          toJson: SearchOption._categoriesToJson)
      final List<Category> categories}) = _$SearchOptionImpl;

  factory _SearchOption.fromJson(Map<String, dynamic> json) =
      _$SearchOptionImpl.fromJson;

  @override
  double? get maxProdukPriceAmount;
  @override
  @JsonKey(
      fromJson: SearchOption._locationsFromJson,
      toJson: SearchOption._locationToJson)
  List<City> get availableLocations;
  @override
  @JsonKey(
      fromJson: SearchOption._tokosFromJson, toJson: SearchOption._tokosToJson)
  List<Toko> get tokoList;
  @override
  @JsonKey(
      fromJson: SearchOption._categoriesFromJson,
      toJson: SearchOption._categoriesToJson)
  List<Category> get categories;
  @override
  @JsonKey(ignore: true)
  _$$SearchOptionImplCopyWith<_$SearchOptionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
