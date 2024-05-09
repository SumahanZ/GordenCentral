// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produk_combination.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProdukCombinationImpl _$$ProdukCombinationImplFromJson(
        Map<String, dynamic> json) =>
    _$ProdukCombinationImpl(
      id: json['id'] as int,
      variantAmount: json['variantAmount'] as int,
      product: ProdukCombination._productFromJson(
          json['product'] as Map<String, dynamic>?),
      color: ProdukCombination._colorFromJson(
          json['color'] as Map<String, dynamic>?),
      size: ProdukCombination._sizeFromJson(
          json['size'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$ProdukCombinationImplToJson(
        _$ProdukCombinationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'variantAmount': instance.variantAmount,
      'product': ProdukCombination._productToJson(instance.product),
      'color': ProdukCombination._colorToJson(instance.color),
      'size': ProdukCombination._sizeToJson(instance.size),
    };
