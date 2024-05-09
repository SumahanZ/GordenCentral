// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AddressImpl _$$AddressImplFromJson(Map<String, dynamic> json) =>
    _$AddressImpl(
      id: json['id'] as int,
      streetAddress: json['streetAddress'] as String,
      city: Address._cityFromJson(json['city'] as Map<String, dynamic>?),
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
    );

Map<String, dynamic> _$$AddressImplToJson(_$AddressImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'streetAddress': instance.streetAddress,
      'city': Address._cityToJson(instance.city),
      'country': instance.country,
      'postalCode': instance.postalCode,
    };
