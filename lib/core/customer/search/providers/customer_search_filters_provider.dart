// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'customer_search_filters_provider.g.dart';

@Riverpod(keepAlive: true)
class CustomerSearchFiltersNotifier extends _$CustomerSearchFiltersNotifier {
  @override
  SearchFilter? build() {
    return null;
  }

  void setSearchFilters(SearchFilter filter) {
    state = filter;
  }

  void emptySearchFilters() {
    state = null;
  }
}

class SearchFilter {
  final String? name;
  final Map<String, dynamic> priceRange;
  final Map<String, dynamic> ratingRange;
  final List<String> categoriesList;
  final int? selectedLocationId;
  final int? selectedTokoId;

  SearchFilter(
      {this.name,
      required this.priceRange,
      required this.ratingRange,
      required this.categoriesList,
      this.selectedLocationId,
      this.selectedTokoId});

  @override
  bool operator ==(covariant SearchFilter other) {
    if (identical(this, other)) return true;

    return other.name == name &&
        mapEquals(other.priceRange, priceRange) &&
        mapEquals(other.ratingRange, ratingRange) &&
        listEquals(other.categoriesList, categoriesList) &&
        other.selectedLocationId == selectedLocationId &&
        other.selectedTokoId == selectedTokoId;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        priceRange.hashCode ^
        ratingRange.hashCode ^
        categoriesList.hashCode ^
        selectedLocationId.hashCode ^
        selectedTokoId.hashCode;
  }

  SearchFilter copyWith({
    String? name,
    Map<String, dynamic>? priceRange,
    Map<String, dynamic>? ratingRange,
    List<String>? categoriesList,
    int? selectedLocationId,
    int? selectedTokoId,
  }) {
    return SearchFilter(
      name: name ?? this.name,
      priceRange: priceRange ?? this.priceRange,
      ratingRange: ratingRange ?? this.ratingRange,
      categoriesList: categoriesList ?? this.categoriesList,
      selectedLocationId: selectedLocationId ?? this.selectedLocationId,
      selectedTokoId: selectedTokoId ?? this.selectedTokoId,
    );
  }
}
