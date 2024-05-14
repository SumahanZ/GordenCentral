import 'dart:io';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/core/auth/widgets/top_section_auth_widget.dart';
import 'package:tugas_akhir_project/utils/methods/utilmethods.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';
import 'package:tugas_akhir_project/widgets/custom_dropdown_button_widget.dart';
import 'package:tugas_akhir_project/widgets/price_form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_field_widget.dart';
import 'package:tugas_akhir_project/widgets/form_textarea_widget.dart';

class InternalEditLayananPage extends StatefulWidget {
  const InternalEditLayananPage({super.key});

  @override
  State<InternalEditLayananPage> createState() =>
      _InternalEditLayananPageState();
}

class _InternalEditLayananPageState extends State<InternalEditLayananPage> {
  final CarouselController _controller = CarouselController();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();
  String selectedRoleDropdownValue = "";
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Layanan Page",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                const TopSectionAuth(
                    name: "Edit Produk",
                    description: "Configure your produk information",
                    isAvatarNeeded: false),
                const SizedBox(height: 30),
                selectedImages.isNotEmpty
                    ? Column(
                        children: [
                          CarouselSlider(
                            items: selectedImages.map((item) {
                              return Container(
                                margin: const EdgeInsets.all(5.0),
                                child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(5.0)),
                                    child: Stack(
                                      children: <Widget>[
                                        Image.file(item,
                                            fit: BoxFit.cover, width: 1000.0.w),
                                        Positioned(
                                          bottom: 0.0,
                                          left: 0.0,
                                          right: 0.0,
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color.fromARGB(200, 0, 0, 0),
                                                  Color.fromARGB(0, 0, 0, 0)
                                                ],
                                                begin: Alignment.bottomCenter,
                                                end: Alignment.topCenter,
                                              ),
                                            ),
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10.0,
                                                horizontal: 20.0),
                                            child: Text(
                                              'No. ${selectedImages.indexOf(item) + 1}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )),
                              );
                            }).toList(),
                            carouselController: _controller,
                            options: CarouselOptions(
                              autoPlay: true,
                              enlargeCenterPage: true,
                              aspectRatio: 2.0,
                            ),
                          ),
                        ],
                      )
                    : GestureDetector(
                        onTap: () {
                          pickTheImage();
                        },
                        child: AspectRatio(
                          aspectRatio: 2,
                          child: Material(
                              borderRadius: BorderRadius.circular(5),
                              elevation: 5,
                              child: const Center(
                                  child:
                                      Icon(AntIcons.cameraOutlined, size: 40))),
                        ),
                      ),
                const SizedBox(height: 30),
                CustomTextField(
                    hintText: "Enter produk name",
                    controller: _nameController,
                    labelText: "Produk Name",
                    obscureText: false,
                    validator: (value) {
                      if (!(value!.isNotEmpty && value.length > 6)) {
                        return "Invalid katalog produk category name format. Please enter a valid category name.";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(height: 10),
                CustomTextArea(
                    hintText: "Enter produk description",
                    controller: _descriptionController,
                    labelText: "Produk Description",
                    obscureText: false),
                const SizedBox(height: 10),
                CustomDropdown(
                  labelText: "Produk Category",
                  hintText: "Choose Produk Category",
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
                const SizedBox(height: 10),
                CustomPriceTextField(
                    hintText: "Enter produk price",
                    controller: _priceController,
                    labelText: "Produk Price (Rp)",
                    obscureText: false,
                    formatter: formatter),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    elevation: 5,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                  child: Text(
                    "Confirm",
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
