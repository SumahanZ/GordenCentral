import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tugas_akhir_project/models/product_selection.dart';

final productSavedProvider =
    StateProvider<ProductSaved?>((ref) => null);

class ProductSaved {
  final String name;
  final String description;
  final double price;
  final List<String> globalImageUrls;
  final ProductSelection productSelection;

  ProductSaved({
    required this.name,
    required this.description,
    required this.price,
    required this.globalImageUrls,
    required this.productSelection,
  });

  @override
  bool operator ==(covariant ProductSaved other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        other.description == description &&
        other.price == price &&
        listEquals(other.globalImageUrls, globalImageUrls) &&
        other.productSelection == productSelection;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        globalImageUrls.hashCode ^
        productSelection.hashCode;
  }

  ProductSaved copyWith({
    String? name,
    String? description,
    double? price,
    List<String>? globalImageUrls,
    ProductSelection? productSelection,
  }) {
    return ProductSaved(
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      globalImageUrls: globalImageUrls ?? this.globalImageUrls,
      productSelection: productSelection ?? this.productSelection,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'price': price,
      'globalImageUrls': globalImageUrls,
      'productSelection': productSelection.toMap(),
    };
  }

  factory ProductSaved.fromMap(Map<String, dynamic> map) {
    return ProductSaved(
      name: map['name'] as String,
      description: map['description'] as String,
      price: map['price'] as double,
      globalImageUrls:
          List<String>.from((map['globalImageUrls'] as List<String>)),
      productSelection: ProductSelection.fromMap(
          map['productSelection'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductSaved.fromJson(String source) =>
      ProductSaved.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductSaved(name: $name, description: $description, price: $price, globalImageUrls: $globalImageUrls, productSelection: $productSelection)';
  }
}
