import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/repositories/implementations/produk_stok_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/viewmodels/produk_stok_viewmodel.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/widgets/product_stok_combination_card_widget.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/date_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/disabled_form_field_widget.dart';

import '../../../../utils/errors/api_errors.dart';

class InternalAddStokProdukPage extends ConsumerStatefulWidget {
  const InternalAddStokProdukPage({super.key});

  @override
  ConsumerState<InternalAddStokProdukPage> createState() =>
      _InternalAddStokProdukPageState();
}

//wrap in future

class _InternalAddStokProdukPageState
    extends ConsumerState<InternalAddStokProdukPage> {
  final _issuedFromController = TextEditingController();
  final _deliveredAtController = TextEditingController();
  final _deliveryTimeController = TextEditingController();
  final _totalAmountController = TextEditingController();
  String testValue = "0";

  @override
  void dispose() {
    _issuedFromController.dispose();
    _deliveredAtController.dispose();
    _deliveryTimeController.dispose();
    _totalAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productSaved = ref.watch(productSavedProvider);
    final productStok = ref.watch(productStokNotifierProvider);
    final formKey = GlobalKey<FormState>();

    ref.listen(productStokNotifierProvider, (previous, next) {
      setState(() {
        if (next.isEmpty) {
          _issuedFromController.text = "";
          _deliveredAtController.text = "";
          _totalAmountController.text = "";
        }
      });
    });

    ref.listen(produkStokViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
          context: context,
          title: "Sukses",
          info: DialogType.success,
          animType: AnimType.scale,
          desc: "Berhasil memasukkan produk dan menambahkan stok ke produk!",
          onOkPress: () {
            ref.invalidate(fetchProductsTable);
            Routemaster.of(context).replace('/internal-dashboard/produkstok');
          },
        );
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: "Telah terjadi kesalahan respons!",
          onOkPress: () {
            Routemaster.of(context).replace('/internal-dashboard/produkstok');
          },
        );
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: "Permintaan jaringan telah terjadi!",
          onOkPress: () {
            Routemaster.of(context).replace('/internal-dashboard/produkstok');
          },
        );
      } else if (state is AsyncError) {
        showPopupModal(
          context: context,
          title: "Peringatan",
          info: DialogType.error,
          animType: AnimType.scale,
          desc: (state.error as ApiError).message,
          onOkPress: () {
            Routemaster.of(context).replace('/internal-dashboard/produkstok');
          },
        );
      }
    });

    testValue = productStok.isEmpty
        ? "0"
        : productStok
            .map((e) => e.stokAmount)
            .toList()
            .reduce((value, element) => value + element)
            .toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambahkan Stok",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ref.watch(produkStokViewModelProvider).when(
              data: (data) {
                return SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(children: [
                        const TopSectionAuth(
                            name: "Tambahkan Stok",
                            description:
                                "Tambahkan stok dari produk yang telah Anda masukkan",
                            isAvatarNeeded: false),
                        SizedBox(height: 20.h),
                        ProdukStokCombinationCard(
                            produkStok: productStok,
                            titleName: "Detail Stok Produk",
                            buttonDescription: "Konfigurasi Detail Stok",
                            buttonDestination:
                                '/internal-dashboard/produkstok/input-produk/add-stok/add-details',
                            routeDestination:
                                '/internal-dashboard/produkstok/input-produk/add-stok/edit-details'),
                        SizedBox(height: 20.h),
                        DateCustomTextField(
                          maxTime: DateTime.now(),
                          hintText: "Pilih tanggal dipesan",
                          controller: _issuedFromController,
                          labelText: "Tanggal Dipesan",
                          onChangedDate: (date) {
                            setState(() {
                              _issuedFromController.value =
                                  _issuedFromController.value.copyWith(
                                text: date.formatDate(),
                              );
                              if (_deliveredAtController.text != "" &&
                                  DateTimeHourMin
                                          .getUnformattedValueMonthDateYear(
                                              _issuedFromController.text)
                                      .isAfter(
                                    DateTimeHourMin
                                        .getUnformattedValueMonthDateYear(
                                      _deliveredAtController.text,
                                    ),
                                  )) {
                                _deliveredAtController.text = "";
                              }
                            });
                          },
                        ),
                        SizedBox(height: 20.h),
                        DateCustomTextField(
                          hintText: "Pilih tanggal diterima",
                          controller: _deliveredAtController,
                          isDisabled: _issuedFromController.text == "",
                          minTime: _issuedFromController.value.text != ""
                              ? DateTimeHourMin
                                  .getUnformattedValueMonthDateYear(
                                      _issuedFromController.value.text)
                              : null,
                          maxTime: DateTime.now(),
                          labelText: "Diterima Pada",
                          validator: (value) {
                            if (!(value!.isNotEmpty && value.length > 6)) {
                              return "Format nama kategori katalog produk tidak valid. Harap masukkan nama kategori yang valid.";
                            } else {
                              return null;
                            }
                          },
                          onChangedDate: (date) {
                            setState(() {
                              _deliveredAtController.value =
                                  _deliveredAtController.value.copyWith(
                                text: date.formatDate(),
                              );
                            });
                          },
                        ),
                        SizedBox(height: 20.h),
                        if (_issuedFromController.text != "" &&
                            _deliveredAtController.text != "")
                          DisableCustomTextField(
                            key: _issuedFromController.text != "" &&
                                    _deliveredAtController.text != ""
                                ? Key(DateTimeHourMin.daysBetween(
                                        DateTimeHourMin
                                            .getUnformattedValueMonthDateYear(
                                                _issuedFromController.text),
                                        DateTimeHourMin
                                            .getUnformattedValueMonthDateYear(
                                                _deliveredAtController.text))
                                    .toString())
                                : null,
                            labelText: "Waktu Pengiriman (hari)",
                            //calculation value here
                            defaultValue: "0",
                            value: _issuedFromController.text != "" &&
                                    _deliveredAtController.text != ""
                                ? DateTimeHourMin.daysBetween(
                                        DateTimeHourMin
                                            .getUnformattedValueMonthDateYear(
                                                _issuedFromController.text),
                                        DateTimeHourMin
                                            .getUnformattedValueMonthDateYear(
                                                _deliveredAtController.text))
                                    .toString()
                                : null,
                            textEditingController: _deliveryTimeController,
                          ),
                        SizedBox(height: 20.h),
                        DisableCustomTextField(
                          key: Key(testValue.toString()),
                          labelText: "Total Jumlah",
                          defaultValue: "0",
                          //calculation value here
                          value: testValue,
                          textEditingController: _totalAmountController,
                        ),
                        SizedBox(height: 20.h),
                        ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState!.validate() &&
                                _totalAmountController.text.isNotEmpty &&
                                _deliveredAtController.text.isNotEmpty &&
                                _deliveryTimeController.text.isNotEmpty &&
                                _issuedFromController.text.isNotEmpty &&
                                productSaved != null &&
                                productStok.isNotEmpty) {
                              ref
                                  .read(produkStokViewModelProvider.notifier)
                                  .inputProduk(
                                      produkStok: productStok,
                                      productSaved: productSaved,
                                      issuedAt: DateTimeHourMin
                                              .getUnformattedValueMonthDateYear(
                                                  _issuedFromController.text)
                                          .toIso8601String(),
                                      deliveredAt: DateTimeHourMin
                                              .getUnformattedValueMonthDateYear(
                                                  _deliveredAtController.text)
                                          .toIso8601String(),
                                      deliveryTime: int.parse(
                                          _deliveryTimeController.text),
                                      totalAmount: int.parse(
                                          _totalAmountController.text))
                                  .then((_) {});
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 5,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 20),
                            minimumSize: const Size.fromHeight(50),
                            backgroundColor: Colors.purple,
                          ),
                          child: Text(
                            "Tambahkan Stok",
                            style: appStyle(
                                size: 16,
                                color: Colors.white,
                                fw: FontWeight.w500),
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
              error: (error, stackTrace) =>
                  Center(child: Text(error.toString())),
              loading: () => const Center(child: CircularProgressIndicator()))),
    );
  }
}
