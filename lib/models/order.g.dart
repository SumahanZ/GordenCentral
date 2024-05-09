// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderImpl _$$OrderImplFromJson(Map<String, dynamic> json) => _$OrderImpl(
      id: json['id'] as int,
      code: json['code'] as String,
      finalPriceTotal: (json['finalPriceTotal'] as num).toDouble(),
      discountAmountTotal: (json['discountAmountTotal'] as num).toDouble(),
      originalPriceTotal: (json['originalPriceTotal'] as num).toDouble(),
      note: json['note'] as String?,
      customerId: json['customerId'] as int?,
      customer:
          Order._customerFromJson(json['customer'] as Map<String, dynamic>?),
      status: Order._statusFromJson(json['status'] as Map<String, dynamic>?),
      toko: Order._tokoFromJson(json['toko'] as Map<String, dynamic>?),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
      cancelledAt: json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
      orderItemList: json['items'] == null
          ? const []
          : Order._listOrderItemsFromJson(json['items'] as List?),
    );

Map<String, dynamic> _$$OrderImplToJson(_$OrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'finalPriceTotal': instance.finalPriceTotal,
      'discountAmountTotal': instance.discountAmountTotal,
      'originalPriceTotal': instance.originalPriceTotal,
      'note': instance.note,
      'customerId': instance.customerId,
      'customer': Order._customerToJson(instance.customer),
      'status': Order._statusToJson(instance.status),
      'toko': Order._tokoToJson(instance.toko),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'items': Order._listOrderItemsToJson(instance.orderItemList),
    };
