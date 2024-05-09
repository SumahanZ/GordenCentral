// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'laporanbarangmasuk.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LaporanBarangMasukImpl _$$LaporanBarangMasukImplFromJson(
        Map<String, dynamic> json) =>
    _$LaporanBarangMasukImpl(
      id: json['id'] as int?,
      amount: json['amount'] as String?,
      deliveryTime: json['deliveryTime'] as int?,
      issuedFrom: json['issuedFrom'] == null
          ? null
          : DateTime.parse(json['issuedFrom'] as String),
      deliveredAt: json['deliveredAt'] == null
          ? null
          : DateTime.parse(json['deliveredAt'] as String),
      produks: json['produks'] == null
          ? const []
          : LaporanBarangMasuk._productFromJson(json['produks'] as List?),
    );

Map<String, dynamic> _$$LaporanBarangMasukImplToJson(
        _$LaporanBarangMasukImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'deliveryTime': instance.deliveryTime,
      'issuedFrom': instance.issuedFrom?.toIso8601String(),
      'deliveredAt': instance.deliveredAt?.toIso8601String(),
      'produks': LaporanBarangMasuk._productToJson(instance.produks),
    };
