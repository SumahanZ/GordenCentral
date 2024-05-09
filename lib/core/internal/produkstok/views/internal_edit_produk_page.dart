import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/repositories/implementations/produk_stok_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/widgets/product_card_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/widgets/produk_color_card_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/widgets/produk_picker_widget.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/repositories/implementations/profile_toko_repository_impl.dart';
import 'package:tugas_akhir_project/core/internal/profile-toko/viewmodels/toko_produk_viewmodel.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/extensions/either_extension.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/price_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_textarea_widget.dart';

class InternalEditProdukPage extends ConsumerStatefulWidget {
  const InternalEditProdukPage({super.key, required this.produkId});
  final int produkId;

  @override
  ConsumerState<InternalEditProdukPage> createState() =>
      _InternalEditProdukPageState();
}

class _InternalEditProdukPageState
    extends ConsumerState<InternalEditProdukPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  bool imageFromfile = false;
  bool initializeFirst = true;
  List<File> selectedImages = [];
  CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp ',
  );

  void pickTheImage() async {
    final image = await pickMultipleImages();
    if (image.isNotEmpty) {
      imageFromfile = true;
    }
    setState(() {
      selectedImages = image;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final produkDetail =
        ref.watch(fetchProdukDetailInternalProvider(widget.produkId));
    final productSelections =
        ref.watch(productCreationSelectionNotifierProvider);

    ref.listen(fetchProdukDetailInternalProvider(widget.produkId),
        (previous, next) {
      if (previous?.value?.unwrapRight() != next.value?.unwrapRight()) {
        final data = next.asData?.value.unwrapRight();
        setState(() {
          _nameController.text = data?.name ?? "";
          _descriptionController.text = data?.description ?? "";
          _priceController.text =
              PriceFormatter.getFormattedValue(data?.price ?? 0);
        });
      }
    });

    ref.listen(tokoProdukViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Berhasil",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Produk berhasil diedit!",
            onOkPress: () {
              Routemaster.of(context).replace('/internal-dashboard/produkstok');
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Peringatan",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Terjadi kesalahan respons!",
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
          "Edit Produk",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: produkDetail.maybeWhen(
              data: (data) {
                return data.match(
                    (l) => Center(
                        child: Text(l.message,
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600))), (r) {
                  return ref.watch(tokoProdukViewModelProvider).when(
                      data: (data) {
                        if (initializeFirst) {
                          _nameController.text = r?.name ?? "";
                          _descriptionController.text = r?.description ?? "";
                          _priceController.text =
                              PriceFormatter.getFormattedValue(r?.price ?? 0);
                          initializeFirst = false;
                        }

                        return SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              children: [
                                const TopSectionAuth(
                                    name: "Edit Produk",
                                    description:
                                        "Konfigurasikan informasi produk Anda",
                                    isAvatarNeeded: false),
                                const SizedBox(height: 30),
                                ProdukImagePickerWithProduk(
                                  selectedImages: selectedImages,
                                  pickTheImage: pickTheImage,
                                  produk: r!,
                                  imageFromfile: imageFromfile,
                                ),
                                const SizedBox(height: 30),
                                CustomTextField(
                                    hintText: "Masukkan nama produk",
                                    controller: _nameController,
                                    labelText: "Nama Produk",
                                    obscureText: false,
                                    validator: (value) {
                                      if (!(value!.isNotEmpty &&
                                          value.length > 6)) {
                                        return "Format nama produk tidak valid. Silakan masukkan nama yang valid.";
                                      } else {
                                        return null;
                                      }
                                    }),
                                const SizedBox(height: 10),
                                CustomTextArea(
                                    hintText: "Masukkan deskripsi produk",
                                    controller: _descriptionController,
                                    labelText: "Deskripsi Produk",
                                    obscureText: false),
                                const SizedBox(height: 10),
                                CustomPriceTextField(
                                    formatter: formatter,
                                    hintText: "Masukkan harga produk",
                                    controller: _priceController,
                                    labelText: "Harga Produk (Rp)",
                                    obscureText: false),
                                const SizedBox(height: 20),
                                ProdukCard(
                                  selections: productSelections.sizes,
                                  routeDestination:
                                      '/internal-dashboard/produkstok/edit-produk/${widget.produkId}/size',
                                  titleName: 'Ukuran Produk',
                                  buttonDescription: 'Tambah ukuran',
                                  type: 'size',
                                ),
                                const SizedBox(height: 20),
                                ProdukColorWidget(
                                  titleName: 'Warna Produk',
                                  buttonDescription: 'Tambah warna',
                                  routeDestination:
                                      '/internal-dashboard/produkstok/edit-produk/${widget.produkId}/color',
                                  selections: productSelections.colors,
                                ),
                                const SizedBox(height: 20),
                                ProdukCard(
                                  selections: productSelections.categories,
                                  routeDestination:
                                      '/internal-dashboard/produkstok/edit-produk/${widget.produkId}/select-category',
                                  titleName: 'Kategori Produk',
                                  buttonDescription: 'Pilih kategori',
                                  type: "category",
                                ),
                                const SizedBox(height: 40),
                                ElevatedButton(
                                  onPressed: () {
                                    ref
                                        .read(tokoProdukViewModelProvider
                                            .notifier)
                                        .editProduk(
                                            produkId: widget.produkId,
                                            productSaved: ProductSaved(
                                                name: _nameController.text,
                                                description:
                                                    _descriptionController.text,
                                                price: formatter
                                                            .getUnformattedValue()
                                                            .toDouble() ==
                                                        0
                                                    ? r.price ?? 0
                                                    : formatter
                                                        .getUnformattedValue()
                                                        .toDouble(),
                                                globalImageUrls:
                                                    selectedImages.map((e) {
                                                  return e.path;
                                                }).toList(),
                                                productSelection:
                                                    productSelections))
                                        .then((value) {
                                      ref.invalidate(fetchProductsTable);
                                    });
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
                        );
                      },
                      error: (error, stackTrace) =>
                          Center(child: Text(error.toString())),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()));
                });
              },
              loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
              orElse: () => const SizedBox.shrink())),
    );
  }
}
