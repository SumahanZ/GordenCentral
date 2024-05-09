import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_selection_notifier.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalEditStokInformationPage extends ConsumerStatefulWidget {
  final int produkStokId;
  const InternalEditStokInformationPage({super.key, required this.produkStokId});

  @override
  ConsumerState<InternalEditStokInformationPage> createState() =>
      _InternalEditStokInformationPageState();
}

class _InternalEditStokInformationPageState
    extends ConsumerState<InternalEditStokInformationPage> {
  String? selectedProdukColor;
  String? selectedProdukSize;
  final TextEditingController _amountController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final produkStok = ref.watch(productStokNotifierProvider
        .select((value) => value[widget.produkStokId]));
    final productInformation = ref.watch(productStokSelectionNotifierProvider);
    _amountController.text = produkStok.stokAmount.toString();
    selectedProdukColor = produkStok.produkColor["name"];
    selectedProdukSize = produkStok.produkSize;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Kombinasi Stok",
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
                    name: "Edit Kombinasi Stok",
                    description:
                        "Edit kombinasi stok produk yang telah Anda masukkan",
                    isAvatarNeeded: false),
                const SizedBox(height: 20),
                CustomDropdown(
                  preValue: produkStok.produkColor["name"],
                  labelText: "Warna Produk",
                  hintText: "Pilih Warna Produk",
                  isDisabled: true,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Anda harus memilih warna.";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    setState(() {
                      selectedProdukSize = value;
                    });
                  },
                  values: (productInformation?.produkColors ?? [])
                      .map((e) => e.name)
                      .toList(),
                ),
                const SizedBox(height: 20),
                CustomDropdown(
                  preValue: produkStok.produkSize,
                  labelText: "Ukuran Produk",
                  hintText: "Pilih Ukuran Produk",
                  isDisabled: true,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return "Anda harus memilih ukuran.";
                    } else {
                      return null;
                    }
                  },
                  values: (productInformation?.produkSizes ?? [])
                      .map((e) => e.name)
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedProdukSize = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                    keyboard: TextInputType.number,
                    hintText: "Masukkan jumlah stok",
                    controller: _amountController,
                    labelText: "Jumlah Stok",
                    obscureText: false,
                    validator: (value) {
                      if (!(value!.isNotEmpty)) {
                        return "Format jumlah stok tidak valid. Harap masukkan jumlah stok yang valid.";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedProdukColor != null &&
                        selectedProdukSize != null) {
                      Map<String, dynamic> produkColor = produkStok.produkColor;
                      produkColor["name"] = selectedProdukColor;

                      ref.read(productStokNotifierProvider.notifier).edit(
                          index: widget.produkStokId,
                          color: produkColor,
                          size: selectedProdukSize,
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
                    "Edit Stok",
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
