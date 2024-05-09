// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toko.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokoImpl _$$TokoImplFromJson(Map<String, dynamic> json) => _$TokoImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      phoneNumber: json['phoneNumber'] as String?,
      bio: json['bio'] as String?,
      whatsAppURL: json['whatsAppURL'] as String?,
      profilePhotoURL: json['profilePhotoURL'] as String?,
      inviteCode: json['inviteCode'] as String?,
      address: Toko._addressFromJson(json['address'] as Map<String, dynamic>?),
      berandaToko: json['promotionals'] == null
          ? const []
          : Toko._listBerandaFromJson(json['promotionals'] as List?),
    );

Map<String, dynamic> _$$TokoImplToJson(_$TokoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phoneNumber': instance.phoneNumber,
      'bio': instance.bio,
      'whatsAppURL': instance.whatsAppURL,
      'profilePhotoURL': instance.profilePhotoURL,
      'inviteCode': instance.inviteCode,
      'address': Toko._addressToJson(instance.address),
      'promotionals': Toko._listBerandaToJson(instance.berandaToko),
    };
