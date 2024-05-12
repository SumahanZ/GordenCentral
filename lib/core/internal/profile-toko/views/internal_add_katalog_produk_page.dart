import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class InternalAddKatalogProdukPage extends ConsumerStatefulWidget {
  const InternalAddKatalogProdukPage({super.key});

  @override
  ConsumerState<InternalAddKatalogProdukPage> createState() =>
      _InternalAddKatalogProdukPageState();
}

class _InternalAddKatalogProdukPageState
    extends ConsumerState<InternalAddKatalogProdukPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameKatalogController = TextEditingController();

  @override
  void dispose() {
    _nameKatalogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedProduks =
        ref.watch(katalogProdukItemSelectionNotifierProvider);

    ref.listen(katalogProdukViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Berhasil membuat dan menambahkan produk ke katalog!",
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
            desc: "Terjadi kesalahan respons!",
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
            desc: (state.error as ApiError).message,
            onOkPress: () {
              
            });
      }
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Tambah Katalog Produk",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: ref.watch(katalogProdukViewModelProvider).when(
                data: (data) {
                  return SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10),
                        child: Column(
                          children: [
                            const TopSectionAuth(
                                name: "Tambah Katalog Produk",
                                description: "Tambah Katalog Produk Toko",
                                isAvatarNeeded: false),
                            const SizedBox(height: 20),
                            CustomTextField(
                              hintText: "Masukkan nama kategori produk katalog",
                              controller: _nameKatalogController,
                              labelText: "Nama Kategori",
                              obscureText: false,
                              validator: (value) {
                                if (!(value!.isNotEmpty && value.length > 6)) {
                                  return "Format nama kategori produk katalog tidak valid. Harap masukkan nama kategori yang valid.";
                                } else {
                                  return null;
                                }
                              },
                            ),
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
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Item Kategori",
                                          style: appStyle(
                                            size: 18,
                                            color: mainBlack,
                                            fw: FontWeight.w600,
                                          ),
                                        ),
                                        if (selectedProduks.isNotEmpty)
                                          Text(
                                            "Jumlah: ${selectedProduks.length}",
                                            style: appStyle(
                                              size: 16,
                                              color: mainBlack,
                                              fw: FontWeight.w500,
                                            ),
                                          ),
                                      ],
                                    ),
                                    children: [
                                      ListView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: selectedProduks.length,
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
                                                    if (selectedProduks[index]
                                                                .promo
                                                                ?.produk !=
                                                            null &&
                                                        (selectedProduks[index]
                                                                    .promo
                                                                    ?.expiredAt ??
                                                                DateTime.now())
                                                            .isAfter(
                                                                DateTime.now()))
                                                      Row(
                                                        children: [
                                                          const Icon(Icons
                                                              .discount_outlined),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                              "${selectedProduks[index].promo?.discountPercent}% OFF",
                                                              style: appStyle(
                                                                  size: 12,
                                                                  color:
                                                                      mainBlack,
                                                                  fw: FontWeight
                                                                      .w600)),
                                                          const Spacer(),
                                                          Text(
                                                            textAlign: TextAlign
                                                                .center,
                                                            "Expires: ${DateTimeHourMin.durationBetween(DateTime.now(), selectedProduks[index].promo!.expiredAt!)}",
                                                            style: appStyle(
                                                              size: 11,
                                                              color: mainBlack,
                                                              fw: FontWeight
                                                                  .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    const SizedBox(height: 5),
                                                    IntrinsicHeight(
                                                      child: Row(children: [
                                                        ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            child:
                                                                CachedNetworkImage(
                                                              imageUrl: selectedProduks[
                                                                      index]
                                                                  .produkGlobalImages[
                                                                      0]
                                                                  .globalImageUrl,
                                                              width: 70,
                                                              imageBuilder:
                                                                  (context,
                                                                          imageProvider) =>
                                                                      Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  image:
                                                                      DecorationImage(
                                                                    fit: BoxFit
                                                                        .contain,
                                                                    image:
                                                                        imageProvider,
                                                                  ),
                                                                ),
                                                              ),
                                                              // placeholder: (context,
                                                              //         url) =>
                                                              //     const CircularProgressIndicator(),
                                                              errorWidget: (context,
                                                                      url,
                                                                      error) =>
                                                                  const Icon(Icons
                                                                      .error),
                                                            )),
                                                        const SizedBox(
                                                            width: 15),
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
                                                                  selectedProduks[
                                                                              index]
                                                                          .name ??
                                                                      "No name",
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
                                                                "Ukuran: ${selectedProduks[index].produkSizes.map((e) => e.name).toList().getConcatenatedList()}",
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
                                                                "Warna: ${selectedProduks[index].produkColors.map((e) => e.name).toList().getConcatenatedList()}",
                                                                style: appStyle(
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
                                                                    maxLines: 1,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    PriceFormatter
                                                                        .getFormattedValue(
                                                                            selectedProduks[index].price ??
                                                                                0),
                                                                    style:
                                                                        appStyle(
                                                                      size: 16,
                                                                      color:
                                                                          mainBlack,
                                                                      fw: FontWeight
                                                                          .bold,
                                                                    ).copyWith(
                                                                            decoration: selectedProduks[index].promo != null && (selectedProduks[index].promo?.expiredAt ?? DateTime.now()).isAfter(DateTime.now())
                                                                                ? TextDecoration.lineThrough
                                                                                : TextDecoration.none,
                                                                            decorationThickness: 2),
                                                                  ),
                                                                  const SizedBox(
                                                                      width:
                                                                          10),
                                                                  if (selectedProduks[index]
                                                                              .promo !=
                                                                          null &&
                                                                      (selectedProduks[index].promo?.expiredAt ??
                                                                              DateTime.now())
                                                                          .isAfter(DateTime.now()))
                                                                    Text(
                                                                      maxLines:
                                                                          1,
                                                                      overflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      PriceFormatter.getFormattedValue((selectedProduks[index].price ??
                                                                              0) -
                                                                          (selectedProduks[index].price ?? 0) *
                                                                              ((selectedProduks[index].promo?.discountPercent?.toInt() ?? 0) / 100)),
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
                                                    ),
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
                                                  '/internal-account/profile-toko/katalog-produk/add/select-items');
                                            },
                                            child: Material(
                                              borderRadius:
                                                  BorderRadius.circular(40),
                                              elevation: 2,
                                              surfaceTintColor: Colors.red,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      const Icon(
                                                          AntIcons
                                                              .plusCircleFilled,
                                                          size: 25),
                                                      const SizedBox(width: 5),
                                                      Text(
                                                        "Pilih item",
                                                        style: appStyle(
                                                            size: 16,
                                                            color: mainBlack,
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
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate() &&
                                    selectedProduks.isNotEmpty) {
                                  ref
                                      .read(katalogProdukViewModelProvider
                                          .notifier)
                                      .addKatalogProduk(
                                          katalogProdukName:
                                              _nameKatalogController.text,
                                          produkList: selectedProduks)
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
                error: (error, stackTrace) =>
                    Center(child: Text(error.toString())),
                loading: () =>
                    const Center(child: CircularProgressIndicator()))));
  }
}
