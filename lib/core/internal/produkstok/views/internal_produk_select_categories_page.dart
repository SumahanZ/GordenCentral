import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/repositories/implementations/produk_stok_repository_impl.dart';
import 'package:tugas_akhir_project/models/category.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalProdukSelectCategoryPage extends ConsumerStatefulWidget {
  const InternalProdukSelectCategoryPage({super.key});

  @override
  ConsumerState<InternalProdukSelectCategoryPage> createState() =>
      _InternalProdukSelectCategoryPageState();
}

class _InternalProdukSelectCategoryPageState
    extends ConsumerState<InternalProdukSelectCategoryPage> {
  bool isSelectionMode = false;

  Set<Category> selectedFlag = {};

  @override
  Widget build(BuildContext context) {
    final categories = ref.watch(fetchProductCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pilih Kategori",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        actions: [
          if ((categories.asData?.value.unwrapRight() ?? []).isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: GestureDetector(
                onTap: () {
                  if (!isSelectionMode) {
                    setState(() {
                      selectedFlag = {};
                      isSelectionMode = true;
                    });
                  } else {
                    setState(() {
                      isSelectionMode = false;
                    });
                  }
                },
                child: Row(
                  children: [
                    Builder(builder: (context) {
                      if (!isSelectionMode) {
                        return const Icon(Icons.add);
                      } else {
                        return const Icon(Icons.cancel_outlined);
                      }
                    }),
                    const SizedBox(width: 5),
                    Builder(builder: (context) {
                      if (!isSelectionMode) {
                        return Text("Pilih",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500));
                      } else {
                        return Text("Batal",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500));
                      }
                    })
                  ],
                ),
              ),
            )
        ],
        centerTitle: true,
      ),
      body: SafeArea(
          child: categories.maybeWhen(data: (data) {
        return data.match((l) {
          return Center(
              child: Text(l.message,
                  style: appStyle(
                      size: 16, color: mainBlack, fw: FontWeight.w600)));
        }, (r) {
          return r.isEmpty
              ? Center(
                  child: Text("Daftar Kategori Produk kosong",
                      style: appStyle(
                          size: 18, color: mainBlack, fw: FontWeight.w600)))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (builder, index) {
                            bool isSelected = selectedFlag.contains(r[index]);
                            return Column(
                              children: [
                                const SizedBox(height: 5),
                                Card(
                                  elevation: 5,
                                  surfaceTintColor: Colors.white,
                                  child: ListTile(
                                    leading: _buildSelectIcon(isSelected),
                                    shape: const RoundedRectangleBorder(),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    onTap: () => isSelectionMode
                                        ? onTap(isSelected, index, r)
                                        : null,
                                    title: Column(children: [
                                      IntrinsicHeight(
                                        child: Row(children: [
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("Kategori: ",
                                                        style: appStyle(
                                                            size: 16,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .w500)),
                                                    Text(r[index].name,
                                                        style: appStyle(
                                                            size: 18,
                                                            color: mainBlack,
                                                            fw: FontWeight
                                                                .w600))
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ]),
                                      ),
                                      const SizedBox(height: 5),
                                    ]),
                                  ),
                                ),
                                const SizedBox(height: 5),
                              ],
                            );
                          },
                          itemCount: r.length,
                        ),
                        if (isSelectionMode && selectedFlag.isNotEmpty) ...[
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              if (selectedFlag.isNotEmpty) {
                                ref
                                    .read(
                                        productCreationSelectionNotifierProvider
                                            .notifier)
                                    .selectCategories(
                                        newCategories: selectedFlag
                                            .map((e) => e.name)
                                            .toList());
                              }
                              Routemaster.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 5,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 20),
                              minimumSize: const Size.fromHeight(50),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                            ),
                            child: Text(
                              "Pilih Kategori",
                              style: appStyle(
                                  size: 16,
                                  color: Colors.white,
                                  fw: FontWeight.w500),
                            ),
                          ),
                        ]
                      ],
                    ),
                  ),
                );
        });
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }, orElse: () {
        return const SizedBox.shrink();
      })),
    );
  }

  void onTap(bool isSelected, int index, List<Category> data) {
    setState(() {
      if (selectedFlag.isNotEmpty && selectedFlag.contains(data[index])) {
        selectedFlag.removeWhere((element) => element == data[index]);
      } else {
        selectedFlag.add(data[index]);
      }
      print(selectedFlag);
      isSelectionMode = selectedFlag.isNotEmpty ? true : false;
    });
  }

  Widget? _buildSelectIcon(bool isSelected) {
    if (isSelectionMode) {
      return Icon(
        isSelected ? Icons.check_box : Icons.check_box_outline_blank,
      );
    }
    return null;
  }
}
