// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PromoImpl _$$PromoImplFromJson(Map<String, dynamic> json) => _$PromoImpl(
      id: json['id'] as int,
      discountPercent: json['discountPercent'] as int?,
      expiredAt: json['expiredAt'] == null
          ? null
          : DateTime.parse(json['expiredAt'] as String),
      produk: Promo._produkFromJson(json['produk'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$PromoImplToJson(_$PromoImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'discountPercent': instance.discountPercent,
      'expiredAt': instance.expiredAt?.toIso8601String(),
      'produk': Promo._produkToJson(instance.produk),
    };
