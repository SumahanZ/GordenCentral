// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'stok.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$StokImpl _$$StokImplFromJson(Map<String, dynamic> json) => _$StokImpl(
      id: json['id'] as int,
      totalAmount: json['totalAmount'] as int?,
      safetyStock: json['safetyStock'] as int?,
      reorderPoint: json['reorderPoint'] as int?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$StokImplToJson(_$StokImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'totalAmount': instance.totalAmount,
      'safetyStock': instance.safetyStock,
      'reorderPoint': instance.reorderPoint,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
