import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_selection_notifier.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/disabled_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalAddStokInformationPage extends ConsumerStatefulWidget {
  const InternalAddStokInformationPage({super.key});

  @override
  ConsumerState<InternalAddStokInformationPage> createState() =>
      _InternalAddProdukStokInformationPageState();
}

class _InternalAddProdukStokInformationPageState
    extends ConsumerState<InternalAddStokInformationPage> {
  String? selectedProdukColor;
  String? selectedProdukSize;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _beforeAmountController = TextEditingController();
  final _afterAmountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    _beforeAmountController.dispose();
    _afterAmountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productInformation = ref.watch(productStokSelectionNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambahkan Kombinasi Stok",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(children: [
                const TopSectionAuth(
                    name: "Tambahkan Kombinasi Stok",
                    description:
                        "Tambahkan kombinasi stok produk yang Anda masukkan",
                    isAvatarNeeded: false),
                const SizedBox(height: 20),
                CustomDropdown(
                  labelText: "Warna Produk",
                  hintText: "Pilih Warna Produk",
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Anda harus memilih warna.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedProdukColor = value;
                    });
                  },
                  values: (productInformation?.produkColors ?? [])
                      .map((e) => e.name)
                      .toSet()
                      .toList(),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  labelText: "Ukuran Produk",
                  hintText: "Pilih Ukuran Produk",
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Anda harus memilih ukuran.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedProdukSize = value;
                    });
                  },
                  values: (productInformation?.produkSizes ?? [])
                      .map((e) => e.name)
                      .toSet()
                      .toList(),
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  keyboard: TextInputType.number,
                  hintText: "Masukkan jumlah stok",
                  controller: _amountController,
                  labelText: "Jumlah Stok",
                  obscureText: false,
                  onChanged: ((value) {
                    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                      setState(() {});
                    });
                  }),
                  validator: (value) {
                    if (!(value!.isNotEmpty)) {
                      return "Format jumlah stok tidak valid. Harap masukkan jumlah stok yang valid.";
                    } else {
                      return null;
                    }
                  },
                ),
                const SizedBox(height: 20),
                Builder(builder: (context) {
                  final listVariations = productInformation?.produkCombination;
                  final foundVariation = listVariations?.firstWhere(
                    (element) =>
                        element.color?.name == selectedProdukColor &&
                        element.size?.name == selectedProdukSize,
                    orElse: () => listVariations[
                        0], // Use the first variation if not found
                  );
                  if (_amountController.text.isNotEmpty &&
                      selectedProdukColor != null &&
                      selectedProdukSize != null) {
                    return Column(children: [
                      DisableCustomTextField(
                        key: Key(foundVariation!.variantAmount.toString()),
                        labelText: "Jumlah Sekarang",
                        defaultValue: "0",
                        value: foundVariation.variantAmount.toString(),
                        textEditingController: _beforeAmountController,
                      ),
                      const SizedBox(height: 20),
                      DisableCustomTextField(
                        key: Key((foundVariation.variantAmount +
                                int.parse(_amountController.text))
                            .toString()),
                        labelText: "Total Jumlah",
                        defaultValue: "0",
                        value: (foundVariation.variantAmount +
                                int.parse(_amountController.text))
                            .toString(),
                        textEditingController: _afterAmountController,
                      ),
                      const SizedBox(height: 20),
                    ]);
                  } else {
                    return const SizedBox.shrink();
                  }
                }),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedProdukColor != null &&
                        selectedProdukSize != null) {
                      ref.read(productStokNotifierProvider.notifier).add(
                          color: (productInformation?.produkColors ?? [])
                              .map((e) {
                                return {
                                  "name": e.name,
                                  "imagePath": e.produkColorImageUrl,
                                };
                              })
                              .toList()
                              .firstWhere((element) {
                                return element["name"] == selectedProdukColor;
                              }),
                          size: selectedProdukSize!,
                          amount: int.parse(_amountController.text));
                      Routemaster.of(context).pop();
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
                        size: 16, color: Colors.white, fw: FontWeight.w500),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
