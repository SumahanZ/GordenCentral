import 'package:antdesign_icons/antdesign_icons.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:routemaster/routemaster.dart';
import 'package:sliding_up_panel2/sliding_up_panel2.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class InternalLayananDetailPage extends StatefulWidget {
  const InternalLayananDetailPage({super.key});

  @override
  State<InternalLayananDetailPage> createState() =>
      _InternalLayananDetailPageState();
}

class _InternalLayananDetailPageState extends State<InternalLayananDetailPage> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  final List<String> imgList = [
    'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
    'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
    'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
    'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
    'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Layanan Detail Page",
            style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w500),
          ),
          centerTitle: true,
        ),
        body: SlidingUpPanel(
          panelBuilder: () => Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10.0),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Rp 197.000",
                          style: appStyle(
                            size: 22,
                            color: mainBlack,
                            fw: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Routemaster.of(context)
                            .push('/internal-dashboard/layanan/detail/edit');
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        backgroundColor: Colors.greenAccent,
                      ),
                      child: Text(
                        "Edit Layanan",
                        style: appStyle(
                            size: 16, color: Colors.white, fw: FontWeight.w500),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          backdropEnabled: false,
          borderRadius: BorderRadius.circular(30),
          minHeight: 170,
          isDraggable: false,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        CarouselSlider(
                          items: imgList.map((item) {
                            return Container(
                              margin: const EdgeInsets.all(5.0),
                              child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(5.0)),
                                  child: Stack(
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        imageUrl: item,
                                        width: 1000.w,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: imageProvider,
                                            ),
                                          ),
                                        ),
                                        // placeholder: (context, url) =>
                                        //     const Center(
                                        //         child:
                                        //             CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                                    ],
                                  )),
                            );
                          }).toList(),
                          carouselController: _controller,
                          options: CarouselOptions(
                              autoPlay: true,
                              viewportFraction: 1,
                              aspectRatio: 1.5,
                              onPageChanged: (index, reason) {
                                setState(() {
                                  _current = index;
                                });
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: imgList.asMap().entries.map((entry) {
                            return GestureDetector(
                              onTap: () => _controller.animateToPage(entry.key),
                              child: Container(
                                width: 8.0.w,
                                height: 8.0.h,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 4.0, horizontal: 4.0),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.4)),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Icon(AntIcons.starFilled, color: Colors.yellow),
                        SizedBox(width: 5.w),
                        Text(
                          "4.5 (760 Buyers)",
                          style: appStyle(
                              size: 14, color: mainBlack, fw: FontWeight.w600),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            "Nike Airmax K200",
                            style: appStyle(
                                size: 20,
                                color: mainBlack,
                                fw: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                        "This product is only available for a short period of time and this: This is a pretty long description so its hard to test this out and i dont know if I can get the description correctly",
                        style: appStyle(
                            size: 16, color: mainBlack, fw: FontWeight.w400)),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text("Category: ",
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600)),
                        SizedBox(width: 5.w),
                        Text("Indonesian Brand",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500))
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text("Sold By: ",
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600)),
                        SizedBox(width: 5.w),
                        Text("CurtainStudios.id",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500))
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Text("Created At: ",
                            style: appStyle(
                                size: 16,
                                color: mainBlack,
                                fw: FontWeight.w600)),
                        SizedBox(width: 5.w),
                        Text("Thursday, 27 February 2024",
                            style: appStyle(
                                size: 14,
                                color: mainBlack,
                                fw: FontWeight.w500))
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
