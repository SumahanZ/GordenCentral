import 'dart:io';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';

class ProdukImagePicker extends StatefulWidget {
  // final Produk? produk;
  final List<File> selectedImages;
  final Function() pickTheImage;
  const ProdukImagePicker(
      {super.key, required this.selectedImages, required this.pickTheImage});

  @override
  State<ProdukImagePicker> createState() => _ProdukImagePickerState();
}

class _ProdukImagePickerState extends State<ProdukImagePicker> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      widget.selectedImages.isNotEmpty
          ? Column(
              children: [
                CarouselSlider(
                  items: widget.selectedImages.map((item) {
                    return GestureDetector(
                      onTap: () => widget.pickTheImage(),
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
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
                                        vertical: 10.0, horizontal: 20.0),
                                    child: Text(
                                      'No. ${widget.selectedImages.indexOf(item) + 1}',
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
                      ),
                    );
                  }).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    enableInfiniteScroll:
                        widget.selectedImages.length > 1 ? true : false,
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 1.5,
                  ),
                ),
              ],
            )
          : GestureDetector(
              onTap: () {
                widget.pickTheImage();
              },
              child: AspectRatio(
                aspectRatio: 2,
                child: Material(
                    borderRadius: BorderRadius.circular(5),
                    elevation: 5,
                    child: const Center(
                        child: Icon(AntIcons.cameraOutlined, size: 40))),
              ),
            ),
      SizedBox(height: 15.h),
      Text("*Gambar harus memiliki resolusi minimal 320 x 320*",
          style: appStyle(
              size: 11,
              color: Colors.grey.withOpacity(0.8),
              fw: FontWeight.w500))
    ]);
  }
}

class ProdukImagePickerWithProduk extends StatefulWidget {
  final bool imageFromfile;
  final Produk? produk;
  final List<File> selectedImages;
  final Function() pickTheImage;
  const ProdukImagePickerWithProduk(
      {super.key,
      required this.selectedImages,
      required this.pickTheImage,
      this.produk,
      required this.imageFromfile});

  @override
  State<ProdukImagePickerWithProduk> createState() =>
      _ProdukImagePickerWithProdukState();
}

class _ProdukImagePickerWithProdukState
    extends State<ProdukImagePickerWithProduk> {
  final CarouselController _controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      widget.produk != null &&
              widget.produk!.produkGlobalImages.isNotEmpty &&
              widget.imageFromfile == false
          ? Column(
              children: [
                CarouselSlider(
                  items: widget.produk?.produkGlobalImages.map((item) {
                    return GestureDetector(
                      onTap: () => widget.pickTheImage(),
                      child: Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                CachedNetworkImage(
                                  imageUrl: item.globalImageUrl,
                                  width: 1000.w,
                                  imageBuilder: (context, imageProvider) =>
                                      Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: imageProvider,
                                      ),
                                    ),
                                  ),
                                  // placeholder: (context, url) => const Center(
                                  //     child: CircularProgressIndicator()),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
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
                                        vertical: 10.0, horizontal: 20.0),
                                    child: Text(
                                      'No. ${widget.produk!.produkGlobalImages.indexOf(item) + 1}',
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
                      ),
                    );
                  }).toList(),
                  carouselController: _controller,
                  options: CarouselOptions(
                    enableInfiniteScroll:
                        widget.selectedImages.length > 1 ? true : false,
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 1.5,
                  ),
                ),
              ],
            )
          : widget.selectedImages.isNotEmpty
              ? Column(
                  children: [
                    CarouselSlider(
                      items: widget.selectedImages.map((item) {
                        return GestureDetector(
                          onTap: () => widget.pickTheImage(),
                          child: Container(
                            margin: const EdgeInsets.all(5.0),
                            child: ClipRRect(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
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
                                            vertical: 10.0, horizontal: 20.0),
                                        child: Text(
                                          'No. ${widget.selectedImages.indexOf(item) + 1}',
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
                          ),
                        );
                      }).toList(),
                      carouselController: _controller,
                      options: CarouselOptions(
                        enableInfiniteScroll:
                            widget.selectedImages.length > 1 ? true : false,
                        viewportFraction: 1,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 1.5,
                      ),
                    ),
                  ],
                )
              : GestureDetector(
                  onTap: () {
                    widget.pickTheImage();
                  },
                  child: AspectRatio(
                    aspectRatio: 2,
                    child: Material(
                        borderRadius: BorderRadius.circular(5),
                        elevation: 5,
                        child: const Center(
                            child: Icon(AntIcons.cameraOutlined, size: 40))),
                  ),
                ),
      SizedBox(height: 15.h),
      Text("*Gambar harus memiliki resolusi minimal 320 x 320*",
          style: appStyle(
              size: 11,
              color: Colors.grey.withOpacity(0.8),
              fw: FontWeight.w500))
    ]);
  }
}
