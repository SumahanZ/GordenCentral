import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/providers/product_creation_selection_notifier.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/widgets/produk_picker_widget.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalProdukColorPage extends ConsumerStatefulWidget {
  const InternalProdukColorPage({super.key});

  @override
  ConsumerState<InternalProdukColorPage> createState() =>
      _InternalProdukColorPageState();
}

class _InternalProdukColorPageState
    extends ConsumerState<InternalProdukColorPage> {
  List<File> selectedImages = [];
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void pickTheImage() async {
    final image = await pickImage();
    setState(() {
      if (image != null) selectedImages.insert(0, image);
    });
  }

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
          "Warna Produk",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TopSectionAuth(
                      name: "Warna Produk",
                      description: "Konfigurasikan warna produk Anda",
                      isAvatarNeeded: false),
                  const SizedBox(height: 20),
                  ProdukImagePicker(
                      selectedImages: selectedImages,
                      pickTheImage: pickTheImage),
                  const SizedBox(height: 30),
                  CustomTextField(
                      hintText: "Masukkan nama warna produk",
                      controller: _nameController,
                      labelText: "Warna Produk",
                      obscureText: false,
                      validator: (value) {
                        if (!(value!.isNotEmpty && value.length > 6)) {
                          return "Format warna produk tidak valid. Harap masukkan warna produk yang valid.";
                        } else {
                          return null;
                        }
                      }),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        ref
                            .read(productCreationSelectionNotifierProvider
                                .notifier)
                            .addToColors(
                                name: _nameController.text,
                                imagePath: selectedImages
                                    .map((e) => e.path)
                                    .toList()
                                    .first);
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
          ),
        ),
      ),
    );
  }
}
