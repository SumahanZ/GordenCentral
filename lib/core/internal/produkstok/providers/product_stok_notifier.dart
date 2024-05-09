// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'product_stok_notifier.g.dart';

@riverpod
class ProductStokNotifier extends _$ProductStokNotifier {
  @override
  List<ProdukStok> build() {
    return [];
  }

  void add(
      {required Map<String, dynamic> color,
      required String size,
      required int amount}) {
    ProdukStok? foundElement;
    final tempArray = List<ProdukStok>.from(state);
    for (var element in tempArray) {
      if (element.produkColor["name"] == color["name"] &&
          element.produkColor["imagePath"] == color["imagePath"] &&
          element.produkSize == size) {
        foundElement = element;
      }
    }

    if (foundElement != null) {
      final changableIndex = tempArray.indexWhere((element) =>
          element.produkColor == foundElement?.produkColor &&
          element.produkSize == foundElement?.produkSize);
      tempArray[changableIndex] = foundElement.copyWith(
          produkColor: color, produkSize: size, stokAmount: amount);
    } else {
      tempArray.add(
          ProdukStok(produkColor: color, produkSize: size, stokAmount: amount));
    }

    state = tempArray;
  }

  void remove(int index) {
    final tempArray = List<ProdukStok>.from(state);
    tempArray.removeAt(index);
    state = tempArray;
  }

  void edit(
      {Map<String, dynamic>? color,
      String? size,
      int? amount,
      required int index}) {
    final tempArray = List<ProdukStok>.from(state);
    final foundTemp = tempArray[index];
    tempArray[index] = foundTemp.copyWith(
        produkColor: color, produkSize: size, stokAmount: amount);
    state = tempArray;
  }
}

class ProdukStok {
  final Map<String, dynamic> produkColor;
  final String produkSize;
  final int stokAmount;

  ProdukStok({
    required this.produkColor,
    required this.produkSize,
    this.stokAmount = 0,
  });

  @override
  bool operator ==(covariant ProdukStok other) {
    if (identical(this, other)) return true;

    return mapEquals(other.produkColor, produkColor) &&
        other.produkSize == produkSize &&
        other.stokAmount == stokAmount;
  }

  @override
  int get hashCode =>
      produkColor.hashCode ^ produkSize.hashCode ^ stokAmount.hashCode;

  ProdukStok copyWith({
    Map<String, dynamic>? produkColor,
    String? produkSize,
    int? stokAmount,
  }) {
    return ProdukStok(
      produkColor: produkColor ?? this.produkColor,
      produkSize: produkSize ?? this.produkSize,
      stokAmount: stokAmount ?? this.stokAmount,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'produkColor': produkColor,
      'produkSize': produkSize,
      'stokAmount': stokAmount,
    };
  }

  factory ProdukStok.fromMap(Map<String, dynamic> map) {
    return ProdukStok(
      produkColor: Map<String, dynamic>.from(
          (map['produkColor'] as Map<String, dynamic>)),
      produkSize: map['produkSize'] as String,
      stokAmount: map['stokAmount'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProdukStok.fromJson(String source) =>
      ProdukStok.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProdukStok(produkColor: $produkColor, produkSize: $produkSize, stokAmount: $stokAmount)';
}
