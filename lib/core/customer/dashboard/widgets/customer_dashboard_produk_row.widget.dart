import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tugas_akhir_project/models/produk.dart';
import 'package:tugas_akhir_project/utils/extensions/double_extension.dart';
import 'package:tugas_akhir_project/utils/styles/appStyles.dart';
import 'package:tugas_akhir_project/utils/styles/colorStyles.dart';

class CustomerDashboardProdukRow extends ConsumerWidget {
  const CustomerDashboardProdukRow({
    super.key,
    required this.produkList,
    this.onTapNavigation,
  });

  final List<Produk> produkList;
  final void Function(int produkId, int tokoId)? onTapNavigation;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      height: 350,
      child: produkList.isEmpty
          ? Center(
              child: Text("Produk kosong",
                  style: appStyle(
                      size: 16, color: mainBlack, fw: FontWeight.w600)))
          : ListView.builder(
              // physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(10),
              shrinkWrap: true,
              primary: true,
              itemCount: produkList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    if (produkList.isNotEmpty) {
                      onTapNavigation!(produkList[index].id ?? 0,
                          produkList[index].toko?.id ?? 0);
                    }
                  },
                  child: SizedBox(
                    width: 200,
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
                                        if (produkList[index].promo != null &&
                                            (produkList[index]
                                                        .promo
                                                        ?.expiredAt ??
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
                                                        "${produkList[index].promo?.discountPercent}% OFF",
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
                                          (produkList[index].createdAt ??
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
                                        imageUrl: produkList[index]
                                            .produkGlobalImages[0]
                                            .globalImageUrl,

                                        height: 120,
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
                                      Text(produkList[index].name ?? "No Name",
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: appStyle(
                                              size: 14,
                                              color: mainBlack,
                                              fw: FontWeight.w600),
                                          textAlign: TextAlign.center),
                                      const SizedBox(height: 5),
                                      Text(
                                        PriceFormatter.getFormattedValue(
                                            produkList[index].promo == null ||
                                                    (produkList[index]
                                                                .promo
                                                                ?.expiredAt ??
                                                            DateTime.now())
                                                        .isBefore(
                                                            DateTime.now())
                                                ? produkList[index].price ?? 0
                                                : (produkList[index].price ??
                                                        0) -
                                                    (produkList[index].price ??
                                                            0) *
                                                        (produkList[index]
                                                                .promo!
                                                                .discountPercent!
                                                                .toInt() /
                                                            100)),
                                        style: appStyle(
                                            size: 16,
                                            color: mainBlack,
                                            fw: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      if (produkList[index].rating.isNotEmpty)
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RatingBar.builder(
                                              ignoreGestures: true,
                                              itemSize: 16,
                                              initialRating: produkList[index]
                                                      .rating
                                                      .first
                                                      .averageRating ??
                                                  1,
                                              minRating: 1,
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
                                            const SizedBox(width: 5),
                                            Text(
                                              "(${produkList[index].rating.first.averageRating?.toStringAsPrecision(2)})",
                                              style: appStyle(
                                                  size: 11,
                                                  color: mainBlack,
                                                  fw: FontWeight.w600),
                                            ),
                                          ],
                                        ),
                                      const SizedBox(height: 5),
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
    );
  }
}
