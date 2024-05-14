// ignore_for_file: sized_box_for_whitespace

import 'dart:async';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/laporanbarang/repositories/implementations/internal_laporanbarang_repository_impl.dart';
import 'package:tugas_akhir_project/models/laporanbarangkeluar.dart';
import 'package:tugas_akhir_project/models/laporanbarangmasuk.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/integer_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_chart_widget.dart';
import 'package:tugas_akhir_project/widgets/label_none_form_field_widget.dart';

class InternalLaporanBarangPage extends ConsumerStatefulWidget {
  const InternalLaporanBarangPage({super.key});

  @override
  ConsumerState<InternalLaporanBarangPage> createState() =>
      _InternalLaporanBarangPageState();
}

class _InternalLaporanBarangPageState
    extends ConsumerState<InternalLaporanBarangPage>
    with TickerProviderStateMixin {
  final _laporanBarangMasukNameController = TextEditingController();
  final _laporanBarangKeluarNameController = TextEditingController();
  String? laporanBarangMasukselectedDropdownSelection = "Semua";
  String? laporanBarangKeluarselectedDropdownSelection = "Semua";
  late LaporanBarangMasukTableDataSource _laporanBarangMasukSource;
  late LaporanBarangKeluarTableDataSource _laporanBarangKeluarSource;
  PaginatorController? _controller;
  bool _initialized = false;
  bool _sortAscending = true;
  Timer? _debounce;
  int? _sortColumnIndex;
  late final TabController _tabController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _laporanBarangMasukSource =
          LaporanBarangMasukTableDataSource(context, []);
      _controller = PaginatorController();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _debounce?.cancel();
    _laporanBarangMasukNameController.dispose();
    _laporanBarangKeluarNameController.dispose();
    _laporanBarangMasukSource.dispose();
    _laporanBarangKeluarSource.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void sortLaporanBarangMasuk<T>(
    Comparable<T> Function(LaporanBarangMasuk d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _laporanBarangMasukSource.sort(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  void sortLaporanBarangKeluar<T>(
    Comparable<T> Function(LaporanBarangKeluar d) getField,
    int columnIndex,
    bool ascending,
  ) {
    _laporanBarangKeluarSource.sort(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  List<LaporanBarangMasuk> filterLaporanBarangMasuk(
      {required String searchQuery,
      String? selectedDropdownSelection,
      required List<LaporanBarangMasuk> laporanBarangMasuk}) {
    List<LaporanBarangMasuk> filteredLaporanBarangMasukList = [];
    final now = DateTime.now();

    switch (selectedDropdownSelection) {
      case "Hari Ini":
        filteredLaporanBarangMasukList = laporanBarangMasuk.where((element) {
          return element.deliveredAt?.year == now.year &&
              element.deliveredAt?.month == now.month &&
              element.deliveredAt?.day == now.day;
        }).toList();
      case "Minggu Ini":
        DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
        filteredLaporanBarangMasukList = laporanBarangMasuk.where((element) {
          return (element.deliveredAt ?? now)
                  .isAfter(firstDayOfWeek.subtract(const Duration(days: 1))) &&
              (element.deliveredAt ?? now)
                  .isBefore(firstDayOfWeek.add(const Duration(days: 7)));
        }).toList();
      case "Bulan Ini":
        filteredLaporanBarangMasukList = laporanBarangMasuk.where((element) {
          return element.deliveredAt?.year == now.year &&
              element.deliveredAt?.month == now.month;
        }).toList();
      case "Tahun Ini":
        filteredLaporanBarangMasukList = laporanBarangMasuk.where((element) {
          return element.deliveredAt?.year == now.year;
        }).toList();
      default:
        filteredLaporanBarangMasukList = laporanBarangMasuk;
        break;
    }

    return searchQuery == ""
        ? filteredLaporanBarangMasukList
        : filteredLaporanBarangMasukList
            .where((element) =>
                RegExp(searchQuery, caseSensitive: false)
                    .hasMatch(element.produks.first.name ?? "") ||
                RegExp(searchQuery, caseSensitive: false)
                    .hasMatch(element.produks.first.code ?? ""))
            .toList();
  }

  List<LaporanBarangKeluar> filterLaporanBarangKeluar(
      {required String searchQuery,
      String? selectedDropdownSelection,
      required List<LaporanBarangKeluar> laporanBarangKeluar}) {
    List<LaporanBarangKeluar> filteredLaporanBarangKeluarList = [];
    final now = DateTime.now();

    switch (selectedDropdownSelection) {
      case "Hari Ini":
        filteredLaporanBarangKeluarList = laporanBarangKeluar.where((element) {
          return element.createdAt?.year == now.year &&
              element.createdAt?.month == now.month &&
              element.createdAt?.day == now.day;
        }).toList();
        break;
      case "Minggu Ini":
        DateTime firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
        filteredLaporanBarangKeluarList = laporanBarangKeluar.where((element) {
          return (element.createdAt ?? now)
                  .isAfter(firstDayOfWeek.subtract(const Duration(days: 1))) &&
              (element.createdAt ?? now)
                  .isBefore(firstDayOfWeek.add(const Duration(days: 7)));
        }).toList();
        break;
      case "Bulan Ini":
        filteredLaporanBarangKeluarList = laporanBarangKeluar.where((element) {
          return element.createdAt?.year == now.year &&
              element.createdAt?.month == now.month;
        }).toList();
        break;
      case "Tahun Ini":
        filteredLaporanBarangKeluarList = laporanBarangKeluar.where((element) {
          return element.createdAt?.year == now.year;
        }).toList();
        break;
      default:
        filteredLaporanBarangKeluarList = laporanBarangKeluar;
        break;
    }

    return searchQuery == ""
        ? filteredLaporanBarangKeluarList
        : filteredLaporanBarangKeluarList
            .where((element) => (RegExp(searchQuery, caseSensitive: false)
                    .hasMatch(element.produks.first.name ?? "") ||
                RegExp(searchQuery, caseSensitive: false)
                    .hasMatch(element.produks.first.code ?? "")))
            .toList();
  }

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Laporan Barang",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: ref.watch(fetchLaporanBarangInformationProvider).maybeWhen(
            data: (data) {
              return data.generalInformation.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (generalInformation) {
                return data.laporanBarangMasuk.match(
                    (l) => Center(
                        child: Text(l.message,
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))), (laporanBarangMasuk) {
                  final filteredLaporanBarangMasuk = filterLaporanBarangMasuk(
                      searchQuery: _laporanBarangMasukNameController.text,
                      laporanBarangMasuk: laporanBarangMasuk,
                      selectedDropdownSelection:
                          laporanBarangMasukselectedDropdownSelection);
                  _laporanBarangMasukSource = LaporanBarangMasukTableDataSource(
                      context, filteredLaporanBarangMasuk);
                  return data.laporanBarangKeluar.match(
                      (l) => Center(
                          child: Text(l.message,
                              style: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.w600))),
                      (laporanBarangKeluar) {
                    final filteredLaporanBarangKeluar =
                        filterLaporanBarangKeluar(
                            searchQuery:
                                _laporanBarangKeluarNameController.text,
                            laporanBarangKeluar: laporanBarangKeluar,
                            selectedDropdownSelection:
                                laporanBarangKeluarselectedDropdownSelection);
                    _laporanBarangKeluarSource =
                        LaporanBarangKeluarTableDataSource(
                            context, filteredLaporanBarangKeluar);
                    return SafeArea(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10),
                          child: Column(children: [
                            const TopSectionAuth(
                                name: "Laporan Barang",
                                description:
                                    "Lihat laporan barang keluar dan masuk dari produk",
                                isAvatarNeeded: false),
                            const SizedBox(height: 20),
                            Card(
                              surfaceTintColor: Colors.white,
                              elevation: 5,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10.0, horizontal: 20),
                                child: Column(children: [
                                  IntrinsicHeight(
                                    child: Row(children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text("General Information:",
                                                style: appStyle(
                                                    size: 20,
                                                    color: mainBlack,
                                                    fw: FontWeight.w600)),
                                            const SizedBox(height: 20),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(children: [
                                                        Text(
                                                            ((generalInformation[
                                                                        "getTotalStockAmount"] ??
                                                                    0) as int)
                                                                .formatOrderCount(),
                                                            style: appStyle(
                                                                size: 20,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .bold)),
                                                        Text("Total \n Stock",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: appStyle(
                                                                size: 16,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w500))
                                                      ]),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(children: [
                                                        Text(
                                                            ((generalInformation[
                                                                        "totalAmountBarangMasuk"] ??
                                                                    0) as int)
                                                                .formatOrderCount(),
                                                            style: appStyle(
                                                                size: 20,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .bold)),
                                                        Text("Barang \n Masuk",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: appStyle(
                                                                size: 16,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w500))
                                                      ]),
                                                    ),
                                                  ),
                                                  Flexible(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Column(children: [
                                                        Text(
                                                            ((generalInformation[
                                                                        "totalAmountBarangKeluar"] ??
                                                                    0) as int)
                                                                .formatOrderCount(),
                                                            style: appStyle(
                                                                size: 20,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .bold)),
                                                        Text("Barang \n Keluar",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: appStyle(
                                                                size: 16,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w500))
                                                      ]),
                                                    ),
                                                  )
                                                ]),
                                            const SizedBox(height: 15),
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ),
                                ]),
                              ),
                            ),
                            const SizedBox(height: 30),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Text(
                                    "Informasi Laporan Barang",
                                    style: appStyle(
                                        size: 20,
                                        color: mainBlack,
                                        fw: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            TabBar(
                              physics: const NeverScrollableScrollPhysics(),
                              isScrollable: false,
                              splashFactory: NoSplash.splashFactory,
                              overlayColor:
                                  MaterialStateProperty.resolveWith<Color?>(
                                      (Set<MaterialState> states) {
                                // Use the default focused overlay color
                                return states.contains(MaterialState.focused)
                                    ? null
                                    : Colors.transparent;
                              }),
                              padding: const EdgeInsets.all(0),
                              indicatorSize: TabBarIndicatorSize.tab,
                              // dividerColor: Colors.transparent,
                              indicatorColor: Colors.transparent,
                              controller: _tabController,
                              labelColor: Colors.purple,
                              labelStyle: appStyle(
                                  size: 16,
                                  color: mainBlack,
                                  fw: FontWeight.bold),
                              unselectedLabelColor:
                                  Colors.black.withOpacity(0.2),
                              tabs: const [
                                Tab(text: "Masuk"),
                                Tab(text: "Keluar")
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: SizedBox(
                                height: 500,
                                child: TabBarView(
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: _tabController,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 150,
                                              child: CustomDropdownChart(
                                                  values: const [
                                                    "Semua",
                                                    "Hari Ini",
                                                    "Minggu Ini",
                                                    "Bulan Ini",
                                                    "Tahun Ini"
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      laporanBarangMasukselectedDropdownSelection =
                                                          value;
                                                    });
                                                  }),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        NoLabelCustomTextField(
                                          hintText:
                                              "Search name/code produk...",
                                          controller:
                                              _laporanBarangMasukNameController,
                                          onChanged: (value) {
                                            if (_debounce?.isActive ?? false) {
                                              _debounce?.cancel();
                                            }
                                            _debounce = Timer(
                                                const Duration(
                                                    milliseconds: 200), () {
                                              setState(() {});
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: PaginatedDataTable2(
                                            renderEmptyRowsInTheEnd: false,
                                            empty: Center(
                                              child: Text(
                                                  "Tidak ada laporan barang masuk ${laporanBarangMasukselectedDropdownSelection == "Semua" ? "" : laporanBarangMasukselectedDropdownSelection?.toLowerCase()}",
                                                  style: appStyle(
                                                      size: 13,
                                                      color: mainBlack,
                                                      fw: FontWeight.w600)),
                                            ),
                                            autoRowsToHeight: true,
                                            wrapInCard: false,
                                            fit: FlexFit.loose,
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
                                            columnSpacing: 0,
                                            minWidth: 800,
                                            columns: [
                                              const DataColumn2(
                                                fixedWidth: 50,
                                                label: Text('No.'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label: const Text('Nama'),
                                                size: ColumnSize.L,
                                                onSort:
                                                    (columnIndex, ascending) =>
                                                        sortLaporanBarangMasuk(
                                                            (d) =>
                                                                d.produks.first
                                                                    .name ??
                                                                "",
                                                            columnIndex,
                                                            ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text('Code'),
                                                size: ColumnSize.L,
                                                onSort:
                                                    (columnIndex, ascending) =>
                                                        sortLaporanBarangMasuk(
                                                            (d) =>
                                                                d.produks.first
                                                                    .code ??
                                                                "",
                                                            columnIndex,
                                                            ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text('Jumlah'),
                                                size: ColumnSize.S,
                                                onSort: (columnIndex,
                                                        ascending) =>
                                                    sortLaporanBarangMasuk<
                                                            String>(
                                                        (d) => d.amount ?? "",
                                                        columnIndex,
                                                        ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text('Issued At'),
                                                size: ColumnSize.M,
                                                onSort:
                                                    (columnIndex, ascending) =>
                                                        sortLaporanBarangMasuk<
                                                                DateTime>(
                                                            (d) =>
                                                                d.issuedFrom ??
                                                                DateTime.now(),
                                                            columnIndex,
                                                            ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text('Dlv At'),
                                                size: ColumnSize.M,
                                                onSort:
                                                    (columnIndex, ascending) =>
                                                        sortLaporanBarangMasuk<
                                                                DateTime>(
                                                            (d) =>
                                                                d.deliveredAt ??
                                                                DateTime.now(),
                                                            columnIndex,
                                                            ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text(
                                                    'Dlv Time (hari)'),
                                                size: ColumnSize.M,
                                                onSort: (columnIndex,
                                                        ascending) =>
                                                    sortLaporanBarangMasuk<
                                                            String>(
                                                        (d) => d.deliveryTime
                                                            .toString(),
                                                        columnIndex,
                                                        ascending),
                                              ),
                                            ],
                                            source: _laporanBarangMasukSource,
                                          ),
                                        ),
                                        // const SizedBox(height: 20),
                                        // ElevatedButton(
                                        //   onPressed: () {
                                        //     Routemaster.of(context).push(
                                        //         '/internal-dashboard/laporan-barang/add-masuk');
                                        //   },
                                        //   style: ElevatedButton.styleFrom(
                                        //     elevation: 5,
                                        //     padding: const EdgeInsets.symmetric(
                                        //         horizontal: 15, vertical: 20),
                                        //     minimumSize:
                                        //         const Size.fromHeight(50),
                                        //     backgroundColor: Colors.greenAccent,
                                        //   ),
                                        //   child: Text(
                                        //     "Add Laporan Barang Masuk",
                                        //     style: appStyle(
                                        //         size: 16,
                                        //         color: Colors.white,
                                        //         fw: FontWeight.w500),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 150,
                                              child: CustomDropdownChart(
                                                  values: const [
                                                    "Semua",
                                                    "Hari Ini",
                                                    "Minggu Ini",
                                                    "Bulan Ini",
                                                    "Tahun Ini"
                                                  ],
                                                  onChanged: (value) {
                                                    setState(() {
                                                      laporanBarangKeluarselectedDropdownSelection =
                                                          value;
                                                    });
                                                  }),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        NoLabelCustomTextField(
                                          hintText: "Search nama produk...",
                                          controller:
                                              _laporanBarangKeluarNameController,
                                          onChanged: (value) {
                                            if (_debounce?.isActive ?? false) {
                                              _debounce?.cancel();
                                            }
                                            _debounce = Timer(
                                                const Duration(
                                                    milliseconds: 200), () {
                                              setState(() {});
                                            });
                                          },
                                        ),
                                        Expanded(
                                          child: PaginatedDataTable2(
                                            renderEmptyRowsInTheEnd: false,
                                            empty: Center(
                                              child: Text(
                                                  "Tidak ada laporan barang keluar ${laporanBarangKeluarselectedDropdownSelection == "Semua" ? "" : laporanBarangKeluarselectedDropdownSelection?.toLowerCase()}",
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
                                            columnSpacing: 0,
                                            minWidth: 700,
                                            columns: [
                                              const DataColumn2(
                                                fixedWidth: 50,
                                                label: Text('No.'),
                                                size: ColumnSize.S,
                                              ),
                                              DataColumn2(
                                                label: const Text('Nama'),
                                                size: ColumnSize.L,
                                                onSort:
                                                    (columnIndex, ascending) =>
                                                        sortLaporanBarangKeluar(
                                                            (d) =>
                                                                d.produks.first
                                                                    .name ??
                                                                "",
                                                            columnIndex,
                                                            ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text('Code'),
                                                size: ColumnSize.L,
                                                onSort:
                                                    (columnIndex, ascending) =>
                                                        sortLaporanBarangMasuk(
                                                            (d) =>
                                                                d.produks.first
                                                                    .code ??
                                                                "",
                                                            columnIndex,
                                                            ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text('Jumlah'),
                                                size: ColumnSize.S,
                                                onSort: (columnIndex,
                                                        ascending) =>
                                                    sortLaporanBarangKeluar<
                                                            String>(
                                                        (d) => d.amount ?? "",
                                                        columnIndex,
                                                        ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text('Order Code'),
                                                size: ColumnSize.M,
                                                onSort: (columnIndex,
                                                        ascending) =>
                                                    sortLaporanBarangKeluar<
                                                            String>(
                                                        (d) =>
                                                            d.order?.code ?? "",
                                                        columnIndex,
                                                        ascending),
                                              ),
                                              DataColumn2(
                                                label: const Text('Created At'),
                                                size: ColumnSize.M,
                                                onSort:
                                                    (columnIndex, ascending) =>
                                                        sortLaporanBarangKeluar<
                                                                DateTime>(
                                                            (d) =>
                                                                d.createdAt ??
                                                                DateTime.now(),
                                                            columnIndex,
                                                            ascending),
                                              ),
                                            ],
                                            source: _laporanBarangKeluarSource,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ]),
                        ),
                      ),
                    );
                  });
                });
              });
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            orElse: () => const SizedBox.shrink()));
  }
}

class LaporanBarangMasukTableDataSource extends DataTableSource {
  final BuildContext context;
  List<LaporanBarangMasuk> enteredLaporanBarangMasuk = [];
  // bool hasRowTaps = false;
  // bool hasRowHeightOverrides = false;
  final _selectedCount = 0;
  // bool hasZebraStripes = false;

  LaporanBarangMasukTableDataSource.empty(this.context) {
    enteredLaporanBarangMasuk = [];
  }

  LaporanBarangMasukTableDataSource(
      this.context, List<LaporanBarangMasuk> fromLaporanBarangMasuk) {
    enteredLaporanBarangMasuk = fromLaporanBarangMasuk;
  }

  void sort<T>(
      Comparable<T> Function(LaporanBarangMasuk d) getField, bool ascending) {
    enteredLaporanBarangMasuk.sort((a, b) {
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
  int get rowCount => enteredLaporanBarangMasuk.length;

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
            enteredLaporanBarangMasuk[index].produks.first.name ?? "No name",
          ),
        ),
        DataCell(
          Text(
            "#${enteredLaporanBarangMasuk[index].produks.first.code}",
          ),
        ),
        DataCell(
          Text(
            enteredLaporanBarangMasuk[index].amount ?? "No name",
          ),
        ),
        DataCell(
          Text(
            enteredLaporanBarangMasuk[index].issuedFrom?.formatDateTable() ??
                "",
          ),
        ),
        DataCell(
          Text(
            enteredLaporanBarangMasuk[index].deliveredAt?.formatDateTable() ??
                "",
          ),
        ),
        DataCell(
          Text(
            enteredLaporanBarangMasuk[index].deliveryTime.toString(),
          ),
        ),
      ],
    );
  }
}

class LaporanBarangKeluarTableDataSource extends DataTableSource {
  final BuildContext context;
  late List<LaporanBarangKeluar> enteredLaporanBarangKeluar;
  // bool hasRowTaps = false;
  // bool hasRowHeightOverrides = false;
  final _selectedCount = 0;
  // bool hasZebraStripes = false;

  LaporanBarangKeluarTableDataSource.empty(this.context) {
    enteredLaporanBarangKeluar = [];
  }

  LaporanBarangKeluarTableDataSource(
      this.context, List<LaporanBarangKeluar> fromLaporanBarangKeluar) {
    enteredLaporanBarangKeluar = fromLaporanBarangKeluar;
  }

  void sort<T>(
      Comparable<T> Function(LaporanBarangKeluar d) getField, bool ascending) {
    enteredLaporanBarangKeluar.sort((a, b) {
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
  int get rowCount => enteredLaporanBarangKeluar.length;

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
            enteredLaporanBarangKeluar[index].produks.first.name ?? "No name",
          ),
        ),
        DataCell(
          Text(
            "#${enteredLaporanBarangKeluar[index].produks.first.code}",
          ),
        ),
        DataCell(
          Text(
            enteredLaporanBarangKeluar[index].amount ?? "No name",
          ),
        ),
        DataCell(
          Text(
            "#${enteredLaporanBarangKeluar[index].order?.code}",
          ),
        ),
        DataCell(
          Text(
            enteredLaporanBarangKeluar[index].createdAt?.formatDateTable() ??
                "",
          ),
        ),
      ],
    );
  }
}
