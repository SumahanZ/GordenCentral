// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporanbarangkeluar.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LaporanBarangKeluarImpl _$$LaporanBarangKeluarImplFromJson(
        Map<String, dynamic> json) =>
    _$LaporanBarangKeluarImpl(
      id: json['id'] as int?,
      amount: json['amount'] as String?,
      orderId: json['orderId'] as int?,
      order: LaporanBarangKeluar._orderFromJson(
          json['order'] as Map<String, dynamic>?),
      produks: json['produks'] == null
          ? const []
          : LaporanBarangKeluar._productFromJson(json['produks'] as List?),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
    );

Map<String, dynamic> _$$LaporanBarangKeluarImplToJson(
        _$LaporanBarangKeluarImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'orderId': instance.orderId,
      'order': LaporanBarangKeluar._orderToJson(instance.order),
      'produks': LaporanBarangKeluar._productToJson(instance.produks),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
    };
