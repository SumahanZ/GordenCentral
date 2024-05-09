// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'katalog_produk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$KatalogProdukImpl _$$KatalogProdukImplFromJson(Map<String, dynamic> json) =>
    _$KatalogProdukImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      tokoId: json['tokoId'] as int?,
      toko: KatalogProduk._tokoFromJson(json['toko'] as Map<String, dynamic>?),
      produkList: json['products'] == null
          ? const []
          : KatalogProduk._listProductsFromJson(json['products'] as List?),
    );

Map<String, dynamic> _$$KatalogProdukImplToJson(_$KatalogProdukImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'tokoId': instance.tokoId,
      'toko': KatalogProduk._tokoToJson(instance.toko),
      'products': KatalogProduk._listProductsToJson(instance.produkList),
    };
