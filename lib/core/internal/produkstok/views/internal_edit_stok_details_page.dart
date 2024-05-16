import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/disabled_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';

class InternalEditStokDetailsPage extends StatefulWidget {
  const InternalEditStokDetailsPage({super.key});

  @override
  State<InternalEditStokDetailsPage> createState() =>
      _InternalEditStokDetailsPageState();
}

class _InternalEditStokDetailsPageState
    extends State<InternalEditStokDetailsPage> {
  final _productUnitController = TextEditingController();
  String selectedRoleDropdownValue = "";

  @override
  void dispose() {
    _productUnitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Detail Stok",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                const TopSectionAuth(
                  name: "Edit Detail Stok",
                  description: "Edit detail stok produk",
                  isAvatarNeeded: false,
                ),
                SizedBox(height: 20.h),
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
                          "Produk yang Dipilih",
                          style: appStyle(
                              size: 18, color: mainBlack, fw: FontWeight.w600),
                        ),
                        children: [
                          const Divider(),
                          ListTile(
                            onTap: () {
                            },
                            shape: const RoundedRectangleBorder(),
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 5),
                            title: Column(
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.asset(
                                          "assets/images/test-shoes-image.jpg",
                                          fit: BoxFit.contain,
                                          height: 80.h,
                                          width: 70.w),
                                    ),
                                    SizedBox(width: 15.w),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text("Sepatu Terbaru",
                                              style: appStyle(
                                                  size: 16,
                                                  color: mainBlack,
                                                  fw: FontWeight.w600)),
                                          Text(
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            "Ukuran: L130CM R130CM, L130CM R130CM, L130CM R130CM, L130CM R130CM, L130CM R130CM, L130CM R130CM, L130CM R130CM,  ",
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
                                  ],
                                ),
                                SizedBox(height: 5.h),
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
                            child: Column(
                              children: [
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
                                          SizedBox(width: 5.w),
                                          GestureDetector(
                                            onTap: () => Routemaster.of(context)
                                                .push(
                                                    '/internal-account/profile-toko/promosi/edit/item'),
                                            child: Text(
                                              "Pilih produk",
                                              style: appStyle(
                                                  size: 16,
                                                  color: mainBlack,
                                                  fw: FontWeight.w500),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
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
                    selectedRoleDropdownValue = value!;
                  },
                ),
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
                    selectedRoleDropdownValue = value!;
                  },
                ),
                SizedBox(height: 20.h),
                DisableCustomTextField(
                  value: "Centimeters (cm)",
                  labelText: "Satuan Produk",
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Format nama kategori produk tidak valid. Harap masukkan nama kategori yang valid.";
                    } else {
                      return null;
                    }
                  },
                  defaultValue: '0',
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "Masukkan jumlah stok",
                  controller: _productUnitController,
                  labelText: "Jumlah Stok",
                  obscureText: false,
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Format nama kategori produk tidak valid. Harap masukkan nama kategori yang valid.";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "Masukkan rata-rata penjualan harian",
                  controller: _productUnitController,
                  labelText: "Rata-rata Penjualan Harian",
                  obscureText: false,
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Format nama kategori produk tidak valid. Harap masukkan nama kategori yang valid.";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.h),
                CustomTextField(
                  hintText: "Masukkan rata-rata waktu harian",
                  controller: _productUnitController,
                  labelText: "Rata-rata Waktu Harian",
                  obscureText: false,
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Format nama kategori produk tidak valid. Harap masukkan nama kategori yang valid.";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.h),
                DisableCustomTextField(
                  value: "Masukkan stok aman",
                  labelText: "Stok Aman",
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Format nama kategori produk tidak valid. Harap masukkan nama kategori yang valid.";
                    } else {
                      return null;
                    }
                  },
                  defaultValue: '0',
                ),
                SizedBox(height: 20.h),
                DisableCustomTextField(
                  value: "Masukkan titik pesan ulang",
                  labelText: "Titik Pesan Ulang",
                  validator: (value) {
                    if (!(value!.isNotEmpty && value.length > 6)) {
                      return "Format nama kategori produk tidak valid. Harap masukkan nama kategori yang valid.";
                    } else {
                      return null;
                    }
                  },
                  defaultValue: '0',
                ),
                SizedBox(height: 25.h),
                ElevatedButton(
                  onPressed: () {
                    Routemaster.of(context)
                        .push('/internal-account/profile-toko/promosi/add');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.greenAccent,
                  ),
                  child: Text(
                    "Edit Stok",
                    style: appStyle(
                        size: 16, color: Colors.white, fw: FontWeight.w500),
                  ),
                ),
                SizedBox(height: 25.h),
                ElevatedButton(
                  onPressed: () {
                    Routemaster.of(context)
                        .push('/internal-account/profile-toko/promosi/add');
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Selesai",
                    style: appStyle(
                        size: 16, color: Colors.white, fw: FontWeight.w500),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
