// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerImpl _$$CustomerImplFromJson(Map<String, dynamic> json) =>
    _$CustomerImpl(
      id: json['id'] as int,
      customerCode: json['customerCode'] as String?,
      profilePhotoURL: json['profilePhotoURL'] as String?,
      user: Customer._userFromJson(json['user'] as Map<String, dynamic>?),
      address:
          Customer._addressFromJson(json['address'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$CustomerImplToJson(_$CustomerImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerCode': instance.customerCode,
      'profilePhotoURL': instance.profilePhotoURL,
      'user': Customer._userToJson(instance.user),
      'address': Customer._addressToJson(instance.address),
    };
