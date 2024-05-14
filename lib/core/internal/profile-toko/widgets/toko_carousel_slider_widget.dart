import 'dart:io';

import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BerandaTokoCarouselSlider extends StatefulWidget {
  final List<String> berandaImageUrls;
  final List<File> selectedImages;
  final VoidCallback pickTheImage;
  const BerandaTokoCarouselSlider(
      {super.key,
      required this.berandaImageUrls,
      required this.selectedImages,
      required this.pickTheImage});

  @override
  State<BerandaTokoCarouselSlider> createState() =>
      _BerandaTokoCarouselSliderState();
}

class _BerandaTokoCarouselSliderState extends State<BerandaTokoCarouselSlider> {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return widget.berandaImageUrls.isNotEmpty && widget.selectedImages.isEmpty
        ? Column(
            children: [
              CarouselSlider(
                items: widget.berandaImageUrls.map((item) {
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
                                imageUrl: item,
                                width: 1000.0.w,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
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
                                    'No. ${widget.berandaImageUrls.indexOf(item) + 1}',
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
                    viewportFraction: 1,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: 1.5,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _current = index;
                      });
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: widget.berandaImageUrls.asMap().entries.map((entry) {
                  return GestureDetector(
                    onTap: () => _controller.animateToPage(entry.key),
                    child: Container(
                      width: 12.0.w,
                      height: 12.0.h,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          )
        : widget.selectedImages.isNotEmpty
            ? Column(
                children: [
                  CarouselSlider(
                    items: widget.selectedImages.map((item) {
                      return Container(
                        margin: const EdgeInsets.all(5.0),
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                            child: Stack(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    widget.pickTheImage();
                                  },
                                  child: Image.file(item,
                                      fit: BoxFit.cover, width: 1000.0.w),
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
                      );
                    }).toList(),
                    carouselController: _controller,
                    options: CarouselOptions(
                        viewportFraction: 1,
                        autoPlay: true,
                        enlargeCenterPage: true,
                        aspectRatio: 1.5,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        widget.selectedImages.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: 12.0.w,
                          height: 12.0.h,
                          margin: const EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 4.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(_current == entry.key ? 0.9 : 0.4),
                          ),
                        ),
                      );
                    }).toList(),
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
                      child: Icon(AntIcons.cameraOutlined, size: 40),
                    ),
                  ),
                ),
              );
  }
}
