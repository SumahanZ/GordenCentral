// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CustomerNotificationImpl _$$CustomerNotificationImplFromJson(
        Map<String, dynamic> json) =>
    _$CustomerNotificationImpl(
      id: json['id'] as int?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      customernotificationtype: CustomerNotification._typeFromJson(
          json['customernotificationtype'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$CustomerNotificationImplToJson(
        _$CustomerNotificationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'customernotificationtype':
          CustomerNotification._typeToJson(instance.customernotificationtype),
    };
