// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CityImpl _$$CityImplFromJson(Map<String, dynamic> json) => _$CityImpl(
      id: json['id'] as int,
      name: json['name'] as String,
      provinceId: json['provinceId'] as int?,
      province:
          City._provinceFromJson(json['province'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$CityImplToJson(_$CityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'provinceId': instance.provinceId,
      'province': City._provinceToJson(instance.province),
    };
