// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartImpl _$$CartImplFromJson(Map<String, dynamic> json) => _$CartImpl(
      id: json['id'] as int,
      customerId: json['customerId'] as int?,
      customer:
          Cart._customerFromJson(json['customer'] as Map<String, dynamic>?),
      cartItemList: json['items'] == null
          ? const []
          : Cart._listCartItemsFromJson(json['items'] as List?),
    );

Map<String, dynamic> _$$CartImplToJson(_$CartImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customer': Cart._customerToJson(instance.customer),
      'items': Cart._listCartItemsToJson(instance.cartItemList),
    };
