import 'dart:io';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/widgets/product_card_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/widgets/produk_color_card_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/widgets/produk_picker_widget.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/price_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_textarea_widget.dart';

class InternalInputProdukPage extends ConsumerStatefulWidget {
  const InternalInputProdukPage({super.key});

  @override
  ConsumerState<InternalInputProdukPage> createState() =>
      _InternalInputProdukPageState();
}

class _InternalInputProdukPageState
    extends ConsumerState<InternalInputProdukPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<File> selectedImages = [];
  CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    locale: 'id',
    decimalDigits: 0,
    symbol: 'Rp ',
  );

  void pickTheImage() async {
    final image = await pickMultipleImages();
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
    final productSelections =
        ref.watch(productCreationSelectionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Input Produk",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  const TopSectionAuth(
                      name: "Input Produk",
                      description: "Masukkan informasi produk Anda",
                      isAvatarNeeded: false),
                  SizedBox(height: 30.h),
                  ProdukImagePicker(
                      selectedImages: selectedImages,
                      pickTheImage: pickTheImage),
                  SizedBox(height: 30.h),
                  CustomTextField(
                      hintText: "Masukkan nama produk",
                      controller: _nameController,
                      labelText: "Nama Produk",
                      obscureText: false,
                      validator: (value) {
                        if (!(value!.isNotEmpty && value.length > 6)) {
                          return "Format nama produk tidak valid. Harap masukkan nama produk yang valid.";
                        } else {
                          return null;
                        }
                      }),
                  SizedBox(height: 10.h),
                  CustomTextArea(
                      hintText: "Masukkan deskripsi produk",
                      controller: _descriptionController,
                      labelText: "Deskripsi Produk",
                      validator: (value) {
                        if (!(value!.isNotEmpty)) {
                          return "Format deskripsi produk tidak valid. Harap masukkan deskripsi produk yang valid.";
                        } else {
                          return null;
                        }
                      },
                      obscureText: false),
                  SizedBox(height: 10.h),
                  CustomPriceTextField(
                      formatter: formatter,
                      hintText: "Masukkan harga produk",
                      controller: _priceController,
                      labelText: "Harga Produk (Rp)",
                      validator: (value) {
                        if (!(value!.isNotEmpty)) {
                          return "Format harga produk tidak valid. Harap masukkan harga produk yang valid.";
                        } else {
                          return null;
                        }
                      },
                      obscureText: false),
                  SizedBox(height: 20.h),
                  ProdukCard(
                    selections: productSelections.sizes,
                    routeDestination:
                        '/internal-dashboard/produkstok/input-produk/size',
                    titleName: 'Ukuran Produk',
                    buttonDescription: 'Tambahkan ukuran',
                    type: 'size',
                  ),
                  SizedBox(height: 20.h),
                  ProdukColorWidget(
                    titleName: 'Warna Produk',
                    buttonDescription: 'Tambahkan warna',
                    routeDestination:
                        '/internal-dashboard/produkstok/input-produk/color',
                    selections: productSelections.colors,
                  ),
                  SizedBox(height: 20.h),
                  ProdukCard(
                    selections: productSelections.categories,
                    routeDestination:
                        '/internal-dashboard/produkstok/input-produk/select-category',
                    titleName: 'Kategori Produk',
                    buttonDescription: 'Pilih kategori',
                    type: "category",
                  ),
                  SizedBox(height: 40.h),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() &&
                          productSelections.categories.isNotEmpty &&
                          (productSelections.sizes.isNotEmpty ||
                              productSelections.colors.isNotEmpty)) {
                        final productSaved = ProductSaved(
                            name: _nameController.text,
                            description: _descriptionController.text,
                            price: formatter.getUnformattedValue().toDouble(),
                            globalImageUrls:
                                selectedImages.map((e) => e.path).toList(),
                            productSelection: productSelections);

                        ref
                            .read(productSavedProvider.notifier)
                            .update((state) => productSaved);

                        Routemaster.of(context).push(
                            '/internal-dashboard/produkstok/input-produk/add-stok');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 5,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    child: Text(
                      "Konfirmasi",
                      style: appStyle(
                          size: 16, color: Colors.white, fw: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
