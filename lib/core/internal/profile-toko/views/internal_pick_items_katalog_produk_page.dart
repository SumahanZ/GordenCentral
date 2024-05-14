import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/providers/katalog_produk_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/list_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class PickItemsKatalogProdukPage extends ConsumerStatefulWidget {
  const PickItemsKatalogProdukPage({super.key});

  @override
  ConsumerState<PickItemsKatalogProdukPage> createState() =>
      _PickItemsKatalogProdukPageState();
}

class _PickItemsKatalogProdukPageState
    extends ConsumerState<PickItemsKatalogProdukPage> {
  bool isSelectionMode = false;

  Set<Produk> selectedFlag = {};

  @override
  Widget build(BuildContext context) {
    final produkList = ref.watch(fetchCategoryItemProdukList);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select Produk",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        actions: [
          produkList.asData?.value.unwrapRight() != null &&
                  produkList.asData!.value.unwrapRight()!.isNotEmpty
              ? Padding(
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
                        SizedBox(width: 5.w),
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
              : const SizedBox.shrink(),
        ],
        centerTitle: true,
      ),
      body: SafeArea(
          child: produkList.maybeWhen(data: (data) {
        return data.match((l) {
          return Center(
              child: Text(l.message,
                  style: appStyle(
                      size: 16, color: mainBlack, fw: FontWeight.w600)));
        }, (r) {
          if (r.isEmpty) {
            return Center(
                child: Text("Produk tidak ada, Silakan tambahkan produk",
                    style: appStyle(
                        size: 16, color: mainBlack, fw: FontWeight.w600)));
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10,
                ),
                child: Column(
                  children: [
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemBuilder: (builder, index) {
                        bool isSelected = selectedFlag.contains(r[index]);
                        return Column(
                          children: [
                            Card(
                              elevation: 5,
                              surfaceTintColor: Colors.white,
                              child: ListTile(
                                leading: _buildSelectIcon(isSelected),
                                shape: const RoundedRectangleBorder(),
                                onTap: () => isSelectionMode
                                    ? onTap(isSelected, index, r)
                                    : null,
                                title: ListTile(
                                  onTap: () {
                                  },
                                  shape: const RoundedRectangleBorder(),
                                  contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  title: Column(children: [
                                    IntrinsicHeight(
                                      child: Row(children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: CachedNetworkImage(
                                              imageUrl: r[index]
                                                  .produkGlobalImages[0]
                                                  .globalImageUrl,
                                              width: 70.w,
                                              imageBuilder:
                                                  (context, imageProvider) =>
                                                      Container(
                                                decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    fit: BoxFit.contain,
                                                    image: imageProvider,
                                                  ),
                                                ),
                                              ),
                                              // placeholder: (context, url) =>
                                              //     const Center(
                                              //         child:
                                              //             CircularProgressIndicator()),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      const Icon(Icons.error),
                                            )),
                                        SizedBox(width: 15.w),
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(r[index].name ?? "No name",
                                                  style: appStyle(
                                                      size: 16,
                                                      color: mainBlack,
                                                      fw: FontWeight.w600)),
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                "Ukuran: ${r[index].produkSizes.map((e) => e.name).toList().getConcatenatedList()}",
                                                style: appStyle(
                                                  size: 12,
                                                  color: mainBlack,
                                                  fw: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                "Warna: ${r[index].produkColors.map((e) => e.name).toList().getConcatenatedList()}",
                                                style: appStyle(
                                                  size: 12,
                                                  color: mainBlack,
                                                  fw: FontWeight.w500,
                                                ),
                                              ),
                                              Text(
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                PriceFormatter
                                                    .getFormattedValue(
                                                        r[index].price ?? 0),
                                                style: appStyle(
                                                  size: 16,
                                                  color: mainBlack,
                                                  fw: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ]),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            SizedBox(height: 5.h),
                          ],
                        );
                      },
                      itemCount: r.length,
                    ),
                    if (isSelectionMode && selectedFlag.isNotEmpty) ...[
                      SizedBox(height: 20.h),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedFlag.isNotEmpty) {
                            ref
                                .read(katalogProdukItemSelectionNotifierProvider
                                    .notifier)
                                .configureSelection(selectedFlag.toList());
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
                          "Pilih Produk",
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
          }
        });
      }, loading: () {
        return const Center(child: CircularProgressIndicator());
      }, orElse: () {
        return const SizedBox.shrink();
      })),
    );
  }

  void onTap(bool isSelected, int index, List<Produk> data) {
    setState(() {
      if (selectedFlag.isNotEmpty && selectedFlag.contains(data[index])) {
        selectedFlag.removeWhere((element) => element == data[index]);
      } else {
        selectedFlag.add(data[index]);
      }
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
