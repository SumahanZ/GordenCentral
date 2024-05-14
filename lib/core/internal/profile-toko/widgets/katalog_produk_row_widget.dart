import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tugas_akhir_project/models/katalog_produk.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class KatalogProdukRow extends ConsumerWidget {
  const KatalogProdukRow({
    super.key,
    required this.katalogProduk,
    required this.onTapNavigation,
  });

  final KatalogProduk katalogProduk;
  final void Function(int produkId) onTapNavigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20.h),
        Text(
          katalogProduk.name ??  "No name",
          style: appStyle(size: 18, color: mainBlack, fw: FontWeight.w600),
        ),
        SizedBox(
          height: 350.h,
          child: ListView.builder(
              physics: const ClampingScrollPhysics(),
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              primary: true,
              itemCount: katalogProduk.produkList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (katalogProduk.produkList.isNotEmpty) {
                      onTapNavigation(katalogProduk.produkList[index].id ?? 0);
                    }
                  },
                  child: SizedBox(
                    width: 200.w,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                          surfaceTintColor: Colors.white,
                          elevation: 5,
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    children: [
                                      Row(children: [
                                        if (katalogProduk
                                                    .produkList[index].promo !=
                                                null &&
                                            (katalogProduk.produkList[index]
                                                        .promo?.expiredAt ??
                                                    DateTime.now())
                                                .isAfter(DateTime.now()))
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            child: DecoratedBox(
                                              decoration: const BoxDecoration(
                                                color: Colors.deepPurpleAccent,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 6.0,
                                                        horizontal: 10),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "${katalogProduk.produkList[index].promo?.discountPercent}% OFF",
                                                        style: appStyle(
                                                            size: 13,
                                                            color: Colors.white,
                                                            fw: FontWeight
                                                                .w600)),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                      ]),
                                      const Spacer(),
                                      if ((DateTime.now()).isBefore(
                                          (katalogProduk.produkList[index]
                                                      .createdAt ??
                                                  DateTime.now())
                                              .add(const Duration(days: 7))))
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          child: DecoratedBox(
                                            decoration: const BoxDecoration(
                                              color: Colors.red,
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 6.0,
                                                      horizontal: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text("BARU",
                                                      style: appStyle(
                                                          size: 13,
                                                          color: Colors.white,
                                                          fw: FontWeight.w600)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: SizedBox(
                                      width: double.infinity,
                                      child: CachedNetworkImage(
                                        imageUrl: katalogProduk
                                            .produkList[index]
                                            .produkGlobalImages[0]
                                            .globalImageUrl,

                                        height: 120.h,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: imageProvider,
                                              fit: BoxFit.fitWidth,
                                            ),
                                          ),
                                        ),
                                        // placeholder: (context, url) =>
                                        //     const Center(child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      )),
                                ),
                                const Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(6.0),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                          katalogProduk
                                                  .produkList[index].name ??
                                              "No Name",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: appStyle(
                                              size: 14,
                                              color: mainBlack,
                                              fw: FontWeight.w600),
                                          textAlign: TextAlign.center),
                                      SizedBox(height: 5.h),
                                      Text(
                                        PriceFormatter.getFormattedValue(katalogProduk
                                                        .produkList[index]
                                                        .promo ==
                                                    null ||
                                                (katalogProduk.produkList[index]
                                                            .promo?.expiredAt ??
                                                        DateTime.now())
                                                    .isBefore(DateTime.now())
                                            ? katalogProduk.produkList[index].price ??
                                                0
                                            : (katalogProduk.produkList[index]
                                                        .price ??
                                                    0) -
                                                (katalogProduk.produkList[index]
                                                            .price ??
                                                        0) *
                                                    (katalogProduk
                                                            .produkList[index]
                                                            .promo!
                                                            .discountPercent!
                                                            .toInt() /
                                                        100)),
                                        style: appStyle(
                                            size: 16,
                                            color: mainBlack,
                                            fw: FontWeight.bold),
                                      ),
                                      SizedBox(height: 5.h),
                                      // if(katalogProduk.produkList[index].rating.isNotEmpty)
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            itemSize: 16,
                                            initialRating: katalogProduk
                                                    .produkList[index].averageRating ??
                                                0,
                                            minRating: 0,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 2.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {},
                                          ),
                                          SizedBox(width: 5.w),
                                          Text(
                                            "(${katalogProduk.produkList[index].averageRating?.toStringAsPrecision(2) ?? 0})",
                                            style: appStyle(
                                                size: 11,
                                                color: mainBlack,
                                                fw: FontWeight.w600),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 5.h),
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ]),
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ],
    );
  }
}
