import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalProdukSizePage extends ConsumerStatefulWidget {
  const InternalProdukSizePage({super.key});

  @override
  ConsumerState<InternalProdukSizePage> createState() =>
      _InternalProdukSizePageState();
}

class _InternalProdukSizePageState
    extends ConsumerState<InternalProdukSizePage> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Ukuran Produk",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const TopSectionAuth(
                    name: "Ukuran Produk",
                    description: "Konfigurasikan ukuran produk Anda",
                    isAvatarNeeded: false),
                const SizedBox(height: 30),
                CustomTextField(
                    hintText: "Masukkan nama ukuran produk",
                    controller: _nameController,
                    labelText: "Nama Ukuran Produk",
                    obscureText: false,
                    validator: (value) {
                      if (!(value!.isNotEmpty && value.length > 6)) {
                        return "Format nama ukuran produk tidak valid. Harap masukkan nama ukuran produk yang valid.";
                      } else {
                        return null;
                      }
                    }),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ref
                          .read(
                              productCreationSelectionNotifierProvider.notifier)
                          .addToSizes(name: _nameController.text);
                      Routemaster.of(context).pop();
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
        )));
  }
}
