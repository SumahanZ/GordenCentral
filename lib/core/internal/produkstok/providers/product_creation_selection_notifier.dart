import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tugas_akhir_project/models/product_selection.dart';

part 'product_creation_selection_notifier.g.dart';

@Riverpod(keepAlive: true)
class ProductCreationSelectionNotifier
    extends _$ProductCreationSelectionNotifier {
  @override
  ProductSelection build() {
    return ProductSelection();
  }

  void addToSizes({required String name}) {
    final sizes = List<String>.from(state.sizes);
    //if the name same we want to instead replace it
    if (sizes.any((element) => element == name)) {
      final foundIndex = sizes.indexWhere((element) => element == name);
      sizes[foundIndex] = name;
    } else {
      sizes.add(name);
    }
    state = state.copyWith(sizes: sizes);
  }

  void addToColors({required String name, required String imagePath}) {
    final colors = List<Map<String, String>>.from(state.colors);
    if (colors.any((element) => element["name"] == name)) {
      final foundIndex =
          colors.indexWhere((element) => element["name"] == name);
      colors[foundIndex] = {"name": name, "imagePath": imagePath};
    } else {
      colors.add({"name": name, "imagePath": imagePath});
    }
    state = state.copyWith(colors: colors);
  }

  void selectCategories({required List<String> newCategories}) {
    state = state.copyWith(categories: newCategories);
  }

  void removeFromSizes({required int index}) {
    final sizes = List<String>.from(state.sizes);
    sizes.removeAt(index);
    state = state.copyWith(sizes: sizes);
  }

  void removeFromColors({required int index}) {
    final colors = List<Map<String, String>>.from(state.colors);
    colors.removeAt(index);
    state = state.copyWith(colors: colors);
  }

  void removeFromCategories({required int index}) {
    final categories = List<String>.from(state.categories);
    categories.removeAt(index);
    state = state.copyWith(categories: categories);
  }

  void initializeSelections(
      {required List<String> sizes,
      required List<Map<String, String>> colors,
      required List<String> categories}) {

    final productSelection =
        ProductSelection(sizes: sizes, colors: colors, categories: categories);
    state = productSelection;
  }

  void resetState() {
    state = ProductSelection(sizes: [], colors: [], categories: []);
  }
}
