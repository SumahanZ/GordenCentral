// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'searchoptions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SearchOptionImpl _$$SearchOptionImplFromJson(Map<String, dynamic> json) =>
    _$SearchOptionImpl(
      maxProdukPriceAmount: (json['maxProdukPriceAmount'] as num?)?.toDouble(),
      availableLocations: json['availableLocations'] == null
          ? const []
          : SearchOption._locationsFromJson(
              json['availableLocations'] as List?),
      tokoList: json['tokoList'] == null
          ? const []
          : SearchOption._tokosFromJson(json['tokoList'] as List?),
      categories: json['categories'] == null
          ? const []
          : SearchOption._categoriesFromJson(json['categories'] as List?),
    );

Map<String, dynamic> _$$SearchOptionImplToJson(_$SearchOptionImpl instance) =>
    <String, dynamic>{
      'maxProdukPriceAmount': instance.maxProdukPriceAmount,
      'availableLocations':
          SearchOption._locationToJson(instance.availableLocations),
      'tokoList': SearchOption._tokosToJson(instance.tokoList),
      'categories': SearchOption._categoriesToJson(instance.categories),
    };
