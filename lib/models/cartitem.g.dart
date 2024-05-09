// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cartitem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CartItemImpl _$$CartItemImplFromJson(Map<String, dynamic> json) =>
    _$CartItemImpl(
      id: json['id'] as int,
      amount: json['amount'] as int?,
      produkCombination: CartItem._combinationFromJson(
          json['combination'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$$CartItemImplToJson(_$CartItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'amount': instance.amount,
      'combination': CartItem._combinationToJson(instance.produkCombination),
    };
