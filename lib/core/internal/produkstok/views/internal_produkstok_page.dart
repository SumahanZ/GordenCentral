import 'dart:async';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/repositories/implementations/produk_stok_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/viewmodels/produk_stok_viewmodel.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/label_none_form_field_widget.dart';

class InternalProdukStokPage extends ConsumerStatefulWidget {
  const InternalProdukStokPage({super.key});

  @override
  ConsumerState<InternalProdukStokPage> createState() =>
      _InternalProdukStokPageState();
}

class _InternalProdukStokPageState
    extends ConsumerState<InternalProdukStokPage> {
  bool _initialized = false;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  Timer? _debounce;
  late ProductsStockTableDataSource _productsStokTableSource;
  final _productNameController = TextEditingController();
  PaginatorController? _controller;

  void sortProductsStock<T>(
    Comparable<T> Function(Produk d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _productsStokTableSource.sort(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<Produk> filterProductsSearch(
      {required String searchQuery, required List<Produk> produkList}) {
    return searchQuery == ""
        ? produkList
        : produkList.where((element) {
            return (RegExp(searchQuery, caseSensitive: false)
                    .hasMatch(element.name ?? "") ||
                RegExp(searchQuery, caseSensitive: false)
                    .hasMatch(element.code ?? ""));
          }).toList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _productsStokTableSource = ProductsStockTableDataSource(context, [], ref);
      _controller = PaginatorController();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller?.dispose();
    _productsStokTableSource.dispose();
    _productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(produkStokViewModelProvider, (previousState, state) {
      if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Kesalahan respon telah terjadi!",
            onOkPress: () {});
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Permintaan jaringan telah terjadi!",
            onOkPress: () {});
      } else if (state is AsyncError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ApiError).message,
            onOkPress: () {});
      }
    });
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Produk & Stok",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: ref.watch(fetchStockGeneralInformation).maybeWhen(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (generalInformation) {
                return ref.watch(fetchProductsTable).maybeWhen(
                    data: (data) {
                      return data.match(
                          (l) => Center(
                              child: Text(l.message,
                                  style: appStyle(
                                      size: 16,
                                      color: mainBlack,
                                      fw: FontWeight.w600))), (r) {
                        final filteredProductsStock = filterProductsSearch(
                            searchQuery: _productNameController.text,
                            produkList: r);

                        _productsStokTableSource = ProductsStockTableDataSource(
                            context, filteredProductsStock, ref);

                        return ref.watch(produkStokViewModelProvider).maybeWhen(
                            data: (data) {
                              return SafeArea(
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20.0, horizontal: 10),
                                        child: Column(children: [
                                          IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Text(
                                                    "Safety Stock & Reorder Point",
                                                    style: appStyle(
                                                        size: 20,
                                                        color: mainBlack,
                                                        fw: FontWeight.w600)),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          LayoutBuilder(
                                            builder: ((context, constraints) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  InkWell(
                                                    onTap: () => Routemaster.of(
                                                            context)
                                                        .push(
                                                            '/internal-dashboard/produkstok/add-stok'),
                                                    child: SizedBox(
                                                      width:
                                                          constraints.maxWidth *
                                                              0.3,
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        surfaceTintColor:
                                                            Colors.purple,
                                                        elevation: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child:
                                                              Column(children: [
                                                            Center(
                                                              child: Text(
                                                                  "Tambah \n Stok",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: appStyle(
                                                                      size: 14,
                                                                      color:
                                                                          mainBlack,
                                                                      fw: FontWeight
                                                                          .w600)),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      showPopupModal(
                                                          context: context,
                                                          title: "Peringatan",
                                                          info: DialogType
                                                              .warning,
                                                          animType:
                                                              AnimType.scale,
                                                          desc:
                                                              "Anda yakin ingin menghitung stok keamanan & titik pemesanan ulang dari produk-produk tersebut?",
                                                          onOkPress: () {
                                                            ref
                                                                .read(produkStokViewModelProvider
                                                                    .notifier)
                                                                .calculateSafetyStockReorderPoint(
                                                                    context)
                                                                .then(
                                                                    (value) {});
                                                          },
                                                          onCancelPress: () {});
                                                    },
                                                    child: SizedBox(
                                                      width:
                                                          constraints.maxWidth *
                                                              0.3,
                                                      child: Material(
                                                        surfaceTintColor:
                                                            Colors.purple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        elevation: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child:
                                                              Column(children: [
                                                            Text(
                                                                "Kalkulasi SS & ROP",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: appStyle(
                                                                    size: 14,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .w600))
                                                          ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      ref.read(productCreationSelectionNotifierProvider.notifier).resetState();
                                                      Routemaster.of(context).push(
                                                          '/internal-dashboard/produkstok/input-produk');
                                                    },
                                                    child: SizedBox(
                                                      width:
                                                          constraints.maxWidth *
                                                              0.3,
                                                      child: Material(
                                                        surfaceTintColor:
                                                            Colors.purple,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        elevation: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child:
                                                              Column(children: [
                                                            Text("Input Produk",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: appStyle(
                                                                    size: 14,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .w600))
                                                          ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                          SizedBox(height: 20.h),
                                          LayoutBuilder(
                                            builder: ((context, constraints) {
                                              return Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  SizedBox(width: 7.w),
                                                  InkWell(
                                                    onTap: () => ref
                                                        .read(
                                                            produkStokViewModelProvider
                                                                .notifier)
                                                        .checkSafetyStockReorderPoint(
                                                            context)
                                                        .then((value) {
                                                      // showPopupModal(
                                                      //     context: context,
                                                      //     title: "Berhasil",
                                                      //     info: DialogType
                                                      //         .success,
                                                      //     animType:
                                                      //         AnimType.scale,
                                                      //     desc:
                                                      //         "Berhasil mengecek stok level produk!",
                                                      //     onOkPress: () {});
                                                    }),
                                                    child: SizedBox(
                                                      width:
                                                          constraints.maxWidth *
                                                              0.3,
                                                      child: Material(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        surfaceTintColor:
                                                            Colors.purple,
                                                        elevation: 5,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(12.0),
                                                          child:
                                                              Column(children: [
                                                            Center(
                                                              child: Text(
                                                                  "Cek \n Stok",
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: appStyle(
                                                                      size: 14,
                                                                      color:
                                                                          mainBlack,
                                                                      fw: FontWeight
                                                                          .w600)),
                                                            )
                                                          ]),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                          SizedBox(height: 30.h),
                                          Card(
                                            surfaceTintColor: Colors.white,
                                            elevation: 5,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 20.0,
                                                      horizontal: 20),
                                              child: Column(children: [
                                                IntrinsicHeight(
                                                  child: Row(children: [
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                              "Informasi Stok:",
                                                              style: appStyle(
                                                                  size: 20,
                                                                  color:
                                                                      mainBlack,
                                                                  fw: FontWeight
                                                                      .w600)),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: [
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child:
                                                            Column(children: [
                                                          Text(
                                                              "${generalInformation["outOfStockProductCount"]}",
                                                              style: appStyle(
                                                                  size: 22,
                                                                  color:
                                                                      mainBlack,
                                                                  fw: FontWeight
                                                                      .bold)),
                                                          ConstrainedBox(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 120,
                                                            ),
                                                            child: Text(
                                                                "Produk \n Out of Stock",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: appStyle(
                                                                    size: 16,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .w500)),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                    Flexible(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12.0),
                                                        child:
                                                            Column(children: [
                                                          Text(
                                                              "${generalInformation["criticalStockProductCount"]}",
                                                              style: appStyle(
                                                                  size: 22,
                                                                  color:
                                                                      mainBlack,
                                                                  fw: FontWeight
                                                                      .bold)),
                                                          ConstrainedBox(
                                                            constraints:
                                                                const BoxConstraints(
                                                              minWidth: 100,
                                                              maxWidth: 120,
                                                            ),
                                                            child: Text(
                                                                "Reorder Point",
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                                style: appStyle(
                                                                    size: 16,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .w500)),
                                                          )
                                                        ]),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ]),
                                            ),
                                          ),
                                          SizedBox(height: 30.h),
                                          IntrinsicHeight(
                                            child: Row(
                                              children: [
                                                Text(
                                                  "Informasi Produk & Stok",
                                                  style: appStyle(
                                                      size: 20,
                                                      color: mainBlack,
                                                      fw: FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20.h),
                                          NoLabelCustomTextField(
                                            hintText:
                                                "Search nama/kode produk...",
                                            controller: _productNameController,
                                            onChanged: (value) {
                                              if (_debounce?.isActive ??
                                                  false) {
                                                _debounce?.cancel();
                                              }
                                              _debounce = Timer(
                                                  const Duration(
                                                      milliseconds: 200), () {
                                                setState(() {});
                                              });
                                            },
                                          ),
                                          SizedBox(height: 10.h),
                                          SizedBox(
                                            height: 500.h,
                                            child: PaginatedDataTable2(
                                              renderEmptyRowsInTheEnd: false,
                                              empty: Center(
                                                child: Text(
                                                    "Data stok produk tidak tersedia",
                                                    style: appStyle(
                                                        size: 13,
                                                        color: mainBlack,
                                                        fw: FontWeight.w600)),
                                              ),
                                              autoRowsToHeight: true,
                                              wrapInCard: false,
                                              fit: FlexFit.tight,
                                              sortArrowIcon:
                                                  Icons.keyboard_arrow_up,
                                              controller: _controller,
                                              sortColumnIndex: _sortColumnIndex,
                                              sortAscending: _sortAscending,
                                              rowsPerPage: PaginatedDataTable
                                                  .defaultRowsPerPage,
                                              headingTextStyle: appStyle(
                                                  size: 13,
                                                  color: mainBlack,
                                                  fw: FontWeight.w600),
                                              dataTextStyle: appStyle(
                                                  size: 12,
                                                  color: mainBlack,
                                                  fw: FontWeight.w600),
                                              horizontalMargin: 5,
                                              columnSpacing: 10,
                                              minWidth: 950,
                                              columns: [
                                                DataColumn2(
                                                  label: const Text('No.'),
                                                  size: ColumnSize.S,
                                                  onSort: (columnIndex,
                                                          ascending) =>
                                                      sortProductsStock<String>(
                                                          (d) =>
                                                              d.id.toString(),
                                                          columnIndex,
                                                          ascending),
                                                ),
                                                DataColumn2(
                                                  label: const Text('Nama'),
                                                  size: ColumnSize.L,
                                                  onSort: (columnIndex,
                                                          ascending) =>
                                                      sortProductsStock<String>(
                                                          (d) => d.name ?? "",
                                                          columnIndex,
                                                          ascending),
                                                ),
                                                DataColumn2(
                                                  label: const Text('Code'),
                                                  size: ColumnSize.M,
                                                  onSort: (columnIndex,
                                                          ascending) =>
                                                      sortProductsStock<String>(
                                                          (d) => d.code ?? "",
                                                          columnIndex,
                                                          ascending),
                                                ),
                                                DataColumn2(
                                                  label: const Text('Jumlah'),
                                                  size: ColumnSize.M,
                                                  onSort: (columnIndex,
                                                          ascending) =>
                                                      sortProductsStock<String>(
                                                          (d) => ((d.stok?.totalAmount ??
                                                                      0) -
                                                                  (d.stok?.safetyStock ??
                                                                      0))
                                                              .toString(),
                                                          columnIndex,
                                                          ascending),
                                                ),
                                                DataColumn2(
                                                  label: const Text('SS'),
                                                  size: ColumnSize.S,
                                                  onSort: (columnIndex,
                                                          ascending) =>
                                                      sortProductsStock<String>(
                                                          (d) =>
                                                              d.stok
                                                                  ?.safetyStock
                                                                  .toString() ??
                                                              "0",
                                                          columnIndex,
                                                          ascending),
                                                ),
                                                DataColumn2(
                                                  label: const Text("ROP"),
                                                  size: ColumnSize.S,
                                                  onSort: (columnIndex,
                                                          ascending) =>
                                                      sortProductsStock<String>(
                                                          (d) =>
                                                              d.stok
                                                                  ?.reorderPoint
                                                                  .toString() ??
                                                              "0",
                                                          columnIndex,
                                                          ascending),
                                                ),
                                                DataColumn2(
                                                  label:
                                                      const Text("Created At"),
                                                  onSort: (columnIndex,
                                                          ascending) =>
                                                      sortProductsStock<
                                                              DateTime>(
                                                          (d) =>
                                                              d.stok
                                                                  ?.createdAt ??
                                                              DateTime.now(),
                                                          columnIndex,
                                                          ascending),
                                                ),
                                                DataColumn2(
                                                  label: const Text("Added At"),
                                                  onSort: (columnIndex,
                                                          ascending) =>
                                                      sortProductsStock<
                                                              DateTime>(
                                                          (d) =>
                                                              d.stok
                                                                  ?.updatedAt ??
                                                              DateTime.now(),
                                                          columnIndex,
                                                          ascending),
                                                ),
                                                //add actions here
                                                const DataColumn2(
                                                  label: Text("Actions"),
                                                  size: ColumnSize.S,
                                                ),
                                              ],
                                              source: _productsStokTableSource,
                                            ),
                                          )
                                        ]),
                                      ),
                                    ]),
                                  ),
                                ),
                              );
                            },
                            loading: () => const Center(
                                child: CircularProgressIndicator()),
                            orElse: () => const SizedBox.shrink());
                      });
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    orElse: () => const SizedBox.shrink());
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox.shrink()));
  }
}

class ProductsStockTableDataSource extends DataTableSource {
  final BuildContext context;
  final WidgetRef ref;
  late List<Produk> productsStock;
  // bool hasRowTaps = false;
  // bool hasRowHeightOverrides = false;
  final _selectedCount = 0;
  // bool hasZebraStripes = false;

  ProductsStockTableDataSource.empty(this.context, this.ref) {
    productsStock = [];
  }

  ProductsStockTableDataSource(
      this.context, List<Produk> fromProductsStock, this.ref) {
    productsStock = fromProductsStock;
  }

  void sort<T>(Comparable<T> Function(Produk d) getField, bool ascending) {
    productsStock.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => productsStock.length;

  @override
  int get selectedRowCount => _selectedCount;

  @override
  DataRow? getRow(int index) {
    return DataRow(
      color: const MaterialStatePropertyAll<Color>(Colors.transparent),
      cells: [
        DataCell(Text((index + 1).toString())),
        DataCell(
          Text(
            productsStock[index].name ?? "No name",
          ),
        ),
        DataCell(
          Text(
            "#${productsStock[index].code}",
          ),
        ),
        DataCell(
          Text(
            ((productsStock[index].stok?.totalAmount ?? 0) -
                    (productsStock[index].stok?.safetyStock ?? 0))
                .toString(),
            style: appStyle(
                size: 12,
                color: (productsStock[index].stok?.totalAmount ?? 0) -
                            (productsStock[index].stok?.safetyStock ?? 0) <=
                        (productsStock[index].stok?.reorderPoint ?? 0)
                    ? Colors.red
                    : mainBlack,
                fw: FontWeight.w600),
          ),
        ),
        DataCell(
          Text(
            (productsStock[index].stok?.safetyStock ?? 0).toString(),
          ),
        ),
        DataCell(
          Text(
            (productsStock[index].stok?.reorderPoint ?? 0).toString(),
          ),
        ),
        DataCell(
          Text(
            (productsStock[index].stok?.createdAt ?? DateTime.now())
                .formatDateTable(),
          ),
        ),
        DataCell(
          Text(
            (productsStock[index].stok?.updatedAt ?? DateTime.now())
                .formatDateTable(),
          ),
        ),
        DataCell(Row(
          children: [
            GestureDetector(
              onTap: () {
                ref
                    .read(productCreationSelectionNotifierProvider.notifier)
                    .initializeSelections(
                        sizes: productsStock[index]
                            .produkSizes
                            .map((e) => e.name)
                            .toList(),
                        colors: productsStock[index].produkColors.map((e) {
                          return {
                            "name": e.name,
                            "imagePath": e.produkColorImageUrl,
                          };
                        }).toList(),
                        categories: productsStock[index]
                            .produkCategories
                            .map((e) => e.name)
                            .toList());

                Routemaster.of(context).push(
                    '/internal-dashboard/produkstok/edit-produk/${productsStock[index].id}');
              },
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.greenAccent.shade400,
                elevation: 2,
                child: const Padding(
                  padding: EdgeInsets.all(4.0),
                  child: Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ),
          ],
        )),
      ],
    );
  }
}
