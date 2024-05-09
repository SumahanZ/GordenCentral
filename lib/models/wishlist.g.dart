// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wishlist.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WishlistImpl _$$WishlistImplFromJson(Map<String, dynamic> json) =>
    _$WishlistImpl(
      id: json['id'] as int,
      customerId: json['customerId'] as int?,
      customer:
          Wishlist._customerFromJson(json['customer'] as Map<String, dynamic>?),
      produkList: json['products'] == null
          ? const []
          : Wishlist._listProduksFromJson(json['products'] as List?),
    );

Map<String, dynamic> _$$WishlistImplToJson(_$WishlistImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'customerId': instance.customerId,
      'customer': Wishlist._customerToJson(instance.customer),
      'products': Wishlist._listProduksToJson(instance.produkList),
    };
