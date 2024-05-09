import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/date_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/disabled_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalAddLaporanBarangMasukPage extends StatefulWidget {
  const InternalAddLaporanBarangMasukPage({super.key});

  @override
  State<InternalAddLaporanBarangMasukPage> createState() =>
      _InternalAddLaporanBarangMasukPageState();
}

class _InternalAddLaporanBarangMasukPageState
    extends State<InternalAddLaporanBarangMasukPage> {
  final _productUnitController = TextEditingController();
  final _amountController = TextEditingController();
  final _issuedFromController = TextEditingController();
  final _deliveredAtController = TextEditingController();
  String selectedRoleDropdownValue = "";

  @override
  void dispose() {
    _productUnitController.dispose();
    _amountController.dispose();
    _issuedFromController.dispose();
    _deliveredAtController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Add Laporan Barang Masuk Page",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              const TopSectionAuth(
                  name: "Add Laporan Barang Masuk",
                  description: "Add a laporan barang masuk entry",
                  isAvatarNeeded: false),
              const SizedBox(height: 20),
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
                      title: Text(
                        "Selected product",
                        style: appStyle(
                            size: 18, color: mainBlack, fw: FontWeight.w600),
                      ),
                      children: [
                        const Divider(),
                        ListTile(
                          onTap: () {
                            print("test");
                          },
                          shape: const RoundedRectangleBorder(),
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          title: Column(children: [
                            IntrinsicHeight(
                              child: Row(children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.asset(
                                      "assets/images/test-shoes-image.jpg",
                                      fit: BoxFit.contain,
                                      width: 70),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text("The newest Gorden",
                                          style: appStyle(
                                              size: 16,
                                              color: mainBlack,
                                              fw: FontWeight.w600)),
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Size: L130CM R130CM, L130CM R130CM, L130CM R130CM, L130CM R130CM, L130CM R130CM, L130CM R130CM, L130CM R130CM,  ",
                                        style: appStyle(
                                          size: 12,
                                          color: mainBlack,
                                          fw: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Warna: Light Cream, Light Beige, Light Beige, Light Beige, Light Beige, Light Beige",
                                        style: appStyle(
                                          size: 12,
                                          color: mainBlack,
                                          fw: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Motif: Clutch Style, Light Beige, Light Beige, Light Beige, Light Beige",
                                        style: appStyle(
                                          size: 12,
                                          color: mainBlack,
                                          fw: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        "Rp 127.000",
                                        style: appStyle(
                                          size: 16,
                                          color: mainBlack,
                                          fw: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]),
                            ),
                            const SizedBox(height: 5),
                          ]),
                        ),
                        const Divider(),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                          child: Column(children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(40),
                              onTap: () {},
                              child: Material(
                                borderRadius: BorderRadius.circular(40),
                                elevation: 2,
                                surfaceTintColor: Colors.red,
                                child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(AntIcons.plusCircleFilled,
                                            size: 25),
                                        const SizedBox(width: 5),
                                        GestureDetector(
                                          onTap: () => Routemaster.of(context).push(
                                              '/internal-account/profile-toko/promosi/edit/item'),
                                          child: Text(
                                            "Select product",
                                            style: appStyle(
                                                size: 16,
                                                color: mainBlack,
                                                fw: FontWeight.w500),
                                          ),
                                        )
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
              CustomDropdown(
                labelText: "Produk Color",
                hintText: "Choose Produk Color",
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "You must choose a color.";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  selectedRoleDropdownValue = value!;
                },
              ),
              const SizedBox(height: 20),
              CustomDropdown(
                labelText: "Produk Size",
                hintText: "Choose Produk Size",
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return "You must choose a category.";
                  } else {
                    return null;
                  }
                },
                onChanged: (value) {
                  selectedRoleDropdownValue = value!;
                },
              ),
              const SizedBox(height: 20),
              //if not exist show disable form field
              CustomTextField(
                  hintText: "Enter produk unit",
                  controller: _productUnitController,
                  labelText: "Produk Unit",
                  obscureText: false,
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Invalid katalog produk category name format. Please enter a valid category name.";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 20),
              DisableCustomTextField(
                labelText: "Before Stok Amount",
                validator: (value) {
                  if (!(value!.isNotEmpty && value.length > 6)) {
                    return "Invalid katalog produk category name format. Please enter a valid category name.";
                  } else {
                    return null;
                  }
                },
                value: '15',
                defaultValue: '0',
              ),
              const SizedBox(height: 20),
              CustomTextField(
                  hintText: "Entered entered stok amount",
                  controller: _amountController,
                  labelText: "In Produk Amount",
                  obscureText: false,
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Invalid katalog produk category name format. Please enter a valid category name.";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 20),
              DisableCustomTextField(
                labelText: "After Stok Amount",
                validator: (value) {
                  if (!(value!.isNotEmpty && value.length > 6)) {
                    return "Invalid katalog produk category name format. Please enter a valid category name.";
                  } else {
                    return null;
                  }
                },
                value: '15',
                defaultValue: '0',
              ),
              const SizedBox(height: 20),
              DateCustomTextField(
                  hintText: "Select issued from date",
                  controller: _issuedFromController,
                  labelText: "Issued From",
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Invalid katalog produk category name format. Please enter a valid category name.";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 20),
              DateCustomTextField(
                  hintText: "Select delivered at date",
                  controller: _deliveredAtController,
                  labelText: "Delivered At",
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Invalid katalog produk category name format. Please enter a valid category name.";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(height: 20),
              DisableCustomTextField(
                labelText: "Delivery Time",
                value: "15",
                validator: (value) {
                  if (!(value!.isNotEmpty && value.length > 6)) {
                    return "Invalid katalog produk category name format. Please enter a valid category name.";
                  } else {
                    return null;
                  }
                },
                defaultValue: '0',
              ),
              const SizedBox(height: 20),
              DisableCustomTextField(
                labelText: "Total Amount",
                value: "80",
                validator: (value) {
                  if (!(value!.isNotEmpty && value.length > 6)) {
                    return "Invalid katalog produk category name format. Please enter a valid category name.";
                  } else {
                    return null;
                  }
                },
                defaultValue: '0',
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () {
                  Routemaster.of(context)
                      .push('/internal-account/profile-toko/promosi/add');
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                child: Text(
                  "Confirm",
                  style: appStyle(
                      size: 16, color: Colors.white, fw: FontWeight.w500),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
