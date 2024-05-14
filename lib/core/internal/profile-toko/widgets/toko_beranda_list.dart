import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/models/beranda_toko.dart';

class ProfileTokoBerandaList extends StatelessWidget {
  const ProfileTokoBerandaList({
    super.key,
    required CarouselController controller,
    required this.berandaTokoList,
  }) : _controller = controller;

  final CarouselController _controller;
  final List<BerandaToko> berandaTokoList;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: berandaTokoList.map((item) {
        return Container(
          margin: const EdgeInsets.all(5.0),
          child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  CachedNetworkImage(
                    imageUrl: item.berandaImageUrl ?? "",
                    width: 1000.w,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.fitWidth,),
                      ),
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                ],
              )),
        );
      }).toList(),
      carouselController: _controller,
      options: CarouselOptions(
        viewportFraction: 0.8,
        autoPlay: true,
        aspectRatio: 1.9,
        enlargeCenterPage: true,
      ),
    );
  }
}
