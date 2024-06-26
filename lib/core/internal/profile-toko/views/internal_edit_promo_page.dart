import 'dart:async';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/providers/promo_item_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/providers/promo_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/viewmodels/promo_viewmodel.dart';
import 'package:tugas_akhir_project/models/promo.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/list_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/date_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/disabled_form_field_widget.dart';

class InternalEditPromoPage extends ConsumerStatefulWidget {
  const InternalEditPromoPage({super.key});

  @override
  ConsumerState<InternalEditPromoPage> createState() =>
      _InternalEditPromoPageState();
}

class _InternalEditPromoPageState extends ConsumerState<InternalEditPromoPage> {
  final _deliveredAtController = TextEditingController();
  final _deliveryTimeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late double _value;
  Timer? _debounce;
  bool initializeFirst = true;

  void initializeFields(Promo promo) {
    _deliveredAtController.value = _deliveredAtController.value
        .copyWith(text: promo.expiredAt?.formatDate());
    _value = (promo.discountPercent ?? 0).toDouble();
    // _deliveryTimeController.text =
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _deliveredAtController.dispose();
    _deliveryTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(promoViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Promo berhasil diedit!",
            onOkPress: () {
              if (context.mounted) {
                ref.invalidate(fetchPromoProvider);
                Routemaster.of(context).pop();
              }
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: (state.error as ResponseAPIError).errorMessage,
            onOkPress: () {
              
            });
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Permintaan jaringan telah terjadi!",
            onOkPress: () {
              
            });
      } else if (state is AsyncError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Terjadi kesalahan yang tidak diketahui",
            onOkPress: () {
              
            });
      }
    });

    //harusnya fetch promo yang tidak sedang ongoing
    final selectedPromoItem = ref.watch(promoItemSelectionNotifierProvider);
    final selectedPromo = ref.watch(promoSelectionNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Promo",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ref.watch(promoViewModelProvider).when(
              data: (data) {
                if (initializeFirst) {
                  initializeFields(selectedPromo!);
                  initializeFirst = false;
                }

                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(children: [
                        const TopSectionAuth(
                            name: "Edit Promo",
                            description:
                                "Konfigurasikan promo yang telah Anda masukkan",
                            isAvatarNeeded: false),
                        SizedBox(height: 20.h),
                        Card(
                          surfaceTintColor: Colors.white,
                          elevation: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ExpansionTile(
                                initiallyExpanded: true,
                                tilePadding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 5),
                                title: Text(
                                  "Produk yang Dipilih",
                                  style: appStyle(
                                      size: 18,
                                      color: mainBlack,
                                      fw: FontWeight.w600),
                                ),
                                children: [
                                  Builder(builder: (context) {
                                    if (selectedPromoItem != null) {
                                      return Column(
                                        children: [
                                          ListTile(
                                            onTap: () {
                                            },
                                            shape:
                                                const RoundedRectangleBorder(),
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 5),
                                            title: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Stok: ${selectedPromoItem.stok?.totalAmount ?? 0}",
                                                    style: appStyle(
                                                      size: 14,
                                                      color: mainBlack,
                                                      fw: FontWeight.w600,
                                                    ),
                                                  ),
                                                  SizedBox(height: 5.h),
                                                  Row(children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          BorderRadius
                                                              .circular(10),
                                                      child: Image.network(
                                                          selectedPromoItem
                                                              .produkGlobalImages
                                                              .first
                                                              .globalImageUrl,
                                                          fit: BoxFit.contain,
                                                          height: 70.h,
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
                                                              selectedPromoItem
                                                                  .name!,
                                                              maxLines: 2,
                                                              style: appStyle(
                                                                  size: 16,
                                                                  color:
                                                                      mainBlack,
                                                                  fw: FontWeight
                                                                      .w600)),
                                                          Text(
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            "Ukuran: ${selectedPromoItem.produkSizes.map((e) => e.name).toList().getConcatenatedList()}",
                                                            style: appStyle(
                                                              size: 12,
                                                              color:
                                                                  mainBlack,
                                                              fw: FontWeight
                                                                  .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            "Warna: ${selectedPromoItem.produkColors.map((e) => e.name).toList().getConcatenatedList()}",
                                                            style: appStyle(
                                                              size: 12,
                                                              color:
                                                                  mainBlack,
                                                              fw: FontWeight
                                                                  .w500,
                                                            ),
                                                          ),
                                                          Text(
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            PriceFormatter
                                                                .getFormattedValue(
                                                                    selectedPromoItem
                                                                            .price ??
                                                                        0),
                                                            style: appStyle(
                                                              size: 16,
                                                              color:
                                                                  mainBlack,
                                                              fw: FontWeight
                                                                  .bold,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ]),
                                                  SizedBox(height: 5.h),
                                                ]),
                                          ),
                                        ],
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  }),
                                  const Divider(),
                                  Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 20, 15),
                                    child: Column(children: [
                                      InkWell(
                                        borderRadius: BorderRadius.circular(40),
                                        onTap: () {},
                                        child: Material(
                                          borderRadius:
                                              BorderRadius.circular(40),
                                          elevation: 2,
                                          surfaceTintColor: Colors.red,
                                          child: Padding(
                                            padding: const EdgeInsets.all(15.0),
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Icon(
                                                      AntIcons.plusCircleFilled,
                                                      size: 25),
                                                  SizedBox(width: 5.w),
                                                  GestureDetector(
                                                    onTap: () => Routemaster.of(
                                                            context)
                                                        .push(
                                                            '/internal-account/profile-toko/promosi/edit/item'),
                                                    child: Text(
                                                      "Pilih Produk",
                                                      style: appStyle(
                                                          size: 16,
                                                          color: mainBlack,
                                                          fw: FontWeight.w500),
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ),
                                      )
                                    ]),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              "Jumlah Diskon",
                              style: appStyle(
                                size: 18,
                                color: mainBlack,
                                fw: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        SfSlider(
                          min: 0.0,
                          stepSize: 1,
                          max: 120.0,
                          value: _value,
                          interval: 20,
                          showTicks: false,
                          showLabels: true,
                          enableTooltip: true,
                          minorTicksPerInterval: 1,
                          onChanged: (dynamic value) {
                            if (_debounce?.isActive ?? false) {
                              _debounce?.cancel();
                            }
                            _debounce =
                                Timer(const Duration(milliseconds: 300), () {
                              setState(() {
                                _value = value;
                              });
                            });
                          },
                        ),
                        SizedBox(height: 20.h),
                        DateCustomTextField(
                          hintText: "Pilih tanggal akhir promo",
                          controller: _deliveredAtController,
                          minTime: DateTime.now().add(const Duration(hours: 1)),
                          labelText: "Waktu Berakhir",
                          validator: (value) {
                            if (!(value!.isNotEmpty && value.length > 6)) {
                              return "Format nama kategori produk tidak valid. Harap masukkan nama kategori yang valid.";
                            } else {
                              return null;
                            }
                          },
                          onChangedDate: (date) {
                            setState(() {
                              _deliveredAtController.value =
                                  _deliveredAtController.value
                                      .copyWith(text: date.formatDate());
                            });
                          },
                        ),
                        if (_deliveredAtController.text != "")
                          DisableCustomTextField(
                            key: _deliveredAtController.text != ""
                                ? Key(DateTimeHourMin.durationBetween(
                                    DateTime.now(),
                                    DateTimeHourMin
                                        .getUnformattedValueDaysHourMin(
                                            _deliveredAtController.text)))
                                : null,
                            labelText: "Durasi Promo",
                            defaultValue: "0",
                            value: _deliveredAtController.text != ""
                                ? DateTimeHourMin.durationBetween(
                                    DateTime.now(),
                                    DateTimeHourMin
                                        .getUnformattedValueDaysHourMin(
                                            _deliveredAtController.text))
                                : null,
                            textEditingController: _deliveryTimeController,
                          ),
                        SizedBox(height: 10.h),
                        if (selectedPromoItem != null) ...[
                          Material(
                            elevation: 5,
                            borderRadius: BorderRadius.circular(10),
                            child: Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(15, 15, 15, 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Ringkasan Diskon",
                                      style: appStyle(
                                          size: 15,
                                          color: mainBlack,
                                          fw: FontWeight.w600)),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      Text(
                                        "Harga Sebelum Diskon",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        PriceFormatter.getFormattedValue(
                                            selectedPromoItem.price ?? 0),
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10.h),
                                  Row(
                                    children: [
                                      Text(
                                        "Diskon (${_value.toInt()}% OFF)",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                      const Spacer(),
                                      Text(
                                        "- ${PriceFormatter.getFormattedValue((selectedPromoItem.price ?? 0) * (_value.toInt() / 100))}",
                                        style: appStyle(
                                            size: 14,
                                            color: mainBlack,
                                            fw: FontWeight.w500),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 5.h),
                                  Divider(color: Colors.black.withOpacity(0.5)),
                                  SizedBox(height: 5.h),
                                  Row(
                                    children: [
                                      Text(
                                        "Harga Setelah Diskon",
                                        style: appStyle(
                                            size: 15,
                                            color: mainBlack,
                                            fw: FontWeight.bold),
                                      ),
                                      const Spacer(),
                                      Text(
                                        PriceFormatter.getFormattedValue(
                                            (selectedPromoItem.price ?? 0) -
                                                (selectedPromoItem.price ?? 0) *
                                                    (_value.toInt() / 100)),
                                        style: appStyle(
                                            size: 15,
                                            color: mainBlack,
                                            fw: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 30.h),
                          ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate() &&
                                  _deliveredAtController.text != "" &&
                                  _deliveryTimeController.text != "" &&
                                  selectedPromo != null) {
                                ref
                                    .read(promoViewModelProvider.notifier)
                                    .editPromo(
                                        produkId: selectedPromoItem.id!,
                                        expiredAt: DateTimeHourMin
                                                .getUnformattedValueMonthDateYear(
                                                    _deliveredAtController.text)
                                            .toIso8601String(),
                                        discountPercent: _value.toInt(),
                                        promoId: selectedPromo.id)
                                    .then((value) {});
                              }
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
                              "Confirm",
                              style: appStyle(
                                  size: 16,
                                  color: Colors.white,
                                  fw: FontWeight.w500),
                            ),
                          ),
                        ]
                      ]),
                    ),
                  ),
                );
              },
              error: (error, stackTrace) => const SizedBox.shrink(),
              loading: () => const Center(
                child: CircularProgressIndicator(),
              ),
            ),
      ),
    );
  }
}
