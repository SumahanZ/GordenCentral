// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'toko_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TokoNotificationImpl _$$TokoNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$TokoNotificationImpl(
      id: json['id'] as int?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      tokonotificationtype: TokoNotification._typeFromJson(
          json['tokonotificationtype'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$TokoNotificationImplToJson(
        _$TokoNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'tokonotificationtype':
          TokoNotification._typeToJson(instance.tokonotificationtype),
    };
