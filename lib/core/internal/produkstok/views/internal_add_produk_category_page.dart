import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/core/internal/produkstok/viewmodels/produk_stok_viewmodel.dart';
import 'package:tugas_akhir_project/utils/errors/api_errors.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalAddProdukCategoryPage extends ConsumerStatefulWidget {
  const InternalAddProdukCategoryPage({super.key});

  @override
  ConsumerState<InternalAddProdukCategoryPage> createState() =>
      _InternalAddProdukCategoryPageState();
}

class _InternalAddProdukCategoryPageState
    extends ConsumerState<InternalAddProdukCategoryPage> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<File> selectedImages = [];

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(produkStokViewModelProvider, (_, state) {
      if (state is AsyncData<void>) {
        showPopupModal(
            context: context,
            title: "Success",
            info: DialogType.success,
            animType: AnimType.scale,
            desc: "Successfully added produk category!",
            onOkPress: () {
              Routemaster.of(context).pop();
            });
      } else if (state is AsyncError && state.error is ResponseAPIError) {
        showPopupModal(
            context: context,
            title: "Warning",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Response error has occured!",
            onOkPress: () {
              
            });
      } else if (state is AsyncError && state.error is RequestError) {
        showPopupModal(
            context: context,
            title: "Warning",
            info: DialogType.error,
            animType: AnimType.scale,
            desc: "Network request has occured!",
            onOkPress: () {
              
            });
      } else if (state is AsyncError) {
        showPopupModal(
            context: context,
            title: "Warning",
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
          "Add Produk Category Page",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ref.watch(produkStokViewModelProvider).maybeWhen(
              data: (data) {
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10),
                      child: Column(children: [
                        const TopSectionAuth(
                            name: "Add Produk Category",
                            description:
                                "Add the produk category for your shop",
                            isAvatarNeeded: false),
                        const SizedBox(height: 20),
                        CustomTextField(
                            hintText: "Enter produk category name",
                            controller: _nameController,
                            labelText: "Category Name",
                            obscureText: false,
                            validator: (value) {
                              if (!(value!.isNotEmpty && value.length > 4)) {
                                return "Invalid category name format. Please enter a valid category name.";
                              } else {
                                return null;
                              }
                            }),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              ref
                                  .read(produkStokViewModelProvider.notifier)
                                  .addProdukCategory(name: _nameController.text)
                                  .then((value) {});
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
                            "Add Category",
                            style: appStyle(
                                size: 16,
                                color: Colors.white,
                                fw: FontWeight.w500),
                          ),
                        ),
                      ]),
                    ),
                  ),
                );
              },
              orElse: (() => const SizedBox.shrink()),
              loading: () => const Center(child: CircularProgressIndicator()))),
    );
  }
}
