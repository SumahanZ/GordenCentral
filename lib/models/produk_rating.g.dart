// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produk_rating.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProdukRatingImpl _$$ProdukRatingImplFromJson(Map<String, dynamic> json) =>
    _$ProdukRatingImpl(
      averageRating: (json['averageRating'] as num?)?.toDouble(),
      totalRating: json['totalRating'] as int?,
    );

Map<String, dynamic> _$$ProdukRatingImplToJson(_$ProdukRatingImpl instance) =>
    <String, dynamic>{
      'averageRating': instance.averageRating,
      'totalRating': instance.totalRating,
    };
