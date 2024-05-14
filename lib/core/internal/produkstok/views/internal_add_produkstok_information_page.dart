import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_saved.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_stok_notifier.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalAddProdukStokInformationPage extends ConsumerStatefulWidget {
  const InternalAddProdukStokInformationPage({super.key});

  @override
  ConsumerState<InternalAddProdukStokInformationPage> createState() =>
      _InternalAddProdukStokInformationPageState();
}

class _InternalAddProdukStokInformationPageState
    extends ConsumerState<InternalAddProdukStokInformationPage> {
  String? selectedProdukColor;
  String? selectedProdukSize;
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();


  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productSelection = ref.watch(productSavedProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Tambahkan Kombinasi Produk",
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
                SizedBox(height: 20.h),
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
                      selectedProdukColor = value;
                    },
                    values: productSelection?.productSelection.colors
                        .map((e) => e["name"] as String)
                        .toList()),
                SizedBox(height: 20.h),
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
                      selectedProdukSize = value;
                    },
                    values: productSelection?.productSelection.sizes),
                SizedBox(height: 20.h),
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
                SizedBox(height: 20.h),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedProdukColor != null &&
                        selectedProdukSize != null) {
                      ref.read(productStokNotifierProvider.notifier).add(
                          color: productSelection!.productSelection.colors
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
