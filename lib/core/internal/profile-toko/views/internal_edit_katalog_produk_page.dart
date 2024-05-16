import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/providers/katalog_produk_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/viewmodels/katalog_produk_viewmodel.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/date_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/list_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalEditKatalogProdukPage extends ConsumerStatefulWidget {
  final int katalogId;
  const InternalEditKatalogProdukPage(this.katalogId, {super.key});

  @override
  ConsumerState<InternalEditKatalogProdukPage> createState() =>
      _InternalEditKatalogProdukPageState();
}

class _InternalEditKatalogProdukPageState
    extends ConsumerState<InternalEditKatalogProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameKatalogController = TextEditingController();
  bool initializeFirst = true;

  @override
  void dispose() {
    _nameKatalogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final katalogProdukInformation =
        ref.watch(fetchSingleKatalogProdukProvider(widget.katalogId));
    final selectedProduks =
        ref.watch(katalogProdukItemSelectionNotifierProvider);

    ref.listen(katalogProdukViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil mengedit katalog produk!",
            onOkPress: () {
              if (context.mounted) {
                ref.invalidate(fetchKatalogProdukToko);
                Routemaster.of(context).pop();
              }
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Kesalahan respons telah terjadi!",
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
          "Edit Katalog Produk",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: katalogProdukInformation.maybeWhen(
            data: (data) {
              return data.match(
                  (l) => Center(
                      child: Text(l.message,
                          style: appStyle(
                              size: 16,
                              color: mainBlack,
                              fw: FontWeight.w600))), (r) {
                return ref.watch(katalogProdukViewModelProvider).when(
                    data: (data) {
                      if (initializeFirst) {
                        _nameKatalogController.text = r?.name ?? "";
                        initializeFirst = false;
                      }
                      return SingleChildScrollView(
                        child: Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10),
                            child: Column(
                              children: [
                                const TopSectionAuth(
                                    name: "Edit Katalog Produk",
                                    description:
                                        "Konfigurasi katalog produk toko",
                                    isAvatarNeeded: false),
                                SizedBox(height: 20.h),
                                CustomTextField(
                                    hintText:
                                        "Masukkan nama kategori katalog produk",
                                    controller: _nameKatalogController,
                                    labelText: "Nama Kategori",
                                    obscureText: false,
                                    validator: (value) {
                                      if (!(value!.isNotEmpty &&
                                          value.length > 6)) {
                                        return "Format nama kategori katalog produk tidak valid. Silakan masukkan nama kategori yang valid.";
                                      } else {
                                        return null;
                                      }
                                    }),
                                Card(
                                  surfaceTintColor: Colors.white,
                                  elevation: 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ExpansionTile(
                                        initiallyExpanded: true,
                                        tilePadding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 5),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Item Kategori",
                                              style: appStyle(
                                                  size: 18,
                                                  color: mainBlack,
                                                  fw: FontWeight.w600),
                                            ),
                                            if (selectedProduks.isNotEmpty ||
                                                r!.produkList.isNotEmpty)
                                              Text(
                                                "Jumlah: ${(selectedProduks.isNotEmpty && selectedProduks != r?.produkList) ? selectedProduks.length : r?.produkList.length}",
                                                style: appStyle(
                                                    size: 16,
                                                    color: mainBlack,
                                                    fw: FontWeight.w500),
                                              ),
                                          ],
                                        ),
                                        children: [
                                          ListView.builder(
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              itemCount:
                                                  (selectedProduks.isNotEmpty &&
                                                          selectedProduks !=
                                                              r?.produkList)
                                                      ? selectedProduks.length
                                                      : r?.produkList.length,
                                              shrinkWrap: true,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    const Divider(),
                                                    ListTile(
                                                      shape:
                                                          const RoundedRectangleBorder(),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              horizontal: 20,
                                                              vertical: 10),
                                                      title: Column(children: [
                                                        if (((selectedProduks
                                                                            .isNotEmpty &&
                                                                        selectedProduks !=
                                                                            r
                                                                                ?.produkList)
                                                                    ? selectedProduks[
                                                                            index]
                                                                        .promo
                                                                    : r
                                                                        ?.produkList[
                                                                            index]
                                                                        .promo) !=
                                                                null &&
                                                            ((selectedProduks
                                                                            .isNotEmpty &&
                                                                        selectedProduks !=
                                                                            r
                                                                                ?.produkList)
                                                                    ? selectedProduks[index]
                                                                            .promo
                                                                            ?.expiredAt ??
                                                                        DateTime
                                                                            .now()
                                                                    : r
                                                                            ?.produkList[
                                                                                index]
                                                                            .promo
                                                                            ?.expiredAt ??
                                                                        DateTime
                                                                            .now())
                                                                .isAfter(DateTime
                                                                    .now())) ...[
                                                          Row(
                                                            children: [
                                                              const Icon(Icons
                                                                  .discount_outlined),
                                                              SizedBox(
                                                                  width: 5.w),
                                                              Text(
                                                                  "${((selectedProduks.isNotEmpty && selectedProduks != r?.produkList) ? selectedProduks[index].promo?.discountPercent : r?.produkList[index].promo?.discountPercent)}% OFF",
                                                                  style: appStyle(
                                                                      size: 12,
                                                                      color:
                                                                          mainBlack,
                                                                      fw: FontWeight
                                                                          .w600)),
                                                              const Spacer(),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Text(
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    "${DateTimeHourMin.durationBetween(DateTime.now(), (selectedProduks.isNotEmpty && selectedProduks != r?.produkList) ? selectedProduks[index].promo?.expiredAt ?? DateTime.now() : r?.produkList[index].promo?.expiredAt ?? DateTime.now())}",
                                                                    style:
                                                                        appStyle(
                                                                      size: 12,
                                                                      color:
                                                                          mainBlack,
                                                                      fw: FontWeight
                                                                          .w600,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                          SizedBox(height: 5.h),
                                                        ],
                                                        Row(children: [
                                                          ClipRRect(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              child:
                                                                  CachedNetworkImage(
                                                                imageUrl: (selectedProduks
                                                                            .isNotEmpty &&
                                                                        selectedProduks !=
                                                                            r
                                                                                ?.produkList)
                                                                    ? selectedProduks[
                                                                            index]
                                                                        .produkGlobalImages[
                                                                            0]
                                                                        .globalImageUrl
                                                                    : r?.produkList[index].produkGlobalImages[0]
                                                                            .globalImageUrl ??
                                                                        "None",
                                                                height: 70.h,
                                                                width: 70.w,
                                                                imageBuilder:
                                                                    (context,
                                                                            imageProvider) =>
                                                                        Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    shape: BoxShape
                                                                        .rectangle,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    image:
                                                                        DecorationImage(
                                                                      image:
                                                                          imageProvider,
                                                                      fit: BoxFit
                                                                          .contain,
                                                                    ),
                                                                  ),
                                                                ),
                                                                // placeholder: (context,
                                                                //         url) =>
                                                                //     const Center(
                                                                //         child:
                                                                //             CircularProgressIndicator()),
                                                                errorWidget: (context,
                                                                        url,
                                                                        error) =>
                                                                    const Icon(Icons
                                                                        .error),
                                                              )),
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
                                                                    (selectedProduks.isNotEmpty &&
                                                                            selectedProduks !=
                                                                                r
                                                                                    ?.produkList)
                                                                        ? selectedProduks[index].name ??
                                                                            "No name"
                                                                        : r?.produkList[index].name ??
                                                                            "No name",
                                                                    style: appStyle(
                                                                        size:
                                                                            16,
                                                                        color:
                                                                            mainBlack,
                                                                        fw: FontWeight
                                                                            .w600)),
                                                                Text(
                                                                  maxLines: 1,
                                                                  overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                  "Ukuran: ${(selectedProduks.isNotEmpty && selectedProduks != r?.produkList) ? selectedProduks[index].produkSizes.map((e) => e.name).toList().getConcatenatedList() : r?.produkList[index].produkSizes.map((e) => e.name).toList().getConcatenatedList()}",
                                                                  style:
                                                                      appStyle(
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
                                                                  "Warna: ${(selectedProduks.isNotEmpty && selectedProduks != r?.produkList) ? selectedProduks[index].produkColors.map((e) => e.name).toList().getConcatenatedList() : r?.produkList[index].produkColors.map((e) => e.name).toList().getConcatenatedList()}",
                                                                  style:
                                                                      appStyle(
                                                                    size: 12,
                                                                    color:
                                                                        mainBlack,
                                                                    fw: FontWeight
                                                                        .w500,
                                                                  ),
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    Text(
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      PriceFormatter.getFormattedValue((selectedProduks.isNotEmpty && selectedProduks != r?.produkList)
                                                                          ? selectedProduks[index].price ??
                                                                              0
                                                                          : r?.produkList[index].price ??
                                                                              0),
                                                                      style:
                                                                          appStyle(
                                                                        size:
                                                                            16,
                                                                        color:
                                                                            mainBlack,
                                                                        fw: FontWeight
                                                                            .bold,
                                                                      ).copyWith(
                                                                              decoration: (((selectedProduks.isNotEmpty && selectedProduks != r?.produkList) ? selectedProduks[index].promo : r?.produkList[index].promo) != null) && ((selectedProduks.isNotEmpty && selectedProduks != r?.produkList) ? selectedProduks[index].promo?.expiredAt ?? DateTime.now() : r?.produkList[index].promo?.expiredAt ?? DateTime.now()).isAfter(DateTime.now()) ? TextDecoration.lineThrough : TextDecoration.none,
                                                                              decorationThickness: 2),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            10),
                                                                    if (((selectedProduks.isNotEmpty && selectedProduks != r?.produkList) ? selectedProduks[index].promo : r?.produkList[index].promo) !=
                                                                            null &&
                                                                        ((selectedProduks.isNotEmpty && selectedProduks != r?.produkList)
                                                                                ? selectedProduks[index].promo?.expiredAt ?? DateTime.now()
                                                                                : r?.produkList[index].promo?.expiredAt ?? DateTime.now())
                                                                            .isAfter(DateTime.now()))
                                                                      Text(
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                        PriceFormatter.getFormattedValue((((selectedProduks.isNotEmpty && selectedProduks != r?.produkList)))
                                                                            ? (selectedProduks[index].price ?? 0) -
                                                                                (selectedProduks[index].price ?? 0) * ((selectedProduks[index].promo?.discountPercent?.toInt() ?? 0) / 100)
                                                                            : (r?.produkList[index].price ?? 0) - (r?.produkList[index].price ?? 0) * ((r?.produkList[index].promo?.discountPercent?.toInt() ?? 0) / 100)),
                                                                        style:
                                                                            appStyle(
                                                                          size:
                                                                              16,
                                                                          color:
                                                                              mainBlack,
                                                                          fw: FontWeight
                                                                              .bold,
                                                                        ),
                                                                      ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ]),
                                                      ]),
                                                    )
                                                  ],
                                                );
                                              }),
                                          const Divider(),
                                          Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                20, 10, 20, 15),
                                            child: Column(children: [
                                              InkWell(
                                                borderRadius:
                                                    BorderRadius.circular(40),
                                                onTap: () {
                                                  Routemaster.of(context).push(
                                                      '/internal-account/profile-toko/katalog-produk/edit/${widget.katalogId}/select-items');
                                                },
                                                child: Material(
                                                  borderRadius:
                                                      BorderRadius.circular(40),
                                                  elevation: 2,
                                                  surfaceTintColor: Colors.red,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15.0),
                                                    child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const Icon(
                                                              AntIcons
                                                                  .plusCircleFilled,
                                                              size: 25),
                                                          SizedBox(width: 5.w),
                                                          Text(
                                                            "Pilih Item",
                                                            style: appStyle(
                                                                size: 16,
                                                                color:
                                                                    mainBlack,
                                                                fw: FontWeight
                                                                    .w500),
                                                          ),
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
                                ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() &&
                                        (r!.produkList.isNotEmpty ||
                                            selectedProduks.isNotEmpty)) {
                                      ref
                                          .read(katalogProdukViewModelProvider
                                              .notifier)
                                          .editKatalogProduk(
                                              produkList:
                                                  (selectedProduks.isNotEmpty &&
                                                          selectedProduks !=
                                                              r.produkList)
                                                      ? selectedProduks
                                                      : r.produkList,
                                              katalogProdukName:
                                                  _nameKatalogController.text,
                                              katalogId: r.id!)
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
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                    error: (error, stackTrace) => Center(
                          child: Text(error.toString()),
                        ),
                    loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ));
              });
            },
            loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
            orElse: () => const SizedBox.shrink()),
      ),
    );
  }
}
