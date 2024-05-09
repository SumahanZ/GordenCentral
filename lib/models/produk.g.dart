// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProdukImpl _$$ProdukImplFromJson(Map<String, dynamic> json) => _$ProdukImpl(
      id: json['id'] as int?,
      name: json['name'] as String?,
      code: json['code'] as String?,
      description: json['description'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      price: (json['price'] as num?)?.toDouble(),
      tokoId: json['tokoId'] as int?,
      toko: Produk._tokoFromJson(json['toko'] as Map<String, dynamic>?),
      stok: Produk._stokFromJson(json['stok'] as Map<String, dynamic>?),
      rating: json['rating'] == null
          ? const []
          : Produk._listRatingFromJson(json['rating'] as List?),
      promo: Produk._promoFromJson(json['promo'] as Map<String, dynamic>?),
      produkGlobalImages: json['image'] == null
          ? const []
          : Produk._listImagesFromJson(json['image'] as List?),
      produkColors: json['color'] == null
          ? const []
          : Produk._listColorsFromJson(json['color'] as List?),
      produkSizes: json['size'] == null
          ? const []
          : Produk._listSizesFromJson(json['size'] as List?),
      produkCategories: json['categories'] == null
          ? const []
          : Produk._listCategoriesFromJson(json['categories'] as List?),
      produkCombination: json['combination'] == null
          ? const []
          : Produk._listCombinationsFromJson(json['combination'] as List?),
    );

Map<String, dynamic> _$$ProdukImplToJson(_$ProdukImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'description': instance.description,
      'createdAt': instance.createdAt?.toIso8601String(),
      'price': instance.price,
      'tokoId': instance.tokoId,
      'toko': Produk._tokoToJson(instance.toko),
      'stok': Produk._stokToJson(instance.stok),
      'rating': Produk._listRatingToJson(instance.rating),
      'promo': Produk._promoToJson(instance.promo),
      'image': Produk._listImagesToJson(instance.produkGlobalImages),
      'color': Produk._listColorsToJson(instance.produkColors),
      'size': Produk._listSizesToJson(instance.produkSizes),
      'categories': Produk._listCategoriesToJson(instance.produkCategories),
      'combination': Produk._listCombinationsToJson(instance.produkCombination),
    };
