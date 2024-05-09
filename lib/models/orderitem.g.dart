// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'orderitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      id: json['id'] as int,
      amount: json['amount'] as int?,
      produkCombination: OrderItem._combinationFromJson(
          json['combination'] as Map<String, dynamic>?),
      order: OrderItem._orderFromJson(json['order'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'combination': OrderItem._combinationToJson(instance.produkCombination),
      'order': OrderItem._orderToJson(instance.order),
    };
