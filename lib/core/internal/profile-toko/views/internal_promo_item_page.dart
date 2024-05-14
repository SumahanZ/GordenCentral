import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/repositories/implementations/produk_stok_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/providers/promo_item_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/list_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalPromoItemPage extends ConsumerStatefulWidget {
  const InternalPromoItemPage({super.key});

  @override
  ConsumerState<InternalPromoItemPage> createState() =>
      _InternalPromoItemPageState();
}

class _InternalPromoItemPageState extends ConsumerState<InternalPromoItemPage> {
  bool isSelectionMode = false;
  Produk? selectedProduk;

  @override
  Widget build(BuildContext context) {
    final produkList = ref.watch(fetchProducts);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pilih Item Promo",
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
                          selectedProduk = null;
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
              : const SizedBox.shrink()
        ],
        centerTitle: true,
      ),
      body: SafeArea(
        child: ref.watch(fetchPromoItemsProvider).when(
              data: (data) {
                return data.match(
                    (l) => Center(
                        child: Text(l.message,
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))), (r) {
                  if (r.isEmpty) {
                    return Center(
                        child: Text(
                      "Toko tidak memiliki produk yang bisa dipilih",
                      style: appStyle(
                          size: 16, color: mainBlack, fw: FontWeight.w600),
                    ));
                  } else {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          children: [
                            ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (builder, index) {
                                bool isSelected = selectedProduk == r[index];
                                return Column(
                                  children: [
                                    SizedBox(height: 5.h),
                                    Card(
                                      elevation: 5,
                                      surfaceTintColor: Colors.white,
                                      child: ListTile(
                                        leading: _buildSelectIcon(isSelected),
                                        shape: const RoundedRectangleBorder(),
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 20, vertical: 5),
                                        onTap: () =>
                                            onTap(isSelected, index, r),
                                        title: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "Stok: ${r[index].stok?.totalAmount ?? 0}",
                                                style: appStyle(
                                                  size: 16,
                                                  color: mainBlack,
                                                  fw: FontWeight.w600,
                                                ),
                                              ),
                                              IntrinsicHeight(
                                                child: Row(children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    child: Image.network(
                                                        r[index]
                                                            .produkGlobalImages
                                                            .first
                                                            .globalImageUrl,
                                                        fit: BoxFit.contain,
                                                        width: 70.w),
                                                  ),
                                                  SizedBox(width: 15.w),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                            r[index].name ??
                                                                "No name",
                                                            style: appStyle(
                                                                size: 16,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w600)),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "Ukuran: ${r[index].produkSizes.map((e) => e.name).toList().getConcatenatedList()}",
                                                          style: appStyle(
                                                            size: 12,
                                                            color: mainBlack,
                                                            fw: FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          "Warna: ${r[index].produkColors.map((e) => e.name).toList().getConcatenatedList()}",
                                                          style: appStyle(
                                                            size: 12,
                                                            color: mainBlack,
                                                            fw: FontWeight.w500,
                                                          ),
                                                        ),
                                                        Text(
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          PriceFormatter
                                                              .getFormattedValue(r[
                                                                          index]
                                                                      .price ??
                                                                  0),
                                                          style: appStyle(
                                                            size: 14,
                                                            color: mainBlack,
                                                            fw: FontWeight.bold,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ]),
                                              ),
                                              SizedBox(height: 5.h),
                                            ]),
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                  ],
                                );
                              },
                              itemCount: r.length,
                            ),
                            if (isSelectionMode && selectedProduk != null) ...[
                              SizedBox(height: 20.h),
                              ElevatedButton(
                                onPressed: () {
                                  ref
                                      .read(promoItemSelectionNotifierProvider
                                          .notifier)
                                      .selectProduct(selectedProduk!);
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
              },
              error: (error, stackTrace) => Center(
                child: Text(
                  error.toString(),
                ),
              ),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
    );
  }

  void onTap(bool isSelected, int index, List<Produk> produkList) {
    if (isSelectionMode) {
      setState(() {
        if (selectedProduk != null &&
            produkList[index].id == selectedProduk?.id) {
          selectedProduk = null;
        } else if (selectedProduk != null &&
            produkList[index].id == selectedProduk?.id) {
          selectedProduk = produkList[index];
        } else {
          selectedProduk = produkList[index];
        }

        isSelectionMode = selectedProduk != null ? true : false;
      });
    }
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
