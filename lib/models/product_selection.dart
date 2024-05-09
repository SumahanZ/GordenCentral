// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductSelection {
  final List<String> sizes;
  final List<Map<String, String>> colors;
  final List<String> categories;

  ProductSelection(
      {List<String>? sizes,
      List<Map<String, String>>? colors,
      List<String>? categories})
      : sizes = sizes ?? [],
        colors = colors ?? [],
        categories = categories ?? [];

  @override
  bool operator ==(covariant ProductSelection other) {
    if (identical(this, other)) return true;

    return listEquals(other.sizes, sizes) &&
        listEquals(other.colors, colors) &&
        listEquals(other.categories, categories);
  }

  @override
  int get hashCode => sizes.hashCode ^ colors.hashCode ^ categories.hashCode;

  ProductSelection copyWith({
    List<String>? sizes,
    List<Map<String, String>>? colors,
    List<String>? categories,
  }) {
    return ProductSelection(
      sizes: sizes ?? this.sizes,
      colors: colors ?? this.colors,
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'sizes': sizes,
      'colors': colors,
      'categories': categories,
    };
  }

  factory ProductSelection.fromMap(Map<String, dynamic> map) {
    return ProductSelection(
        sizes: List<String>.from((map['sizes'] as List<String>)),
        colors: List<Map<String, String>>.from(
          (map['colors']).map<Map<String, dynamic>>(
            (x) => x,
          ),
        ),
        categories: List<String>.from(
          (map['categories'] as List<String>),
        ));
  }

  String toJson() => json.encode(toMap());

  factory ProductSelection.fromJson(String source) =>
      ProductSelection.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductSelection(sizes: $sizes, colors: $colors, categories: $categories)';
}
