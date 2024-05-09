// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'internal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$InternalImpl _$$InternalImplFromJson(Map<String, dynamic> json) =>
    _$InternalImpl(
      id: json['id'] as int?,
      userCode: json['userCode'] as String?,
      status: json['status'] as String?,
      profilePhotoURL: json['profilePhotoURL'] as String?,
      user: Internal._userFromJson(json['user'] as Map<String, dynamic>?),
      toko: Internal._tokoFromJson(json['toko'] as Map<String, dynamic>?),
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$InternalImplToJson(_$InternalImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userCode': instance.userCode,
      'status': instance.status,
      'profilePhotoURL': instance.profilePhotoURL,
      'user': Internal._userToJson(instance.user),
      'toko': Internal._tokoToJson(instance.toko),
      'role': instance.role,
    };
